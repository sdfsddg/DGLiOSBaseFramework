//
//  UIColor+SJColor.m
//  project_test
//
//  Created by 陈剑 on 2018/7/4.
//  Copyright © 2018年 陈剑. All rights reserved.
//

#import "UIColor+Color.h"

@implementation UIColor (Color)

+ (UIColor *)colorWithHexString:(NSString *)hex {
    
    return [self  colorWithHexString:hex alpha:1];
}

+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha {
    NSRange range;
    range.location = 0;
    range.length = 1;
    NSString *first = [hex substringWithRange:range];
    if ([first isEqualToString:@"#"]) {
        hex = [hex substringFromIndex:1];
    }
    range.length = 2;
    NSString *rStr = [hex substringWithRange:range];
    range.location = 2;
    NSString *gStr = [hex substringWithRange:range];
    range.location = 4;
    NSString *bStr = [hex substringWithRange:range];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    return [UIColor colorWithRed:(float)r/255.00
                           green:(float)g/255.00
                            blue:(float)b/255.00
                           alpha:alpha];
}

@end
