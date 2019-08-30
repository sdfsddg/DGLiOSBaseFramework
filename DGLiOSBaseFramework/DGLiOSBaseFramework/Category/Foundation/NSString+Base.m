//
//  NSString+Base.m
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import "NSString+Base.h"

@implementation NSString (Base)

- (BOOL)deside_Url{
    NSURL * url = [NSURL URLWithString:self];
    if (url == nil) {
        return false;
    }
    NSString * scheme = url.scheme;
    NSArray * effectiveScheme = @[@"http",@"https",@"ftp",@"rtsp"];
    BOOL isUrl = [effectiveScheme containsObject:scheme];
    return isUrl;
}


@end
