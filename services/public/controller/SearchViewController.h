//
//  SearchViewController.h
//  services
//
//  Created by lqzhuang on 17/5/17.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewDelegate <NSObject>

@required
-(void)setData:(id)data;
-(void)getSearchResult:(NSString *)keyword;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, strong) UITableViewController <SearchViewDelegate> *resultVc;
@property (nonatomic, strong) UISearchBar *searchBar;

-(instancetype)initWithResultViewController:(UITableView *) resultVc;
-(void)tableViewDidScroll;

@end
