//
//  SearchController.m
//  services
//
//  Created by lqzhuang on 17/5/14.
//  Copyright © 2017年 lqzhuang. All rights reserved.

//基本 不用了
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.searchResultsUpdater = self;
    self.searchBar.placeholder = kSearchPlaceHolder;
    [self.searchBar setValue:kCancelText forKey:@"_cancelButtonText"];
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    
//    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil nil]
//     setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,[NSValue valueWithUIOffset:UIOffsetMake(0, 1)],UITextAttributeTextShadowOffset,nil]
//     forState:UIControlStateNormal];
//    self.searchBar.barTintColor = [UIColor blueColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    SearchResultViewController *srvc = (SearchResultViewController *)self.searchResultsController;
    NSString *keyword = self.searchBar.text;
    if ([keyword isEqualToString:@""]) {
        SearchHistoryView *historyView = [[SearchHistoryView alloc] init];
        historyView.delegate = self;
        srvc.tableView.tableHeaderView = historyView;
        srvc.data = nil;
        [srvc.tableView reloadData];
//        srvc.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        srvc.tableView.tableHeaderView = nil;
        [self getSearchResult:keyword];
//        srvc.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

-(void)SearchHistory:(SearchHistoryView *)view closeBtnClicked:(NSString *)text
{
    SearchResultViewController *srvc = (SearchResultViewController *)self.searchResultsController;
    [srvc.tableView reloadData];
}

-(void)SearchHistory:(SearchHistoryView *)view textBtnClicked:(NSString *)text
{
    self.searchBar.text = text;
}

-(void)getSearchResult:(NSString *)keyword
{
    NSString *urlString = [kAPIHost stringByAppendingPathComponent:kGetSearchResult];
//        NSLog(@"%@", urlString);
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    NSDictionary *dict = @{@"keyword":keyword};
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:dict error:nil];
    request.timeoutInterval = 5;
    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@, %@", responseObject, error);
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0) {
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"msg"]) {
                [arr addObject:[ServiceInfo serviceInfo:dict]];
            }
            SearchResultViewController *srvc = (SearchResultViewController *)self.searchResultsController;
            srvc.data = arr;
            [srvc.tableView reloadData];
        }
    }] resume];
}

-(void)dealloc
{
    NSLog(@"%s", __func__);
}
@end
