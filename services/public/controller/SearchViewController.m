//
//  SearchViewController.m
//  services
//
//  Created by lqzhuang on 17/5/17.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate>

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSearchBar];
    [self initResultVc];
    [self searchBar:_searchBar textDidChange:@""];
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
    _searchBar.placeholder = _type;
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
    ((UIViewController *)_resultVc).view.frame = frame;
    [self.view addSubview:((UIViewController *)_resultVc).view];    
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

//构造函数
-(instancetype)initWithResultViewController:(id)resultVc withType:(NSString *)type
{
    if (self = [super init]) {
        self.resultVc = resultVc;
        self.type = type;
        [self addChildViewController:resultVc];
    }
    return self;
}

//取消搜索
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//搜索框值改变的响应
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([_resultVc respondsToSelector:@selector(searchView: refreshSearchResult:)]) {
        [_resultVc searchView:self refreshSearchResult:searchText];
    }
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
