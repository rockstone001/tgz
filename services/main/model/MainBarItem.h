//
//  MainBarItem.h
//  services
//
//  Created by lqzhuang on 17/4/29.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainBarItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *iconSelected;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *backgroundImage;
@property (nonatomic, copy) NSString *backgroundImageSelected;
@property (nonatomic, assign) NSInteger tag;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)barItem:(NSDictionary *)dict;

@end
