//
//  UIImage+SJImage.m
//  project_test
//
//  Created by 陈剑 on 2018/7/4.
//  Copyright © 2018年 陈剑. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)


+ (UIImage *)imageWithColor:(UIColor *)color {
    
    return [self imageWithColor:color size:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 截取图片
 
 @param view 截图的屏幕layer
 @param rect 截取范围
 @return 图片
 */
+ (UIImage *)imageWithClipView:(UIView *)view rect:(CGRect)rect {
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // 像素rect 转化为 点rect 否则将会是按原图像素部分截取了
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = rect.origin.x * scale;
    CGFloat y = rect.origin.y * scale;
    CGFloat w = rect.size.width * scale;
    CGFloat h = rect.size.height * scale;
    CGRect clipRect = CGRectMake(x, y, w, h);
    
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, clipRect);
    UIImage * newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:UIImageOrientationUp];
    
    return newImage;
}

+ (UIImage *)imageWithQRcodeImageUrl:(NSString *)url
                          imageWidth:(CGFloat)imageWidth {
    return [UIImage SG_generateWithDefaultQRCodeData:url imageViewWidth:imageWidth];
}

- (UIImage *)imageResizeTo:(CGSize)newSize {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [self drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize {
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(source_image, 1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1000;
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    //获取原图片宽高比
    CGFloat sourceImageAspectRatio = source_image.size.width / source_image.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024 / sourceImageAspectRatio);
    UIImage * newImage = [self newSizeImage:defaultSize image:source_image];
    finallImageData    = UIImageJPEGRepresentation(newImage, 1.0);
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg   = 1.0 / 250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i --) {
        value = i * avg;
        [compressionQualityArr addObject:@(value)];
    }
    /*
     调整大小
     说明：压缩系数数组compressionQualityArr是从大到小存储。
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth  = 100.0;
        CGFloat reduceHeight = 100.0 / sourceImageAspectRatio;
        if (defaultSize.width - reduceWidth <= 0 || defaultSize.height - reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width - reduceWidth, defaultSize.height - reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize
                                      image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage, [[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}

#pragma mark 调整图片分辨率/尺寸（等比例缩放）
+ (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    
    CGSize newSize     = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth  = newSize.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 二分法
+ (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end   = arr.count - 1;
    NSUInteger index = 0;
    NSUInteger difference = NSIntegerMax;
    
    while(start <= end) {
        index = start + (end - start) / 2;
        finallImageData = UIImageJPEGRepresentation(image, [arr[index] floatValue]);
        NSUInteger sizeOrigin   = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize - sizeOriginKB < difference) {
                difference = maxSize - sizeOriginKB;
                tempData   = finallImageData;
            }
            if (index <= 0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}
/**
 *  根据imageViewWidth等比缩放Image
 *
 *  @param image 传过来的图片
 *
 *  @return 返回的图片
 */
+ (UIImage *)imageCompressWithSimple:(UIImage *)image width:(CGFloat)imageViewWidth {
    CGSize size = image.size;
    CGFloat scale = 1.0;
    
    if (size.width > imageViewWidth) {
        scale = imageViewWidth / size.width;
    } else {
        return image;
    }
    CGFloat width = size.width;
    CGFloat height = size.height;
    CGFloat scaledWidth = width * scale;
    CGFloat scaledHeight = height * scale;
    CGSize secSize = CGSizeMake(scaledWidth, scaledHeight);
    
    UIGraphicsBeginImageContextWithOptions(secSize, NO, [UIScreen mainScreen].scale);
    //TODO:设置新图片的宽高
    //    UIGraphicsBeginImageContext(secSize); // this will crop
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 *  生成一张普通的二维码
 *
 *  @param data    传入你要生成二维码的数据
 *  @param imageViewWidth    图片的宽度
 */
+ (UIImage *)SG_generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth {
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 恢复滤镜的默认属性
    [filter setDefaults];
    // 2、设置数据
    NSString *info = data;
    // 将字符串转换成
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    return [UIImage createNonInterpolatedUIImageFormCIImage:outputImage withSize:imageViewWidth];
}

/** 根据CIImage生成指定大小的UIImage */
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}




/*
 以原图最短边为边长，居中裁剪 image 为正方形
 */
+ (UIImage *)centerClipImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    UIImage *srcImage = image;
    CGFloat val = 0.f;
    CGRect rect = CGRectZero;
    CGSize srcSize = srcImage.size;
    if ([@(srcSize.width) compare:@(srcSize.height)] == NSOrderedAscending) { // w < h
        val = srcSize.width;
        rect = CGRectMake(0.f, (srcSize.height - val) / 2.f, val, val);
    }
    else if ([@(srcSize.width) compare:@(srcSize.height)] == NSOrderedDescending) { // w > h
        val = srcSize.height;
        rect = CGRectMake((srcSize.width - val) / 2.f, 0.f, val, val);
    }
    else { // w = h
        return image;
    }
    CGImageRef cg = CGImageCreateWithImageInRect(srcImage.CGImage, rect);
    UIImage *clippedImage = [UIImage imageWithCGImage:cg];
    CGImageRelease(cg);
    return clippedImage;
}


+ (UIImage *)zipScaleWithImage:(UIImage *)sourceImage {
    
    NSLog(@"------------------------------------------------------------------------------------------------------------------------------------------------");
    NSLog(@"-------------------------------------------------------------压缩前的大小--------------------------------------------------------");
    [self calulateImageFileSize:sourceImage];
    NSLog(@"------------------------------------------------------------------------------------------------------------------------------------------------");

    CGFloat maxWidth = 1080;
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1280(宽高比不按照2来算，按照1来算)
    if (width>maxWidth && height>maxWidth) {
        if (width>height) {
            CGFloat scale = height/width;
            width = maxWidth;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = maxWidth;
            width = height*scale;
        }
        //2.宽大于1280高小于1280
    }else if(width>maxWidth&&height<maxWidth){
        CGFloat scale = height/width;
        width = maxWidth;
        height = width*scale;
        //3.宽小于1280高大于1280
    }else if(width<maxWidth && height>maxWidth){
        CGFloat scale = width/height;
        height = maxWidth;
        width = height*scale;
        //4.宽高都小于1280
    }
      height =   height *0.7;
      width =    width *0.7;
    //进行尺寸重绘
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *imageData = UIImageJPEGRepresentation(newImage, 0.1);
    newImage = [UIImage imageWithData:imageData];
    
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(newImage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(newImage, 0.3);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data=UIImageJPEGRepresentation(newImage, 0.4);
        }
    }
    
    newImage = [UIImage imageWithData:data];
    NSLog(@"------------------------------------------------------------------------------------------------------------------------------------------------");
    NSLog(@"-------------------------------------------------------------压缩后的大小--------------------------------------------------------");
    [self calulateImageFileSize:newImage];
    NSLog(@"------------------------------------------------------------------------------------------------------------------------------------------------");
    return newImage;
}


+ (void)calulateImageFileSize:(UIImage *)image {
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data = UIImageJPEGRepresentation(image, 1.0);//需要改成0.5才接近原图片大小，原因请看下文
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}


@end
