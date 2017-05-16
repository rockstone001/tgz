//
//  TabBarButton.m
//  services
//
//  Created by lqzhuang on 17/4/29.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "TabBarButton.h"
#define kTextHeight 20

@implementation TabBarButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    self.titleLabel.font = [UIFont systemFontOfSize: 12.0];
    [self setTitleColor:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:253/255.0 green:130/255.0 blue:36/255.0 alpha:1] forState:UIControlStateSelected];
    [self setTitleColor:[UIColor colorWithRed:253/255.0 green:130/255.0 blue:36/255.0 alpha:1] forState:UIControlStateHighlighted];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize size = contentRect.size;
    return CGRectMake(0, size.height - kTextHeight, size.width, kTextHeight);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize size = contentRect.size;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = 0;
    if ((size.height - kTextHeight) < size.width) {
        width = size.height - kTextHeight;
        x = (size.width - width) * 0.5;
    } else {
        width = size.width;
        y = (size.height - kTextHeight - width) * 0.5;
    }
    return CGRectMake(x, y, width, width);
}

//-(void)setHighlighted:(BOOL)highlighted
//{}

@end
