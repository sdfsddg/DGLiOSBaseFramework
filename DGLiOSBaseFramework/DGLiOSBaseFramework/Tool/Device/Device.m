//
//  Device.m
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import "Device.h"

#import <sys/utsname.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AdSupport/AdSupport.h>
//#import

static NSString*  passwordService = @"com.maibang.mbaclub";

static NSString *uuid = @"uuid";

static NSString *currentDeviceUUIDStr = nil;

static NSString *deviceInfo = nil;

@interface Device(){
    
    
}

@end

@implementation Device

+ (NSString *)getDeviceId {
    if (currentDeviceUUIDStr == nil) {
//        currentDeviceUUIDStr = [YYKeychain getPasswordForService:passwordService account:uuid];
//        if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
//        {
//            NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
//            currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
//            currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
//            currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
//            [YYKeychain setPassword:currentDeviceUUIDStr forService:passwordService account:uuid];
//        }
    }
    return currentDeviceUUIDStr;
}



+ (NSString *)private_getDeviceInfo {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"] ||
        [platform isEqualToString:@"iPhone3,2"] ||
        [platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"] ||
        [platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"] ||
        [platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    if ([platform isEqualToString:@"iPhone6,1"] ||
        [platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"] ||
        [platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"] ||
        [platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";
    if ([platform isEqualToString:@"iPhone10,1"] ||
        [platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"] ||
        [platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([platform isEqualToString:@"iPhone10,3"] ||
        [platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([platform isEqualToString:@"iPhone11,8"]) return @"iPhone XR";
    if ([platform isEqualToString:@"iPhone11,2"]) return @"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"] ||
        [platform isEqualToString:@"iPhone11,6"]) return @"iPhone XS Max";
    //------------------------------iPad--------------------------
    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"] ||
        [platform isEqualToString:@"iPad2,2"] ||
        [platform isEqualToString:@"iPad2,3"] ||
        [platform isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([platform isEqualToString:@"iPad3,1"] ||
        [platform isEqualToString:@"iPad3,2"] ||
        [platform isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([platform isEqualToString:@"iPad3,4"] ||
        [platform isEqualToString:@"iPad3,5"] ||
        [platform isEqualToString:@"iPad3,6"]) return @"iPad 4";
    if ([platform isEqualToString:@"iPad4,1"] ||
        [platform isEqualToString:@"iPad4,2"] ||
        [platform isEqualToString:@"iPad4,3"]) return @"iPad Air";
    if ([platform isEqualToString:@"iPad5,3"] ||
        [platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,3"] ||
        [platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7-inch";
    if ([platform isEqualToString:@"iPad6,7"] ||
        [platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9-inch";
    if ([platform isEqualToString:@"iPad6,11"] ||
        [platform isEqualToString:@"iPad6,12"]) return @"iPad 5";
    if ([platform isEqualToString:@"iPad7,1"] ||
        [platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9-inch 2";
    if ([platform isEqualToString:@"iPad7,3"] ||
        [platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5-inch";
    //------------------------------iPad Mini-----------------------
    if ([platform isEqualToString:@"iPad2,5"] ||
        [platform isEqualToString:@"iPad2,6"] ||
        [platform isEqualToString:@"iPad2,7"]) return @"iPad mini";
    if ([platform isEqualToString:@"iPad4,4"] ||
        [platform isEqualToString:@"iPad4,5"] ||
        [platform isEqualToString:@"iPad4,6"]) return @"iPad mini 2";
    if ([platform isEqualToString:@"iPad4,7"] ||
        [platform isEqualToString:@"iPad4,8"] ||
        [platform isEqualToString:@"iPad4,9"]) return @"iPad mini 3";
    if ([platform isEqualToString:@"iPad5,1"] ||
        [platform isEqualToString:@"iPad5,2"]) return @"iPad mini 4";
    //------------------------------iTouch------------------------
    if ([platform isEqualToString:@"iPod1,1"]) return @"iTouch";
    if ([platform isEqualToString:@"iPod2,1"]) return @"iTouch2";
    if ([platform isEqualToString:@"iPod3,1"]) return @"iTouch3";
    if ([platform isEqualToString:@"iPod4,1"]) return @"iTouch4";
    if ([platform isEqualToString:@"iPod5,1"]) return @"iTouch5";
    if ([platform isEqualToString:@"iPod7,1"]) return @"iTouch6";
    //------------------------------Samulitor-------------------------------------
    if ([platform isEqualToString:@"i386"] ||
        [platform isEqualToString:@"x86_64"]) return @"iPhone Simulator";
    return @"Unknown";
}

+ (NSString *)getDeviceInfo {
    if (deviceInfo == nil) {
        deviceInfo = [self private_getDeviceInfo];
    }
    return deviceInfo;
}


+ (NSString *)getDeviceIDFA {
    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return idfa;
}


+ (NSString *)getDeviceOSVersion {
    NSString *osVersion = [UIDevice currentDevice].systemVersion;
    return osVersion;
}


+ (BOOL)devicePhotoAuthorization {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (BOOL)deviceCameraAuthorization {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (BOOL)deviceMicrophoneAuthorization{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied)  {
        return NO;
    }
    return YES;
}

+ (BOOL)deviceNotificationAuthorization {
    if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  ==UIUserNotificationTypeNone) {
        return NO;
    }
    return YES;
}

+ (BOOL)deviceisJailBreak {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://"]]) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:@"User/Applications/"]) {
            NSLog(@"The device is jail broken!");
            NSLog(@"appList = %@", [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"User/Applications/" error:nil]);
            return YES;
        }
        NSLog(@"The device is NOT jail broken!");
        return NO;
    }
    NSLog(@"The device is NOT jail broken!");
    return NO;
}


+(NSString *)getAppName {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    return app_Name;
}


@end
