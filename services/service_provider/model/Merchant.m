//
//  Merchant.m
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "Merchant.h"

@implementation Merchant

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)merchant:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
