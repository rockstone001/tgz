//
//  SearchResultViewController.m
//  services
//
//  Created by lqzhuang on 17/5/15.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchResultViewController.h"

#define kSearchCellID @"searchCellID"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

-(NSArray *)data
{
    if (!_data) {
        _data = [NSArray array];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.backgroundColor = kLightGrayBG;
    self.tableView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceInfo *sInfo = self.data[indexPath.row];
    ServiceInfoCell *cell = [ServiceInfoCell  serviceInfoCell:tableView withModel:sInfo withReuseID:kInfoCellID indexPath:indexPath];
    //取消选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.collectionDelegate = self;
    cell.delegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceInfo *sInfo = self.data[indexPath.row];
    return [ServiceInfoCell getCellHeight:sInfo withFrame:tableView.frame];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSString *name = self.data[indexPath.row][@"name"];
//    [self dismissViewControllerAnimated:NO completion:^{
//        SearchController *svc = (SearchController *)self.parentViewController;
//        DetailViewController *dvc = [[DetailViewController alloc] init];
//        [(UINavigationController *)svc.previousVC pushViewController:dvc animated:YES];
//    }];
//}

-(void)dealloc
{
    NSLog(@"%s", __func__);
}

//图片点击的代理方法
-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCellImage:(NSArray *)images currentIndex:(NSIndexPath *)indexPath
{
    PhotoBrowserController *pvc = [[PhotoBrowserController alloc] init];
    pvc.images = images;
    pvc.index = indexPath.row;
    SearchViewController *svc = (SearchViewController *)self.parentViewController;
    [svc addChildViewController:pvc];
    [svc.view addSubview:pvc.view];
}

-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickLikeButton:(NSIndexPath *)indexPath
{
    ServiceInfo *sInfo = self.data[indexPath.row];
    NSString *urlString;
    if (sInfo.liked) {
        urlString  = [kAPIHost stringByAppendingPathComponent:kUnlike];
    } else {
        urlString = [kAPIHost stringByAppendingPathComponent:kLike];
    }
    
    NSDictionary *dict = @{@"id":@(sInfo.ID)};
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:dict error:nil];
    request.timeoutInterval = 5;
    //    request.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            if (responseObject && responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0 && responseObject[@"msg"]) {
                BOOL liked = responseObject[@"msg"][@"liked"] && [responseObject[@"msg"][@"liked"] boolValue];
                NSString *likes = [NSString stringWithFormat:@"%@", responseObject[@"msg"][@"likes"]];
                sInfo.liked = liked;
                sInfo.likes = likes;
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
        } else {
            NSLog(@"Error: %@", error);
        }
    }] resume];
}

-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCommentButton:(NSIndexPath *)indexPath
{
    //    ServiceInfo *sInfo = self.list[indexPath.row];
    DetailViewController *dvc = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:dvc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return self.data.count == 0 ? 0 : kCellMarginBottom;
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
            self.data = arr;
            [self.tableView reloadData];
        }
    }] resume];
}

#pragma mark <SearchViewDelegate>
-(void)searchView:(SearchViewController *)searchViewController refreshSearchResult:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        //搜索关键字为空 显示搜索历史
        SearchHistoryView *historyView = [[SearchHistoryView alloc] init];
        [historyView setDataWithType:kSearchPlaceHolder];
        historyView.delegate = self;
        self.tableView.tableHeaderView = historyView;
        self.data = nil;
        [self.tableView reloadData];

    } else {
        //不为空 显示搜索结果
        self.tableView.tableHeaderView = nil;
        [self getSearchResult:searchText];
    }
}

#pragma mark <SearchHistoryDelegate>
-(void)SearchHistory:(SearchHistoryView *)view closeBtnClicked:(NSString *)text
{
    [self.tableView reloadData];
}

-(void)SearchHistory:(SearchHistoryView *)view textBtnClicked:(NSString *)text
{
    SearchViewController *svc = (SearchViewController *)self.parentViewController;
    svc.searchBar.text = text;
    [svc searchBar:svc.searchBar textDidChange:text];
    [svc.searchBar resignFirstResponder];
    [svc setCancelBtnEnabled];
}

@end
