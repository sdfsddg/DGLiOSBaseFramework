//
//  ResponseModel.m
//  DGLiOSBaseFramework
//
//  Created by 陈剑 on 2019/8/29.
//  Copyright © 2019 陈剑. All rights reserved.
//

#import "ResponseModel.h"
@interface ResponseModel(){
    
    NSString *_message;
    NSString *_msg;
    NSDictionary *_data;
}



@end

@implementation ResponseModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    if (self) {
        if ([dictionary isKindOfClass:[NSArray class]]) {
            [self setValuesForKeysWithDictionary:@{@"responseObject":dictionary}];
        } else if([dictionary isKindOfClass:[NSDictionary  class]]) {
            [self setValuesForKeysWithDictionary:dictionary];
        } else {
            [self setValuesForKeysWithDictionary:@{@"responseStringObject":[NSString stringWithFormat:@"%@",dictionary]}];
        }
    }
    return self;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"result"]) {
        if ([value intValue] == 0) {
            _code = [NSNumber numberWithInt:200];
        } else {
            _code = [NSNumber numberWithInt:[value intValue]];
            
        }
    }
}

- (void)setMessage:(NSString *)message {
    _msg = message;
    _message = message;
}


- (void)setMsg:(NSString *)msg {
    _message = msg;
    _msg = msg;
}

- (NSString *)msg {
    if (![_msg isKindOfClass:[NSString class]]) {
        return @"暂无消息";
    }
    return _msg;
}


- (NSString *)message {
    
    return [self msg];
}

- (void)setData:(NSDictionary *)data {
    if ([data isKindOfClass:[NSArray class]]) {
        _data =  @{kNetworkResponseArrayKey :data};
    } else if ([data isKindOfClass:[NSString class]]) {
        _data =  @{kNetworkResponseStringKey :data};
    }else if ([data isKindOfClass:[NSDictionary class]]) {
        _data =  data;
    } else {
        _data =  @{};
    }
}

- (NSDictionary *)data {
    if (_data == nil || [_data isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    return _data;
}

@end
