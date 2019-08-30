//
//  ResponseModel.h
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const kNetworkResponseArrayKey = @"ResponseArrayKey";

static NSString * const kNetworkResponseStringKey = @"ResponseStringKey";

@interface ResponseModel : NSObject

@property (nonatomic, strong) NSNumber * code;
@property (nonatomic, strong) NSDictionary * data;
@property (nonatomic, copy) NSString * message;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end

NS_ASSUME_NONNULL_END
