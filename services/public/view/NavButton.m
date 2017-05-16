//
//  NavButton.m
//  services
//
//  Created by lqzhuang on 17/5/2.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "NavButton.h"

@implementation NavButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGSize size = contentRect.size;
    CGFloat x = size.width - kNavButtonImageWidth;
    CGFloat y = (size.height - kNavButtonImageWidth) * 0.5;
    return CGRectMake(x, y, kNavButtonImageWidth, kNavButtonImageWidth);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGSize size = contentRect.size;
    CGFloat width = size.width - kNavButtonImageWidth;
    return CGRectMake(0, 0, width, size.height);
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        CGSize size = frame.size;
        CGFloat x = kBottomLabelMargin;
        CGFloat y = size.height - kNavLabelHeight;
        CGFloat width = size.width - kNavButtonImageWidth - kBottomLabelMargin * 2;
        CGFloat height = kNavLabelHeight;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, width, height)];
//        label.backgroundColor = [UIColor colorWithRed:253/255.0 green:130/255.0 blue:36/255.0 alpha:1];
//        label.layer.cornerRadius = kNavLabelHeight * 0.5;
//        label.layer.masksToBounds = YES;
        label.hidden = YES;
        self.bottomLabel = label;
        [self addSubview:label];
    }
    return self;
}


//-(instancetype)init
//{
//    
//}

@end
