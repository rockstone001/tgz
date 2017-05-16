//
//  TabBarCenterButton.m
//  services
//
//  Created by lqzhuang on 17/4/29.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "TabBarCenterButton.h"

@implementation TabBarCenterButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize size = contentRect.size;
    CGFloat width = size.height - 5 * 2;
    CGFloat x = (size.width - width) * 0.5;
    CGFloat y = (size.height - width) * 0.5;
    
    return CGRectMake(x, y, width, width);
}


@end
