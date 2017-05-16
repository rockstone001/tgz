//
//  ServiceInfo.h
//  services
//
//  Created by lqzhuang on 17/5/6.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceInfo : NSObject

@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *createdAt;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, copy) NSString *likes;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, assign) NSInteger ID;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)serviceInfo:(NSDictionary *)dict;


@end
