//
//  NavButton.h
//  services
//
//  Created by lqzhuang on 17/5/2.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
//定义导航栏中间的button的右边的箭头的宽度
#define kNavButtonImageWidth 16
//定义导航栏中间的下划线的高度
#define kNavLabelHeight 3
//定义下划线距离左右文字边距
#define kBottomLabelMargin 5

@interface NavButton : UIButton

@property (nonatomic,weak) UILabel *bottomLabel;

@end
