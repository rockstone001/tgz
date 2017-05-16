//
//  MyFollowViewController.m
//  services
//
//  Created by lqzhuang on 17/5/4.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MyFollowViewController.h"
#import "ServiceInfoController.h"
#import "MyFollowHeaderViewController.h"
#import "DetailViewController.h"
#define kInfoCellID @"serviceInfoCell"
#define kCellMarginBottom 10
#define kRefreshHeight 75

@interface MyFollowViewController () <ServiceInfoCellDelegate>

@property (nonatomic, strong) NSMutableArray *list;
//@property (nonatomic, strong) PhotoBrowser *pb;

@end

@implementation MyFollowViewController

-(NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    CGRect frame = self.tableView.frame;
//    frame.size.width -= kMargin * 2;
//    frame.origin.x += kMargin;
//    self.tableView.frame = frame;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor whiteColor];
    
    MyFollowHeaderViewController *hvc = [[MyFollowHeaderViewController alloc] init];
    [hvc setViewFrame:CGRectMake(0, 0, self.view.frame.size.width, [hvc getHeaderHeight])];
    [self addChildViewController:hvc];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:hvc.view.frame];
    [self.tableView.tableHeaderView addSubview:hvc.view];
    [self refreshList];
    
    [self loadRefreshView];
    
//    NSLog(@"%@", NSStringFromCGRect(self.tableView.tableHeaderView.frame));
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
    return [self.list count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceInfo *sInfo = self.list[indexPath.row];
    ServiceInfoCell *cell = [ServiceInfoCell  serviceInfoCell:tableView withModel:sInfo withReuseID:kInfoCellID indexPath:indexPath];
    //取消选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.collectionDelegate = (ServiceInfoController *)self.parentViewController;
    cell.delegate = self;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceInfo *sInfo = self.list[indexPath.row];
    return [ServiceInfoCell getCellHeight:sInfo withFrame:tableView.frame];
}

-(void)refreshList
{
    
    NSString *urlString = [kAPIHost stringByAppendingPathComponent:kGetMySerices];
//    NSLog(@"%@", urlString);
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@", responseObject);
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0) {
//            NSLog(@"%@", responseObject[@"msg"]);
            for (NSDictionary *dict in responseObject[@"msg"]) {
                ServiceInfo *info = [ServiceInfo serviceInfo:dict];
                [self.list addObject:info];
            }
            [self.tableView reloadData];
        }
    }] resume];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ServiceInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kCellMarginBottom;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

//-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
//{
//    view.tintColor = [UIColor clearColor];
//}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


//下拉刷新  系统自带控件
- (void) loadRefreshView
{
    // 下拉刷新
    self.refreshControl = [[UIRefreshControl alloc] init];
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
}

// 设置刷新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    decelerate = YES;
    if (scrollView.contentOffset.y + kRefreshHeight <= 0 && !self.refreshControl.refreshing) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新"];
//        });
        [self.refreshControl beginRefreshing];
        [self loadData];
        NSLog(@"%.2f, %zd", fabs(scrollView.contentOffset.y), kRefreshHeight);
    }
}

// 设置刷新状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%.2f", scrollView.contentOffset.y);
//    if (fabs(scrollView.contentOffset.y) < kRefreshHeight) {
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
//    }
//    else if (!scrollView.decelerating) {
//        self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开刷新"];
//    }
}

// 结束刷新
- (void) endRefreshControl
{
    [self.refreshControl endRefreshing];
}

// 刷新的回调方法
- (void)loadData
{
    NSString *urlString = [kAPIHost stringByAppendingPathComponent:kGetMyServicesNew];
    //    NSLog(@"%@", urlString);
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        [self endRefreshControl];
        //        NSLog(@"%@", responseObject);
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0) {
            //            NSLog(@"%@", responseObject[@"msg"]);
            for (NSDictionary *dict in responseObject[@"msg"]) {
                ServiceInfo *info = [ServiceInfo serviceInfo:dict];
                [self.list insertObject:info atIndex:0];
            }
            [self.tableView reloadData];
        }
    }] resume];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickLikeButton:(NSIndexPath *)indexPath
{
    ServiceInfo *sInfo = self.list[indexPath.row];
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

@end