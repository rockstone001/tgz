//
//  ServiceInfoController.m
//  services
//
//  Created by lqzhuang on 17/4/26.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "ServiceInfoController.h"

@interface ServiceInfoController () 

@property (nonatomic, weak) UIScrollView *contentView;
@property (nonatomic, weak) NavCenterBar *centerBar;

@end

@implementation ServiceInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置CGRectZero从导航栏下开始计算
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self initNavButton];
    [self initScrollView];
    [self initChildVC];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.navigationController.navigationBar.hidden = YES;
//        self.tabBarController.tabBar.hidden = YES;
//    });
    
    
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
    
    MyFollowViewController *vc1 = [[MyFollowViewController alloc] init];
    vc1.type = @"关注";
    [self addChildViewController:vc1];
    [self.contentView addSubview:vc1.view];
    CGRect frame = self.contentView.bounds;
    vc1.view.frame = frame;
    [vc1 refreshList];
    
//    HotViewController *vc2 = [[HotViewController alloc] init];
//    [self addChildViewController:vc2];
//    [self.contentView addSubview:vc2.view];
//    frame.origin.x = frame.size.width;
//    vc2.view.frame = frame;
    
    MyFollowViewController *vc3 = [[MyFollowViewController alloc] init];
    vc3.type = @"附近优惠";
    [self addChildViewController:vc3];
    [self.contentView addSubview:vc3.view];
    frame.origin.x += frame.size.width;
    vc3.view.frame = frame;
    
    self.contentView.contentSize = CGSizeMake(frame.size.width * 2, frame.size.height);
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
    NavCenterBar *navCenterBar = [[NavCenterBar alloc] initWithFrame:frame btnTitleArray:@[@"关注", @"附近优惠"]];
    navCenterBar.navCenterBardelegate = self;
    [self.navigationController.navigationBar addSubview:navCenterBar];
    self.centerBar = navCenterBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)navCenterBar:(NavCenterBar *)navCenterBar buttonClicked:(UIButton *)btn
{
//    NSLog(@"navbar %zd clicked", btn.tag);
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.contentOffset = CGPointMake(self.contentView.frame.size.width * btn.tag, 0);
    } completion:^(BOOL finished) {
        [[self.childViewControllers objectAtIndex:btn.tag] refreshList];
    }];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
//    NSLog(@"%zd", index);
    [self.centerBar btnChange:index];
    [[self.childViewControllers objectAtIndex:index] refreshList];
}

//图片点击的代理方法
-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCellImage:(NSArray *)images currentIndex:(NSIndexPath *)indexPath
{
    //    PhotoBrowser *pb = [[PhotoBrowser alloc] init:images currentIndex:indexPath.row];
    //    [pb show];
    PhotoBrowserController *pvc = [[PhotoBrowserController alloc] init];
    pvc.images = images;
    pvc.index = indexPath.row;
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] addChildViewController:pvc];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController].view addSubview:pvc.view];
    
//    [self addChildViewController:pvc];
//    [self.view addSubview: pvc.view];
}

@end
