//
//  UIColor+SJColor.h
//  project_test
//
//  Created by 陈剑 on 2018/7/4.
//  Copyright © 2018年 陈剑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Color)

/**
 返回十六进制色值
 
 @param hex 十六进制数字
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hex;

+ (UIColor *)colorWithHexString:(NSString *)hex alpha:(CGFloat)alpha;


@end
