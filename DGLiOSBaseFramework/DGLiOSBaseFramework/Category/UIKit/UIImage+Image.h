//
//  UIImage+SJImage.h
//  project_test
//
//  Created by 陈剑 on 2018/7/4.
//  Copyright © 2018年 陈剑. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 截取图片
 
 @param view 截图的屏幕layer
 @param rect 截取范围
 @return 图片
 */
+ (UIImage *)imageWithClipView:(UIView *)view rect:(CGRect)rect;

+ (UIImage *)imageWithQRcodeImageUrl:(NSString *)url
                          imageWidth:(CGFloat)imageWidth;


/**
 绘制图片 指定大小
 
 @param newSize 指定大小
 @return image
 */
- (UIImage *)imageResizeTo:(CGSize)newSize;

/**
 *  根据imageViewWidth等比缩放Image
 *
 *  @param image 传过来的图片
 *
 *  @return 返回的图片
 */
+ (UIImage *)imageCompressWithSimple:(UIImage *)image width:(CGFloat)imageViewWidth;



@end
