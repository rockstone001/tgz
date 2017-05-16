//
//  MainBarItem.m
//  services
//
//  Created by lqzhuang on 17/4/29.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MainBarItem.h"

@implementation MainBarItem

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)barItem:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

@end
