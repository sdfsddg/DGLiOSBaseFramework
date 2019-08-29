//
//  HTTPRequest.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RequestModel;
@class ResponseModel;

@interface HTTPRequest : NSObject

/**
 当前请求的返回

 @param isSuccess 网络请求是否成功
 @param responseModel 当前返回的 responseModel
 */
typedef void  (^NetworkResponseBlock)(BOOL isSuccess,ResponseModel *responseModel,NSURLSessionDataTask * task);

+ (instancetype)shareRequest;

/**
 当前是否可以连接到网络

 @return 是否可以联网
 */
+ (BOOL)isConnectToNetwork;

/**
 发起网络请求

 @param requestModel 发起网络请求的 model
 @param completeBlock 发起网络请求的回调
 */
- (void)requestWithRequestModel:(RequestModel *)requestModel andCompleteBlock:(NetworkResponseBlock)completeBlock;


@end

NS_ASSUME_NONNULL_END
