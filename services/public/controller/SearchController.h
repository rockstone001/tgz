//
//  SearchController.h
//  services
//
//  Created by lqzhuang on 17/5/14.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchHistoryView.h"
#import "ServiceInfo.h"
#import "SearchResultViewController.h"

@interface SearchController : UISearchController <UISearchResultsUpdating,SearchHistoryDelegate>

@property (nonatomic, strong) UIViewController *previousVC;

@end
