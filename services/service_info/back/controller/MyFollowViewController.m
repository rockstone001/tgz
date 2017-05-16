//
//  MyFollowViewController.m
//  services
//
//  Created by lqzhuang on 17/5/4.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MyFollowViewController.h"
#import "ServiceInfoCell.h"
#import "PhotoBrowser.h"
#import "MyFollowHeaderView.h"
#define kInfoCellID @"serviceInfoCell"
#define kMargin 5
#define kCellMarginTop 10

@interface MyFollowViewController () <ServiceInfoCellDelegate>

@property (nonatomic, strong) NSMutableArray *list;
//@property (nonatomic, strong) PhotoBrowser *pb;
@property (nonatomic, strong) MyFollowHeaderView *headerView;

@end

@implementation MyFollowViewController

-(NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray array];
    }
    return _list;
}

-(MyFollowHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[MyFollowHeaderView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _headerView;
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
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headerView;
    [self refreshList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.list count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceInfo *sInfo = self.list[indexPath.section];
    ServiceInfoCell *cell = [ServiceInfoCell  serviceInfoCell:tableView withModel:sInfo withReuseID:kInfoCellID];
    //取消选中状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    
//    NSArray *colors = @[[UIColor redColor], [UIColor blueColor], [UIColor yellowColor], [UIColor greenColor]];
//    
//    cell.backgroundColor = [colors objectAtIndex:arc4random_uniform(4)];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServiceInfo *sInfo = self.list[indexPath.section];
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

//图片点击的代理方法
-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCellImage:(NSArray *)images currentIndex:(NSIndexPath *)indexPath
{
    PhotoBrowser *pb = [[PhotoBrowser alloc] init:images currentIndex:indexPath.row];
    [pb show];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ServiceInfoCell *cell = [tableView cellForRowAtIndexPath:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kCellMarginTop;
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    view.tintColor = [UIColor clearColor];
}



@end
