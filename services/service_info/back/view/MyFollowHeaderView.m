//
//  MyFollowHeaderView.m
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MyFollowHeaderView.h"
#define kHeaderHeight 200

@implementation MyFollowHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        frame.size.height = kHeaderHeight;
        self.frame = frame;
        self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

@end
