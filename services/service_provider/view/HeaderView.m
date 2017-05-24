//
//  HeaderView.m
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "HeaderView.h"
#import "SearchViewController.h"
#import "SearchResultViewController.h"

@interface HeaderView() <UISearchBarDelegate>

@end

@implementation HeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor blueColor];
        [self addSearchBar];
    }
    return self;
}

-(void)addSearchBar
{
    CGRect frame = self.frame;
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = kMerchantSearchPlaceHolder;
    _searchBar = searchBar;
    [self addSubview:searchBar];
}

@end
