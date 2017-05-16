//
//  NavCenterBar.m
//  services
//
//  Created by lqzhuang on 17/5/2.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "NavCenterBar.h"
#import "NavButton.h"
//定义导航栏中间的button的宽度
//#define kNavButtonWidth 66
//定义导航栏中间的button的高度
#define kNavButtonHeight 40
//定义导航栏中间的下划线的宽度
#define kNavLabelWidth 40
//定义导航栏中间的view的button之间的间隔
#define kButtonMargin 10


@implementation NavCenterBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame btnTitleArray:(NSArray *)btnTitleArray
{
    CGFloat width = 0;
    for (NSString *str in btnTitleArray) {
        width += [str getStringWidth:kButtonFontSize];
    }
    width += kNavButtonImageWidth * btnTitleArray.count + kButtonMargin * (btnTitleArray.count - 1);
    CGFloat height = kNavButtonHeight;
    CGFloat x = (frame.size.width - width) * 0.5;
    CGFloat y = (frame.size.height - height) * 0.5;
    
    if (self = [super initWithFrame:CGRectMake(x, y, width, height)]) {
//        self.backgroundColor = [UIColor blueColor];
        
        [self addBtn:btnTitleArray];
        [self addLabel];
    }
    
    return self;
}

-(void)addBtn:(NSArray *)btnTitleArray
{
    NSMutableArray *tmpArr = [NSMutableArray array];
    NSInteger index = 0;
    CGFloat buttonWidthTotal = 0;
    for (NSString *title in btnTitleArray) {
        NavButton *btn = [[NavButton alloc] initWithFrame:CGRectMake(buttonWidthTotal, 0, [title getStringWidth:kButtonFontSize] + kNavButtonImageWidth, kNavButtonHeight)];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        
        [btn setImage:[UIImage imageNamed:@"arrow_triangle-down"] forState:UIControlStateSelected];
        
        btn.titleLabel.font = [UIFont systemFontOfSize:kButtonFontSize];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = index;
        [btn addTarget:self action:@selector(butonClicked:) forControlEvents:UIControlEventTouchUpInside];
//        btn.titleLabel.backgroundColor = [UIColor yellowColor];
        
        if (index == 0) {
            btn.selected = YES;
            self.btnSelcted = btn;
        }
        
        [self addSubview:btn];
        [tmpArr addObject:btn];
        
        buttonWidthTotal += [title getStringWidth:kButtonFontSize] + kNavButtonImageWidth + kButtonMargin;
        
        index ++;
    }
    self.btnArray = tmpArr;
}

-(void)addLabel
{
    UILabel *label = [[UILabel alloc] init];
    self.bottomLabel = label;
    
    label.frame = [self getBottomLabelRect];
    label.backgroundColor = [UIColor colorWithRed:253/255.0 green:130/255.0 blue:36/255.0 alpha:1];
    label.layer.cornerRadius = kNavLabelHeight * 0.5;
    label.layer.masksToBounds = YES;

    [self addSubview:label];
}

-(CGRect)getBottomLabelRect
{
    CGRect frame = CGRectMake(0, 0, 0, 0);
    for (NavButton *btn in self.btnArray) {
        if (btn.selected) {
            frame = btn.bottomLabel.frame;
            frame.origin.x += btn.frame.origin.x;
            frame.origin.y += btn.frame.origin.y;
            break;
        }
    }
    return frame;
}

-(void)butonClicked:(UIButton *)btn
{
    if ([self.navCenterBardelegate respondsToSelector:@selector(navCenterBar: buttonClicked:)]) {
        [self.navCenterBardelegate performSelector:@selector(navCenterBar: buttonClicked:) withObject:self withObject:btn];
    }
    self.btnSelcted.selected = NO;
    btn.selected = YES;
    self.btnSelcted = btn;
    [self bottomLabelAnimation];
}

-(void)bottomLabelAnimation
{
    CGRect frame = [self getBottomLabelRect];
    CGFloat x = frame.origin.x + frame.size.width * 0.5;
    CGFloat y = frame.origin.y + frame.size.height * 0.5;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomLabel.layer.position = CGPointMake(x, y);
    }];
}

-(void)btnChange:(NSInteger)index
{
    [self butonClicked:[self.btnArray objectAtIndex:index]];
}

@end
