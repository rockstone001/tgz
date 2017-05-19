//
//  SearchViewController.m
//  services
//
//  Created by lqzhuang on 17/5/17.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchHistoryView.h"

@interface SearchViewController () <UISearchBarDelegate, SearchHistoryDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchBar];
    [self initResultVc];
}


-(void)initSearchBar
{
    _searchBar = [[UISearchBar alloc] init];
    CGRect frame = self.view.bounds;
    frame.size.height = kSearchBarHeight;
    frame.origin.y = 20;
    _searchBar.frame = frame;
    //显示cancel button
    _searchBar.showsCancelButton = YES;
    _searchBar.placeholder = kSearchPlaceHolder;
    _searchBar.delegate = self;
    
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:kCancelText];
    [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTintColor:[UIColor whiteColor]];
    
    [self.view addSubview:_searchBar];
    [_searchBar becomeFirstResponder];
}

-(void)initResultVc
{
    CGRect frame = self.view.bounds;
    CGRect searchBarFrame = _searchBar.frame;
    frame.origin.y += searchBarFrame.origin.y + searchBarFrame.size.height;
    frame.size.height -= frame.origin.y;
    _resultVc.tableView.frame = frame;
    [self.view addSubview:_resultVc.tableView];
    
    SearchHistoryView *historyView = [[SearchHistoryView alloc] init];
    historyView.delegate = self;
    _resultVc.tableView.tableHeaderView = historyView;
    [_resultVc setData:nil];
    [_resultVc.tableView reloadData];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
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

-(instancetype)initWithResultViewController:(UITableViewController <SearchViewDelegate>*)resultVc
{
    if (self = [super init]) {
        self.resultVc = resultVc;
        [self addChildViewController:resultVc];
    }
    return self;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@", searchText);
    if ([[searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
        SearchHistoryView *historyView = [[SearchHistoryView alloc] init];
        historyView.delegate = self;
        _resultVc.tableView.tableHeaderView = historyView;
        [_resultVc setData:nil];
        [_resultVc.tableView reloadData];
        //        srvc.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        _resultVc.tableView.tableHeaderView = nil;
//        [self getSearchResult:keyword];
        //        srvc.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_resultVc getSearchResult:searchText];
    }
}

-(void)SearchHistory:(SearchHistoryView *)view closeBtnClicked:(NSString *)text
{
    [_resultVc.tableView reloadData];
}

-(void)SearchHistory:(SearchHistoryView *)view textBtnClicked:(NSString *)text
{
    self.searchBar.text = text;
    [self searchBar:_searchBar textDidChange:text];
    [self.searchBar resignFirstResponder];
    [self setCancelBtnEnabled];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self setCancelBtnEnabled];
}

-(void)dealloc
{
    NSLog(@"%s", __func__);
}

-(void)tableViewDidScroll
{
//    [self.view endEditing:YES];
    [_searchBar endEditing:YES];
    [self setCancelBtnEnabled];
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setCancelBtnEnabled
{
    UIButton *cancelBtn = [_searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
    cancelBtn.enabled = YES;
}

@end
