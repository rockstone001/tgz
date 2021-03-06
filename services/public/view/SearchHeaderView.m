//
//  HeaderView.m
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchHeaderView.h"
#import "SearchViewController.h"
#import "SearchResultViewController.h"

@interface SearchHeaderView() <UISearchBarDelegate>

@end

@implementation SearchHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    frame.size.height = kSearchBarHeight;
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

-(void)addSearchBar
{
    CGRect frame = self.frame;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = _type;
    _searchBar = searchBar;
    [self addSubview:searchBar];
}

@end
