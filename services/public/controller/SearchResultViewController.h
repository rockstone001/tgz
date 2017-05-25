//
//  SearchResultViewController.h
//  services
//
//  Created by lqzhuang on 17/5/15.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//
//  这个类是专门给服务圈的搜索展示结果用的


#import <UIKit/UIKit.h>
//#import "SearchController.h"
#import "SearchViewController.h"
#import "SearchHistoryView.h"
#import "ServiceInfoCell.h"
#import "DetailViewController.h"
#import "PhotoBrowserController.h"

@interface SearchResultViewController : UITableViewController <ServiceInfoCellDelegate, ServiceInfoCollectionCellDelegate, SearchViewDelegate, SearchHistoryDelegate>

@property (nonatomic, strong) NSArray *data;

@end
