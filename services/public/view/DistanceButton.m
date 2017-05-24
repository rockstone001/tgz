//
//  DistanceButton.m
//  services
//
//  Created by lqzhuang on 17/5/23.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "DistanceButton.h"

@implementation DistanceButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat width = contentRect.size.height;
    return CGRectMake(0, 0, width, width);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat x = contentRect.size.height;
    CGFloat width = contentRect.size.width - x;
    return CGRectMake(x + 5, 0, width, x);
}

-(instancetype)init
{
    if (self = [super init]) {
        [self setTitleColor:kLightGray forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kSubTextSize];
    }
    return self;
}

@end
