//
//  HTTPRequest.m
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import "HTTPRequest.h"
#import <AFNetworking.h>
#import "Reachability.h"
#import "NSString+Base.h"
#import "RequestModel/RequestModel.h"
#import "ResponseModel/ResponseModel.h"
#import "HTTPRequestDefinedHeader.h"


@interface HTTPRequest(){
    
}

@property (nonatomic,strong)AFHTTPSessionManager *manager;

@property (nonatomic,strong)Reachability *routerReachability;

@property (nonatomic,strong)Reachability *hostReachability;

@end


static HTTPRequest *request = nil;
@implementation HTTPRequest

+ (instancetype)shareRequest {
    if (request == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            request = [[HTTPRequest alloc]init];
            [request afnReachabilityTest];
        });
    }
    return request;
}

#pragma mark - 初始化网络请求
- (void)requestWithRequestModel:(RequestModel *)requestModel andCompleteBlock:(NetworkResponseBlock)completeBlock {
    if (![requestModel.urlPath deside_Url]) {
        [self setErrorCode:RequestUrlError andMessage:RequestUrlErrorMessage andTask:nil andCompleteBlock:completeBlock];
        return;
    }
    if (requestModel.requestDataType ==HTTPRequestDataTypeJsonType) {
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
        self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    } else {
        self.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    
    [self handleRequestHeader:requestModel];
    if (requestModel.requestType == HTTPRequestPostType) {
        [self requestGetWithRequestModel:requestModel andCompleteBlock:completeBlock];
    } else if (requestModel.requestType == HTTPRequestGetType) {
        [self requestPostWithRequestModel:requestModel andCompleteBlock:completeBlock];
    } else if (requestModel.requestDataType == HTTPRequestUploadType) {
        
    }
}


#pragma mark - 内部私有函数

/**
 处理请求 header
 
 @param requestModel 处理请求的 header
 */
- (void)handleRequestHeader:(RequestModel *)requestModel {
    for (NSString *key in requestModel.requestHeaderParameter.allKeys) {
        NSString *value = requestModel.requestHeaderParameter[key];
        if (key != nil) {
            [self.manager.requestSerializer setValue:value forHTTPHeaderField:key];
        }
    }
}

/**
 get 请求
 
 @param requestModel 当前 post 请求的 model
 @param completeBlock 当前请求完毕的回调
 */
- (void)requestGetWithRequestModel:(RequestModel *)requestModel andCompleteBlock:(NetworkResponseBlock)completeBlock {
    [self.manager GET:requestModel.urlPath parameters:requestModel.requestParameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessWithResponse:responseObject  andTask:task andCompleteBlock:completeBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handlFailWithResponseError:error  andTask:task andCompleteBlock:completeBlock];
    }];
}

/**
 post 请求
 
 @param requestModel 当前 post 请求的 model
 @param completeBlock 当前请求完毕的回调
 */
- (void)requestPostWithRequestModel:(RequestModel *)requestModel andCompleteBlock:(NetworkResponseBlock)completeBlock {
    /***
     特殊的表单请求 form_urlencoded
     */
    if (requestModel.requestDataType == HTTPRequestDataTypeForm_DataType) {
        [self.manager POST:requestModel.urlPath parameters:requestModel.requestParameter constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccessWithResponse:responseObject andTask:task andCompleteBlock:completeBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handlFailWithResponseError:error andTask:task andCompleteBlock:completeBlock];
        }];
    }
    /***
     一般的表单请求 form_urlencoded
     */
    if (requestModel.requestDataType == HTTPRequestDataTypeForm_UrlencodedType) {
        [self.manager POST:requestModel.urlPath parameters:requestModel.requestParameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self handleSuccessWithResponse:responseObject andTask:task andCompleteBlock:completeBlock];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self handlFailWithResponseError:error andTask:task andCompleteBlock:completeBlock];
        }];
    }
}
#pragma mark - HTTP UPLoad 上传
- (void)uploadWithRequestInfo:(RequestModel *)requestModel andCompleteBlock:(NetworkResponseBlock)completeBlock {
    [self.manager POST:requestModel.urlPath parameters:requestModel.requestParameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (!requestModel.mimeType) {
            requestModel.mimeType = @"image/jpeg";
        }
        if (requestModel.fileDataArray) {
            for (int i = 0; i < requestModel.fileDataArray.count; i++) {
                [formData appendPartWithFileData:requestModel.fileDataArray[i] name:requestModel.fileNameArray[i] fileName:requestModel.fileNameArray[i] mimeType:requestModel.mimeType];
            }
        } else {
            [formData appendPartWithFileData:requestModel.fileData  name:requestModel.fileName fileName:[NSString stringWithFormat:@"%@",requestModel.fileName] mimeType:requestModel.mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    }  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self handleSuccessWithResponse:responseObject andTask:task andCompleteBlock:completeBlock];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self handlFailWithResponseError:error andTask:task andCompleteBlock:completeBlock];
    }];
}


