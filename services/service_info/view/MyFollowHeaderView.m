//
//  MyFollowHeaderView.m
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MyFollowHeaderView.h"
#import "SearchBar.h"
#define kSearchBarHeight 44
#define kHotTitleLabelHeight 35
#define kHotScrollViewHeight 100
#define kMargin 10


@implementation MyFollowHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        frame.size.height = kSearchBarHeight + kHotTitleLabelHeight + kHotScrollViewHeight + kMargin;
        self.frame = frame;
//        self.backgroundColor = [UIColor blueColor];
        [self addSearchBar];
        [self addHotMerchant];
    }
    return self;
}

-(void)addSearchBar
{
    CGRect frame = self.frame;
    frame.size.height = kSearchBarHeight;
    SearchBar *searchBar = [[SearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = @"搜索您感兴趣的商家";
    searchBar.delegate = self;
    _searchBar = searchBar;
    [self addSubview:searchBar];
    
}

-(void)addHotMerchant
{
    UILabel *label = [[UILabel alloc] init];//WithFrame:CGRectMake(kMargin, kSearchBarHeight + kMargin, self.frame.size.width - kMargin, kHotTitleLabelHeight)];
    label.text = @"大家都在关注";
    label.font = [UIFont systemFontOfSize:kTextSize];
    
    label.frame = CGRectMake(kMargin, kSearchBarHeight, self.frame.size.width - kMargin * 2, kHotTitleLabelHeight);
    label.backgroundColor = [UIColor blueColor];
    
    [self addSubview:label];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSearchBarHeight + kHotTitleLabelHeight, self.frame.size.width, kHotScrollViewHeight)];
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    self.hotMechantView = scrollView;
}



@end
