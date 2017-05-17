//
//  SearchResultViewController.h
//  services
//
//  Created by lqzhuang on 17/5/15.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SearchController.h"
#import "SearchViewController.h"
#import "ServiceInfoCell.h"
#import "DetailViewController.h"
#import "ServiceInfo.h"
#import "PhotoBrowserController.h"

@interface SearchResultViewController : UITableViewController <ServiceInfoCellDelegate, ServiceInfoCollectionCellDelegate, SearchViewDelegate>

@property (nonatomic, strong) NSArray *data;

-(void)getSearchResult:(NSString *)keyword;

@end
