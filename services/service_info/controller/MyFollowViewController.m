//
//  MyFollowViewController.m
//  services
//
//  Created by lqzhuang on 17/5/4.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MyFollowViewController.h"
#import "ServiceInfoController.h"
#import "DetailViewController.h"
#import "SearchHeaderView.h"
#import "SearchViewController.h"
#import "SearchResultViewController.h"

#import <CoreLocation/CoreLocation.h>

#define kRefreshHeight 75

@interface MyFollowViewController () <ServiceInfoCellDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *list;
//@property (nonatomic, strong) PhotoBrowser *pb;

@property (nonatomic, strong) CLLocationManager *locManager;

@property (nonatomic, assign) CGFloat longitude; //经度
@property (nonatomic, assign) CGFloat latitude; //纬度

@end

@implementation MyFollowViewController

-(NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}
-(CLLocationManager *)locManager
{
    if (!_locManager) {
        _locManager = [[CLLocationManager alloc] init];
        _locManager.delegate = self;
        
        if ([_locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locManager requestWhenInUseAuthorization];
        }
    }
    return _locManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    //取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SearchHeaderView *hv = [[SearchHeaderView alloc] initWithFrame:self.view.bounds];
    hv.type = kSearchPlaceHolder;
    [hv addSearchBar];
    hv.searchBar.delegate = self;
    self.tableView.tableHeaderView = hv;
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadRefreshView];
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
//    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceInfo *sInfo = self.list[indexPath.row];
    return [ServiceInfoCell getCellHeight:sInfo withFrame:tableView.frame];
}

-(void)refreshList
{
    NSString *urlString = [kAPIHost stringByAppendingPathComponent:kGetCoupon];
    if ([self.type isEqualToString:@"关注"]) {
        urlString = [kAPIHost stringByAppendingPathComponent:kGetMySerices];
    } else if (!self.longitude) {
        if ([CLLocationManager locationServicesEnabled]) { // 判断是否打开了位置服务
            [self.locManager startUpdatingLocation]; // 开始更新位置
        }
        return;
    }
    
//    NSLog(@"%@", urlString);
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
//        NSLog(@"%@", responseObject);
        NSLog(@"http response");
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0) {
//            NSLog(@"%@", responseObject[@"msg"]);
            [self.list removeAllObjects];
            for (NSDictionary *dict in responseObject[@"msg"]) {
                ServiceInfo *info = [ServiceInfo serviceInfo:dict];
                [self.list addObject:info];
            }
            [self.tableView reloadData];
            [self endRefreshControl];
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
    return 0;
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


// 结束刷新
- (void) endRefreshControl
{
    [self.refreshControl endRefreshing];
}

// 刷新的回调方法
- (void)loadData
{
    if ([self.type isEqualToString:@"附近优惠"]) {
        if ([CLLocationManager locationServicesEnabled]) { // 判断是否打开了位置服务
            [self.locManager startUpdatingLocation]; // 开始更新位置
            NSLog(@"start location");
        }
        return;
    }
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


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    self.longitude = location.coordinate.longitude;
    self.latitude = location.coordinate.latitude;
    [self.locManager stopUpdatingLocation];
    NSLog(@"%.5f, %.5f", self.longitude, self.latitude);
    [self refreshList];
    
}

#pragma mark <UISearchBarDelegate>
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //5-17 使用navc + tableview + SearchCon 实现
    self.definesPresentationContext = YES;
    SearchViewController *svc = [[SearchViewController alloc] initWithResultViewController:[[SearchResultViewController alloc] init] withType:kSearchPlaceHolder];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
    //    nav.modalPresentationStyle = UIModalPresentationPopover;
    //    svc.modalPresentationStyle = UIModalPresentationPopover;
    nav.modalTransitionStyle = 2;
    [self presentViewController:nav animated:YES completion:nil];
}


@end
