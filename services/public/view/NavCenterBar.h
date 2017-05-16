//
//  NavCenterBar.h
//  services
//
//  Created by lqzhuang on 17/5/2.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NavCenterBar;

@protocol NavCenterBarDelegate <NSObject>

-(void)navCenterBar:(NavCenterBar *)navCenterBar buttonClicked:(UIButton *)btn;

@end

@interface NavCenterBar : UIView

@property (nonatomic, weak) UILabel *bottomLabel;
@property (nonatomic, strong) NSArray *btnArray;
@property (nonatomic, weak) id<NavCenterBarDelegate> navCenterBardelegate;
@property (nonatomic, weak) UIButton *btnSelcted;


-(instancetype)initWithFrame:(CGRect)frame btnTitleArray:(NSArray *)btnTitleArray;
-(void)btnChange:(NSInteger)index;


@end
