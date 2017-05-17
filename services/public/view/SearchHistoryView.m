//
//  SearchHistoryView.m
//  services
//
//  Created by lqzhuang on 17/5/15.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchHistoryView.h"
#define kMargin 10
#define kCloseBtnMargin 5
#define kCloseBtnWidth 16
#define kBtnHeight 25
#define kMaxTextBtnWidth 180

@implementation SearchHistoryView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    NSLog(@"second");
    
}*/

-(instancetype)init
{
    NSArray *data = @[@"毛毛虫", @"折扣", @"优惠", @"樱桃", @"好喝的奶茶", @"女装新品"];
    if (self = [super init]) {
        self.data = [NSMutableArray arrayWithArray:data];
        [self setHistory];
    }
    return self;
}

-(void)setHistory
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGRect frame = [UIScreen mainScreen].bounds;
    CGFloat x = kMargin;
    CGFloat y = kMargin;
    CGFloat totalWidth = frame.size.width;
    NSInteger index = 0;
    for (NSString *key in self.data) {
        CGFloat width = [key getStringWidth:kSubTextSize] + kMargin + kCloseBtnMargin;
        width = width > kMaxTextBtnWidth ? kMaxTextBtnWidth : width;
        //文字
        if (x + width + kCloseBtnWidth + kCloseBtnMargin > totalWidth - kMargin) {
            x = kMargin;
            y += kMargin + kBtnHeight;
        }
        UIView *wrapper = [[UIView alloc] initWithFrame:CGRectMake(x, y, width + kCloseBtnWidth + kCloseBtnMargin, kBtnHeight)];
        wrapper.tag = index ++;
        wrapper.backgroundColor = kLightGrayBG;
        wrapper.layer.cornerRadius = 5;
        wrapper.layer.masksToBounds = YES;
        UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [textBtn setTitle:key forState:UIControlStateNormal];
        textBtn.frame = CGRectMake(0, 0, width, kBtnHeight);
        [textBtn setTitleColor:kLightGray forState:UIControlStateNormal];
        textBtn.titleLabel.font = [UIFont systemFontOfSize:kSubTextSize];
        //close图片
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        closeBtn.frame = CGRectMake(width, 0, kCloseBtnWidth, kBtnHeight);
        [wrapper addSubview:textBtn];
        [wrapper addSubview:closeBtn];
        [self addSubview:wrapper];
        x += width + kCloseBtnWidth + kMargin;
        
        //绑定事件
        [closeBtn addTarget:self action:@selector(removeHistory:) forControlEvents:UIControlEventTouchUpInside];
        [textBtn addTarget:self action:@selector(selectHistory:) forControlEvents:UIControlEventTouchUpInside];
    }
    y = self.data.count == 0 ? 0 : y + kBtnHeight + kMargin;
    frame.size.height = y;
    self.frame = frame;
    self.backgroundColor = [UIColor whiteColor];
}

-(void)removeHistory:(UIButton *)btn
{
    NSInteger index = btn.superview.tag;
    NSString *text = [self.data objectAtIndex:index];
    [self.data removeObjectAtIndex:index];
    [self setHistory];
    if ([self.delegate respondsToSelector:@selector(SearchHistory: closeBtnClicked:)]) {
        [self.delegate SearchHistory:self closeBtnClicked:text];
    }
}

-(void)selectHistory:(UIButton *)btn
{
    NSInteger index = btn.superview.tag;
    NSString *text = [self.data objectAtIndex:index];
    if ([self.delegate respondsToSelector:@selector(SearchHistory: textBtnClicked:)]) {
        [self.delegate SearchHistory:self textBtnClicked:text];
    }
}

@end
