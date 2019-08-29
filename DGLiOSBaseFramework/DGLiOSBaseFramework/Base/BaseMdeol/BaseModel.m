//
//  BaseModel.m
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        [self  setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        _id_id = value;
    }
}


@end
