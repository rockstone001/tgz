//
//  LikeButton.m
//  services
//
//  Created by lqzhuang on 17/5/12.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "LikeButton.h"

@implementation LikeButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init
{
    if (self = [super init]) {
        [self setTitleColor:kLightGray forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:kSubTextSize];
//        [self setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}

@end
