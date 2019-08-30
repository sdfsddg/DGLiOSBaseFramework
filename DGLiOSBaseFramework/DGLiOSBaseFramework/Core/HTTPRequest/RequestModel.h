//
//  RequestModel.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
  当前请求类型

 - HTTPRequestGetType: get 请求
 - HTTPRequestPostType: post 请求
 - HTTPRequestUploadType: 上传文件请求
 */
typedef NS_ENUM(NSUInteger, HTTPRequestType) {
    HTTPRequestGetType,
    HTTPRequestPostType,
    HTTPRequestUploadType,
};

/**
  当前请求数据类型

 - HTTPRequestDataTypeJsonType: json 数据返回
 - HTTPRequestDataTypeForm_DataType: form-data 数据返回
 - HTTPRequestDataTypeForm_UrlencodedType: form_Urlencoded 数据返回
 */
typedef NS_ENUM(NSUInteger, HTTPRequestDataType) {
    HTTPRequestDataTypeJsonType,
    HTTPRequestDataTypeForm_DataType,
    HTTPRequestDataTypeForm_UrlencodedType,
};

/**
 返回数据类型

 - HTTPResponseDataTypeJson: 返回数据类型的回调
 */
typedef NS_ENUM(NSUInteger, HTTPResponseDataType) {
    HTTPResponseDataJsonType,
};


/**
 当前的网络请求的错误码

 - RequestUrlError: 网络请求的错误码
 */
typedef NS_ENUM(NSUInteger, RequestErrorCode) {
    RequestUrlError = 901,
};

NS_ASSUME_NONNULL_BEGIN

@interface RequestModel : NSObject

/**
 请求类型
 */
@property (nonatomic, assign) HTTPRequestType  requestType;
/**
  请求数据类型
 */
@property (nonatomic, assign) HTTPRequestDataType  requestDataType;

/**
 请求的数据返回类型
 */
@property (nonatomic, assign) HTTPResponseDataType  responseType;

/**
 请求参数
 */
@property (nonatomic, strong) NSDictionary * requestParameter;

/**
 请求头部参数
 */
@property (nonatomic, strong) NSDictionary  * requestHeaderParameter;

/**
  请求路径
 */
@property (nonatomic, copy) NSString  * urlPath;

@property (nonatomic, copy) NSString * url;

@property (nonatomic, copy) NSString * domain;


/**
 工厂模式创建一个 post 请求 返回数据 json  请求类型 form-data

 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestPostWithFormDataParameter:(NSDictionary *)parameter andUrl:(NSString *)url;

/**
 工厂模式创建一个 post 请求 返回数据 json  请求类型 json
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestPostWithJsonParameter:(NSDictionary *)parameter andUrl:(NSString *)url;

/**
 工厂模式创建一个 post 请求 返回数据 json  请求类型 formUrlencoded
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestPostWithFormUrlencodedParameter:(NSDictionary *)parameter andUrl:(NSString *)url;

/**
 工厂模式创建一个 Get 请求 返回数据 json
 
 @param parameter 当前请求的参数
 @param url 当前的 url
 @return  当前创建的请类
 */
+ (RequestModel *)requestGetWithParameter:(NSDictionary *)parameter andUrl:(NSString *)url;



/**
 当前上传的类型
 */
@property (nonatomic, copy)NSString *mimeType;
/**
 当前上传的文件 NSData 数组
 */
@property (nonatomic,strong)NSArray <NSData *>*fileDataArray;

@property (nonatomic,strong)NSData *fileData;

/**
 当前上传的 文件名
 */
@property (nonatomic,strong)NSArray <NSString *>*fileNameArray;

@property (nonatomic,strong)NSString *fileName;

/**
 快捷方式 上传image
 
 @param imageData 当前的 imageData
 @param parameter 当前的请求参数
 @param url 当前的请求链接
 @return 返回请求实体类
 */
+ (RequestModel *)requestUploadFileWithImageData:(NSData *)imageData andParameter:(NSDictionary *)parameter andUrl:(NSString *)url;

@end

//@interface RequestModel(){
//    
//}
//
//
//
//
//@end

NS_ASSUME_NONNULL_END
