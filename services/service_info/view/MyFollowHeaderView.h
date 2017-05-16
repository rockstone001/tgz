//
//  MyFollowHeaderView.h
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFollowHeaderView : UIView <UISearchBarDelegate>

@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UIScrollView *hotMechantView;

@end
