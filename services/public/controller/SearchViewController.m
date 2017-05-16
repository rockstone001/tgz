//
//  SearchViewController.m
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchViewController.h"
#import "NSString+extension.h"
#define kMargin 10


@interface SearchViewController () <UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addHeaderView];
    [self.searchBar becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addHeaderView
{
    CGRect frame = self.view.frame;
    CGFloat cancelBtnWidth = [kCancelText getStringWidth:kTextSize] + kMargin * 2;
    cancelBtnWidth = 0;
    
    frame.origin.y = 20;
    frame.size.height = kSearchBarHeight;
    frame.size.width -= cancelBtnWidth;
    SearchBar *searchBar = [[SearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = @"搜索您感兴趣的商家";
    searchBar.delegate = self;
//    searchBar.tintColor = [UIColor clearColor];
//    searchBar.backgroundColor = [UIColor redColor];
//    searchBar.barTintColor = [UIColor whiteColor];
    searchBar.showsCancelButton = YES;
    for(id cc in [searchBar.subviews[0] subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)cc;
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    
//    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width, 20, cancelBtnWidth, kSearchBarHeight)];
//    [cancelBtn setTitle:kCancelText forState:UIControlStateNormal];
//    [cancelBtn setBackgroundColor:kSearchBarColor];
    
    self.searchBar = searchBar;
//    self.cancelBtn = cancelBtn;
    [self.view addSubview:searchBar];
//    [self.view addSubview:cancelBtn];
    
//    [cancelBtn addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
}

-(void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:^{
        [self.navigationController.view resignFirstResponder];
    }];

}


@end
