//
//  MainTabBarController.m
//  services
//
//  Created by lqzhuang on 17/4/26.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavController.h"
#import "MessagesController.h"
#import "ProviderController.h"
#import "PublishController.h"
#import "ServiceInfoController.h"
#import "MineController.h"
#import "MainTabBar.h"

@interface MainTabBarController () <MainTabBarDelegate>

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(instancetype)init
{
    if (self = [super init]) {
        MainNavController *vc1 = [[MainNavController alloc] initWithRootViewController:[[MessagesController alloc] init]];
        vc1.tabBarItem.title = @"消息";
        
        MainNavController *vc2 = [[MainNavController alloc] initWithRootViewController:[[ProviderController alloc] init]];
        vc2.tabBarItem.title = @"发现";
        
//        MainNavController *vc3 = [[MainNavController alloc] initWithRootViewController:[[PublishController alloc] init]];
//        vc3.tabBarItem.title = @"发布";
        
        MainNavController *vc4 = [[MainNavController alloc] initWithRootViewController:[[ServiceInfoController alloc] init]];
        vc4.tabBarItem.title = @"服务圈";
        
        MainNavController *vc5 = [[MainNavController alloc] initWithRootViewController:[[MineController alloc] init]];
        vc5.tabBarItem.title = @"我";
        
        self.viewControllers = @[vc4, vc1, vc2, vc5];
        
        MainTabBar *mainTabBar = [[MainTabBar alloc] initWithFrame:self.tabBar.bounds];
        mainTabBar.mainTabBarDelegate = self;
        [self.tabBar addSubview: mainTabBar];
        
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)tabBarButtonClicked:(UIButton *)btn
{
    self.selectedIndex = btn.tag;
}
-(void)tabBarCenterButtonClicked:(UIButton *)btn
{
    NSLog(@"center button clicked");
}
@end
