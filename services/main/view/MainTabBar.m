//
//  MainTabBar.m
//  services
//
//  Created by lqzhuang on 17/4/29.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MainTabBar.h"
#import "TabBarButton.h"
#import "TabBarCenterButton.h"

@implementation MainTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(NSArray *)items {
    if (!_items) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (NSDictionary *dict in [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mainTabBarItems" ofType:@"plist"]]) {
            [tmpArr addObject:[MainBarItem barItem:dict]];
        }
        _items = tmpArr;
    }
    return _items;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initBarItems];
        self.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    }
    return self;
}

-(void)initBarItems
{
    int index = 0;
    CGSize size = self.frame.size;
    CGFloat margin = 0;
    CGFloat centerBtnWidthAdd = 10;
    CGFloat barItemWidth = size.width / self.items.count;
    CGFloat btnWidth = size.height - 2 * margin;
    
    for (MainBarItem *item in self.items) {
        UIButton *btn;
        if (item.title) {
            btn = [TabBarButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(index * barItemWidth + (barItemWidth - btnWidth) * 0.5, margin, btnWidth, btnWidth);
            [btn addTarget:self action:@selector(tabBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = item.tag;
        } else {
            btn = [TabBarCenterButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(index * barItemWidth + (barItemWidth - btnWidth) * 0.5, margin, btnWidth + centerBtnWidthAdd * 2, btnWidth);
            [btn addTarget:self action:@selector(tabBarCenterButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [btn setImage:[UIImage imageNamed:item.icon] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:item.iconSelected] forState:UIControlStateHighlighted];
        [btn setImage:[UIImage imageNamed:item.iconSelected] forState:UIControlStateSelected];
        if (item.title) {
            [btn setTitle:item.title forState:UIControlStateNormal];
        }
        if (item.backgroundImage) {
            [btn setBackgroundImage:[UIImage imageNamed:item.backgroundImage] forState:UIControlStateNormal];
        }
        if (item.backgroundImageSelected) {
            [btn setBackgroundImage:[UIImage imageNamed:item.backgroundImageSelected] forState:UIControlStateHighlighted];
        }
        
        [self addSubview:btn];
        if (index == 0) {
            self.btnSelected = btn;
            btn.selected = YES;
            btn.badgeValue = @" ";
            
//            NSLog(@"%.2f", btn.badgePadding);
        }
//        [btn setBackgroundColor:[UIColor yellowColor]];
        
        index ++;
    }
}

-(void)tabBarButtonClicked:(UIButton *)btn
{
    btn.selected = YES;
    self.btnSelected.selected = NO;
    self.btnSelected = btn;
    if ([self.mainTabBarDelegate respondsToSelector:@selector(tabBarButtonClicked:)]) {
        [self.mainTabBarDelegate performSelector:@selector(tabBarButtonClicked:) withObject:btn];
    }
}

-(void)tabBarCenterButtonClicked:(UIButton *)btn
{
    if ([self.mainTabBarDelegate respondsToSelector:@selector(tabBarCenterButtonClicked:)]) {
        [self.mainTabBarDelegate performSelector:@selector(tabBarCenterButtonClicked:) withObject:btn];
    }
}

@end
