//
//  RequestModel.m
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import "RequestModel.h"

@implementation RequestModel

- (NSString *)urlPath {
    return [NSString stringWithFormat:@"%@%@",self.domain,self.url];
}

- (NSDictionary *)requestParameter {
    if (_requestParameter == nil) {
        return @{};
    }
    return _requestParameter;
}

/**
 工厂模式创建一个 post 请求 返回数据 json  请求类型 form-data
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestPostWithFormDataParameter:(NSDictionary *)parameter andUrl:(NSString *)url {
    RequestModel *requestModel = [[RequestModel alloc]init];
    requestModel.requestParameter = parameter;
    requestModel.urlPath = url;
    requestModel.requestType = HTTPRequestPostType;
    requestModel.requestDataType = HTTPRequestDataTypeForm_DataType;
    requestModel.responseType = HTTPResponseDataJsonType;
    return  requestModel;
}

/**
 工厂模式创建一个 post 请求 返回数据 json  请求类型 json
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestPostWithJsonParameter:(NSDictionary *)parameter andUrl:(NSString *)url {
    RequestModel *requestModel = [[RequestModel alloc]init];
    requestModel.requestParameter = parameter;
    requestModel.urlPath = url;
    requestModel.requestType = HTTPRequestPostType;
    requestModel.requestDataType = HTTPRequestDataTypeJsonType;
    requestModel.responseType = HTTPResponseDataJsonType;
    return  requestModel;
}

/**
 工厂模式创建一个 post 请求 返回数据 json  请求类型 formUrlencoded
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestPostWithFormUrlencodedParameter:(NSDictionary *)parameter andUrl:(NSString *)url {
    RequestModel *requestModel = [[RequestModel alloc]init];
    requestModel.requestParameter = parameter;
    requestModel.urlPath = url;
    requestModel.requestType = HTTPRequestPostType;
    requestModel.requestDataType = HTTPRequestDataTypeForm_UrlencodedType;
    requestModel.responseType = HTTPResponseDataJsonType;
    return  requestModel;
}

/**
 工厂模式创建一个 Get 请求 返回数据 json
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestGetWithParameter:(NSDictionary *)parameter andUrl:(NSString *)url {
    RequestModel *requestModel = [[RequestModel alloc]init];
    requestModel.requestParameter = parameter;
    requestModel.urlPath = url;
    requestModel.requestType = HTTPRequestGetType;
    requestModel.requestDataType = HTTPRequestDataTypeForm_UrlencodedType;
    requestModel.responseType = HTTPResponseDataJsonType;
    return  requestModel;
}

/**
 快捷方式 上传image
 
 @param imageData 当前的 imageData
 @param parameter 当前的请求参数
 @param url 当前的请求链接
 @return 返回请求实体类
 */
+ (RequestModel *)requestUploadFileWithImageData:(NSData *)imageData andParameter:(NSDictionary *)parameter andUrl:(NSString *)url {
    RequestModel *requestModel = [[RequestModel alloc]init];
    requestModel.urlPath = url;
    requestModel.requestParameter = parameter;
    requestModel.fileData = imageData;
    requestModel.fileName = @"file";
    requestModel.mimeType = @"image/jpeg";
    requestModel.requestType = HTTPRequestUploadType;
    requestModel.requestDataType = HTTPRequestDataTypeJsonType;
    requestModel.responseType = HTTPResponseDataJsonType;
    return  requestModel;
}

@end
