//
//  Merchant.h
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Merchant : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *follows;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *imageWidth;
@property (nonatomic, copy) NSString *imageHeight;
@property (nonatomic, copy) NSString *desc;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)merchant:(NSDictionary *)dict;

@end
