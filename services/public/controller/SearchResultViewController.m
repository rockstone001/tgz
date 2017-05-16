//
//  SearchResultViewController.m
//  services
//
//  Created by lqzhuang on 17/5/15.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchController.h"
#import "PersonalViewController.h"
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = kLightGrayBG;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kSearchCellID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kSearchCellID];
    }
    // Configure the cell...
    cell.textLabel.text = self.data[indexPath.row][@"name"];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = self.data[indexPath.row][@"name"];
    [self dismissViewControllerAnimated:NO completion:^{
        SearchController *svc = (SearchController *)self.parentViewController;
        PersonalViewController *pvc = [[PersonalViewController alloc] init];
        pvc.name = name;
        [(UINavigationController *)svc.previousVC pushViewController:pvc animated:YES];
    }];
}

-(void)dealloc
{
    NSLog(@"%s", __func__);
}




@end
