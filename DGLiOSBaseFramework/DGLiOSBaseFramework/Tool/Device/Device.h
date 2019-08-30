//
//  Device.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Device : NSObject

/**
 获取设备 ID
 
 @return 设备 ID
 */
+ (NSString *)getDeviceId;

/**
 获取设备型号
 
 @return 当前设备型号
 */
+ (NSString *)getDeviceInfo;


/**
 获取设备广告标识符
 
 @return 设备广告标识符
 */
+ (NSString *)getDeviceIDFA;

/**
 获取设备当前系统版本
 
 @return 设备当前系统版本
 */
+ (NSString *)getDeviceOSVersion;

#pragma mark - 设备权限管理

/**
 判断是否有相册的访问权限
 
 @return YES 表示有 NO 表示没有
 */
+ (BOOL)devicePhotoAuthorization;

/**
 判断是否有相机的访问权限
 
 @return YES 表示有 NO 表示没有
 */
+ (BOOL)deviceCameraAuthorization;


/**
 判断是否有麦克风的访问权限
 
 @return YES 表示有 NO 表示没有
 */
+ (BOOL)deviceMicrophoneAuthorization;


/**
 判断推送是否有权限
 
 @return  YES 表示有 NO 表示没有
 */
+ (BOOL)deviceNotificationAuthorization;



/**
 判断当前设备是否越狱
 
 @return true 表示已经越狱  false 表示没有越狱
 */
+ (BOOL)deviceisJailBreak;


/***
 获取当前 app 的名称
 */
+ (NSString *)getAppName;

@end

NS_ASSUME_NONNULL_END
