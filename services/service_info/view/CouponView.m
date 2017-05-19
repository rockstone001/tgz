//
//  Coupon.m
//  services
//
//  Created by lqzhuang on 17/5/18.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "CouponView.h"
#define kCouponMargin 10
#define kCouponPriceFontSize 20
#define kCouponDescFonrSize 12
#define kCouponGetBtnFontSize 22
#define kCouponGetBtnText @"领取"

@implementation CouponView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithPrice:(NSString *)price withDesc:(NSString *)desc
{
    if (self = [super init]) {
        UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        textBtn.frame = CGRectMake(0, 0, kCoupoLeftWidth, kCouponHeight);
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kCouponMargin, 0, kCoupoLeftWidth - kCouponMargin, kCouponHeight * 0.6)];
        priceLabel.text = price;
        priceLabel.font = [UIFont systemFontOfSize:kCouponPriceFontSize];
        priceLabel.textColor = [UIColor whiteColor];
        
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.text = desc;
        CGSize size = [descLabel.text getSizeWithMaxSize:CGSizeMake(kCoupoLeftWidth - kCouponMargin * 2, kCouponHeight * 0.4) fontSize:kCouponDescFonrSize];
        descLabel.frame = CGRectMake(kCouponMargin, kCouponHeight * 0.6, size.width, size.height);
        descLabel.font = [UIFont systemFontOfSize:kCouponDescFonrSize];
        descLabel.textColor = [UIColor whiteColor];
        
        [textBtn addSubview:priceLabel];
        [textBtn addSubview:descLabel];
        [textBtn setBackgroundImage:[UIImage imageNamed:@"coupon_bg"] forState:UIControlStateNormal];
        [textBtn setBackgroundImage:[UIImage imageNamed:@"expire_bg"] forState:UIControlStateDisabled];
        
        UIButton *getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        getBtn.frame = CGRectMake(kCoupoLeftWidth, 0, kCouponRightWidth, kCouponHeight);
        getBtn.titleLabel.font = [UIFont systemFontOfSize:kCouponGetBtnFontSize];
        getBtn.titleLabel.numberOfLines = 0;
        [getBtn setTitle:[kCouponGetBtnText VerticalString] forState:UIControlStateNormal];
        
        [getBtn setBackgroundImage:[UIImage imageNamed:@"coupon_btn"] forState:UIControlStateNormal];
        [getBtn setBackgroundImage:[UIImage imageNamed:@"expire_btn"] forState:UIControlStateDisabled];
        
        self.textBtn = textBtn;
        self.getBtn = getBtn;
        
        [self addSubview:textBtn];
        [self addSubview:getBtn];
    }
    return self;
}

@end
