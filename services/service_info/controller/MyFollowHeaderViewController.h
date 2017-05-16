//
//  MyFollowHeaderViewController.h
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFollowHeaderViewController : UIViewController <UISearchBarDelegate>

@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UIScrollView *hotMechantView;

-(CGFloat)getHeaderHeight;
-(void)setViewFrame:(CGRect)frame;

@end
