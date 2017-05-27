//
//  Coupon.h
//  services
//
//  Created by lqzhuang on 17/5/18.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponView : UIView

@property (nonatomic, weak) UIButton *textBtn;
@property (nonatomic, weak) UIButton *getBtn;

@property (nonatomic, assign) BOOL isExpired;

-(instancetype)initWithPrice:(NSString *)price withDesc:(NSString *)desc;
@end
