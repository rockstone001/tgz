//
//  SearchViewController.h
//  services
//
//  Created by lqzhuang on 17/5/17.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchViewController;

@protocol SearchViewDelegate <NSObject>

@required
//-(void)setData:(id)data;
//-(void)getSearchResult:(NSString *)keyword;
-(void)searchView:(SearchViewController *)searchViewController refreshSearchResult:(NSString *)searchText;

@end

@interface SearchViewController : UIViewController

@property (nonatomic, strong) id resultVc;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, copy) NSString *type;

-(instancetype)initWithResultViewController:(id) resultVc withType:(NSString *)type;
-(void)tableViewDidScroll;

//供子controller调用
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
-(void)setCancelBtnEnabled;

@end
