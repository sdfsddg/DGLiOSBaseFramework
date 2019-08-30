//
//  UIFont+SJFont.m
//  project_test
//
//  Created by 陈剑 on 2018/7/4.
//  Copyright © 2018年 陈剑. All rights reserved.
//

#import "UIFont+Font.h"

@implementation UIFont (Font)


+(UIFont *)PingFangSC_HeavyWithSize:(CGFloat)fontSize{
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    if (nil == font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
    
}

+ (UIFont *)PingFangSC_MediumWitnSize:(CGFloat)fontSize {
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Medium" size:fontSize];
    if (nil == font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}


+ (UIFont *)PingFangSC_BoldWithSize:(CGFloat)fontSize {
    UIFont *font = [UIFont boldSystemFontOfSize:fontSize];
    if (nil == font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)PingFangSC_RegularWithSize:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:fontSize];
    if (nil == font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)PingFangSC_SemiboldWithSize:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Semibold" size:fontSize];
    if (nil == font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

+ (UIFont *)PingFangSC_LightWithSize:(CGFloat)fontSize {
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Light" size:fontSize];
    if (nil == font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}


@end
