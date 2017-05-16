//
//  ServiceInfo.m
//  services
//
//  Created by lqzhuang on 17/5/6.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "ServiceInfo.h"

@implementation ServiceInfo

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.text = dict[@"text"];
        self.avatar = dict[@"avatar"];
        self.username = dict[@"username"];
        self.createdAt = dict[@"created_at"];
        self.images = dict[@"images"];
    }
    return self;
}

+(instancetype)serviceInfo:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
