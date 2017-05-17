//
//  MyFollowHeaderViewController.m
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MyFollowHeaderViewController.h"
#import "SearchBar.h"
#import "SearchViewController.h"
//#import "SearchController.h"
#import "SearchResultViewController.h"
#define kHotTitleLabelHeight 35
#define kHotScrollViewHeight 60
#define kMargin 10

@interface MyFollowHeaderViewController () <UISearchBarDelegate, UIScrollViewDelegate>

@end

@implementation MyFollowHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    //    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
//    [self getHotMerchants];
}

-(void)initView
{
    //    NSLog(@"headerview.frame = %@", NSStringFromCGRect(self.view.frame));
    //    self.frame.size.height = kSearchBarHeight + kHotTitleLabelHeight + kHotScrollViewHeight + kMargin;
    //    self.frame = frame;
    //    self.view.backgroundColor = [UIColor blueColor];
    [self addSearchBar];
//    [self addHotMerchant];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addSearchBar
{
    CGRect frame = self.view.frame;
    frame.size.height = kSearchBarHeight;
    SearchBar *searchBar = [[SearchBar alloc] initWithFrame:frame];
    searchBar.placeholder = kSearchPlaceHolder;
    searchBar.delegate = self;
    _searchBar = searchBar;
    [self.view addSubview:searchBar];
}

-(void)addHotMerchant
{
    UILabel *label = [[UILabel alloc] init];//WithFrame:CGRectMake(kMargin, kSearchBarHeight + kMargin, self.frame.size.width - kMargin, kHotTitleLabelHeight)];
    label.text = @"大家都在关注";
    label.font = [UIFont systemFontOfSize:kTextSize];
    
    label.frame = CGRectMake(kMargin, kSearchBarHeight, self.view.frame.size.width - kMargin * 2, kHotTitleLabelHeight);
    //    label.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:label];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kSearchBarHeight + kHotTitleLabelHeight, self.view.frame.size.width, kHotScrollViewHeight)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.hotMechantView = scrollView;
}

/*
 #pragma mark - Navigation
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(CGFloat)getHeaderHeight
{
//    return kSearchBarHeight + kHotTitleLabelHeight + kHotScrollViewHeight + kMargin;
    return kSearchBarHeight;
}

-(void)setViewFrame:(CGRect)frame
{
    self.view.frame = frame;
}

-(void)getHotMerchants
{
    NSString *urlString = [kAPIHost stringByAppendingPathComponent:kGetHotMerchants];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0) {
            CGFloat x = kMargin;
            for (NSDictionary *dict in responseObject[@"msg"]) {
                //                NSLog(@"%@", dict);
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat width = [dict[@"name"] getStringWidth:kTextSize] + kMargin * 2;
                btn.frame = CGRectMake(x, 0, width, kHotScrollViewHeight);
                btn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];;
                btn.layer.cornerRadius = 10;
                btn.layer.masksToBounds = YES;
                [btn setTitle:dict[@"name"] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:kTextSize];
                [self.hotMechantView addSubview:btn];
                x += kMargin + width;
            }
            self.hotMechantView.contentSize = CGSizeMake(x, kHotScrollViewHeight);
        }
    }] resume];
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    SearchController *svc = [[SearchController alloc] initWithSearchResultsController:[[SearchResultViewController alloc] init]];
//    svc.modalPresentationStyle = UIModalPresentationPopover;
//    svc.previousVC = self.navigationController;
//    //    self.navigationController.modalPresentationStyle = UIModalPresentationPopover;
//    [self presentViewController:svc animated:YES completion:^{
//    }];
    
    //5-17 使用navc + tableview + SearchCon 实现
    self.definesPresentationContext = YES;
    SearchViewController *svc = [[SearchViewController alloc] initWithResultViewController:[[SearchResultViewController alloc] init]];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
//    nav.modalPresentationStyle = UIModalPresentationPopover;
//    svc.modalPresentationStyle = UIModalPresentationPopover;
    nav.modalTransitionStyle = 2;
    [self presentViewController:nav animated:YES completion:nil];
}




@end
