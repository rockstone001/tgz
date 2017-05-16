//
//  SearchViewController.h
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchBar.h"

@interface SearchViewController : UIViewController

@property (nonatomic, weak) SearchBar *searchBar;
@property (nonatomic, weak) UIButton *cancelBtn;

@end
