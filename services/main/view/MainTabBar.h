//
//  MainTabBar.h
//  services
//
//  Created by lqzhuang on 17/4/29.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainBarItem.h"

@protocol MainTabBarDelegate <NSObject>

-(void)tabBarButtonClicked:(UIButton *)btn;
-(void)tabBarCenterButtonClicked:(UIButton *)btn;

@end

@interface MainTabBar : UIView

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<MainTabBarDelegate> mainTabBarDelegate;
@property (nonatomic, weak) UIButton *btnSelected;


@end
