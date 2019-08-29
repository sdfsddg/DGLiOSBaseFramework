//
//  BaseModel.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^RequestCompleteBlock)(BOOL isSuccess,NSString *message,NSInteger code);

@interface BaseModel : NSObject

@property (nonatomic, strong) NSNumber  * id_id;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