/**
 处理接口请求成功的回调

 @param responseObject 当前返回的数据
 @param task 当前的 task
 @param completeBlock 当前的回调
 */
- (void)handleSuccessWithResponse:(id)responseObject andTask:(NSURLSessionDataTask * )task andCompleteBlock:(NetworkResponseBlock)completeBlock {
    NSDictionary *responseDictionay = responseObject;
    if (![responseDictionay isKindOfClass:[NSDictionary class]]) {
        responseDictionay = @{};
    }
    ResponseModel *responseModel = [[ResponseModel alloc]initWithDictionary:responseDictionay];
    completeBlock(true,responseModel,task);
}

/**
 处理接口请求失败的回调

 @param error 当前的 error
 @param task 当前的任务
 @param completeBlock 当前的回调
 */
- (void)handlFailWithResponseError:(NSError *)error  andTask:(NSURLSessionDataTask * )task andCompleteBlock:(NetworkResponseBlock)completeBlock {
    [self setErrorCode:error.code andMessage:error.localizedDescription andTask:task andCompleteBlock:completeBlock];
}

/**
 处理自定义错误请求
 
 @param code 当前的 code
 @param message 当前的信息
 @param completeBlock 当前的回调
 @return 返回数据
 */
- (ResponseModel *)setErrorCode:(NSInteger)code andMessage:(NSString *)message andTask:task  andCompleteBlock:(NetworkResponseBlock)completeBlock {
    ResponseModel *resModel = [[ResponseModel alloc]init];
    resModel.code = @(code);
    resModel.message = message;
    completeBlock(false,resModel,task);
    return  resModel;
}


#pragma mark - 网络状态监测
+ (BOOL)isConnectToNetwork {
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

- (void)afnReachabilityTest {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 一共有四种状态
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"AFNetworkReachability Not Reachable");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"AFNetworkReachability Reachable via WWAN");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"AFNetworkReachability Reachable via WiFi");
                break;
            case AFNetworkReachabilityStatusUnknown:
            default:
                NSLog(@"AFNetworkReachability Unknown");
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)openNetworkReachability {
    request.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [request.hostReachability startNotifier];
    request.routerReachability =  [Reachability reachabilityForInternetConnection];
    [request.routerReachability startNotifier];
    [[NSNotificationCenter defaultCenter] addObserver:request
                                             selector:@selector(appReachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
}
- (void)appReachabilityChanged:(NSNotification *)notification{
    Reachability *reach = [notification object];
    if([reach isKindOfClass:[Reachability class]]){
        NetworkStatus status = [reach currentReachabilityStatus];
        // 两种检测:路由与服务器是否可达  三种状态:手机流量联网、WiFi联网、没有联网
        if (reach == self.routerReachability) {
            if (status == NotReachable) {
                /**当前无网络链接*/
                NSLog(@"网络状态发生变化 ==============routerReachability NotReachable");
            } else if (status == ReachableViaWiFi) {
                NSLog(@"网络状态发生变化 ==============routerReachability ReachableViaWiFi");
            } else if (status == ReachableViaWWAN) {
                NSLog(@"网络状态发生变化 ==============routerReachability ReachableViaWWAN");
            }
        }
        if (reach == self.hostReachability) {
            if ([reach currentReachabilityStatus] == NotReachable) {
                NSLog(@"网络状态发生变化 ==============hostReachability failed");
                /**当前无网络链接*/
            } else if (status == ReachableViaWiFi) {
                NSLog(@"网络状态发生变化 ==============hostReachability ReachableViaWiFi");
            } else if (status == ReachableViaWWAN) {
                NSLog(@"网络状态发生变化 ==============hostReachability ReachableViaWWAN");
            }
        }
    }
}

#pragma mark - 懒加载
- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
        [NSURLCache setSharedURLCache:cache];
        _manager  = [AFHTTPSessionManager manager];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
        // 客户端是否信任非法证书
        securityPolicy.allowInvalidCertificates = YES;
        // 是否在证书域字段中验证域名
        securityPolicy.validatesDomainName = NO;
        _manager.securityPolicy = securityPolicy;
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10.0f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    }
    return _manager;
}


@end

