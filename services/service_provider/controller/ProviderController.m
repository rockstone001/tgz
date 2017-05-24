//
//  ProviderController.m
//  services
//
//  Created by lqzhuang on 17/4/26.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "ProviderController.h"

@interface ProviderController ()

@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) NavCenterBar *centerBar;

@end

@implementation ProviderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    [self initNavButton];
    [self initScrollView];
    [self initChildVC];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.centerBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.centerBar.hidden = NO;
}

-(void)initChildVC
{
    
    MerchantsViewController *vc1 = [[MerchantsViewController alloc] initWithCollectionViewLayout:[[WaterFlowLayout alloc] init]];
    vc1.type = @"附近";
    [self addChildViewController:vc1];
    [self.contentView addSubview:vc1.view];
    CGRect frame = self.contentView.bounds;
    vc1.view.frame = frame;
    
    MerchantsViewController *vc2 = [[MerchantsViewController alloc] initWithCollectionViewLayout:[[WaterFlowLayout alloc] init]];
    vc2.type = @"推荐";
    [self addChildViewController:vc2];
    [self.contentView addSubview:vc2.view];
    frame.origin.x += frame.size.width;
    vc2.view.frame = frame;
    
    MerchantsViewController *vc3 = [[MerchantsViewController alloc] initWithCollectionViewLayout:[[WaterFlowLayout alloc] init]];
    vc3.type = @"关注";
    [self addChildViewController:vc3];
    [self.contentView addSubview:vc3.view];
    frame.origin.x += frame.size.width;
    vc3.view.frame = frame;
    
    self.contentView.contentSize = CGSizeMake(frame.size.width * 3, frame.size.height);
}

-(void)initScrollView
{
    CGRect frame = self.view.frame;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGRect tabBarFrame = self.tabBarController.tabBar.frame;
    
    frame.size.height -= (navBarFrame.size.height + tabBarFrame.size.height + navBarFrame.origin.y);
    //    frame.origin.y += (navBarFrame.size.height + navBarFrame.origin.y);
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
    //    scrollView.backgroundColor = [UIColor redColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    scrollView.contentOffset = CGPointMake(0, 0);
    
    [self.view addSubview:scrollView];
    self.contentView = scrollView;
    
}

-(void)initNavButton
{
    CGRect frame = self.navigationController.navigationBar.frame;
    NavCenterBar *navCenterBar = [[NavCenterBar alloc] initWithFrame:frame btnTitleArray:@[@"附近", @"推荐", @"关注"]];
    navCenterBar.navCenterBardelegate = self;
    [self.navigationController.navigationBar addSubview:navCenterBar];
    self.centerBar = navCenterBar;
}

-(void)navCenterBar:(NavCenterBar *)navCenterBar buttonClicked:(UIButton *)btn
{
    //    NSLog(@"navbar %zd clicked", btn.tag);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.contentOffset = CGPointMake(self.contentView.frame.size.width * btn.tag, 0);
    } completion:^(BOOL finished) {
        [[self.childViewControllers objectAtIndex:btn.tag] refreshList];
        NSLog(@"reload data");
    }];
}

// 设置刷新状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x / self.contentView.bounds.size.width == 1.0) {
        //        NSLog(@"inex = 1");
        [self.centerBar btnChange:1];
    } else if (scrollView.contentOffset.x / self.contentView.bounds.size.width == 0.0) {
        [self.centerBar btnChange:0];
    } else if (scrollView.contentOffset.x / self.contentView.bounds.size.width == 2.0) {
        [self.centerBar btnChange:2];
    }
}


@end
