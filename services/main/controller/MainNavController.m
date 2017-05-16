//
//  MainNavController.m
//  services
//
//  Created by lqzhuang on 17/4/26.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MainNavController.h"

@interface MainNavController ()

@end

@implementation MainNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
    
//    [navBar setBackgroundColor:[UIColor redColor]];
    //设置导航条的背景图片
//    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    //设置最上面的状态栏的风格
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //设置导航条 标题的大小和颜色
//    NSDictionary *titleAttr = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:navTitleFontSize]};
//    [navBar setTitleTextAttributes:titleAttr];
    //设置导航条的左右按钮的颜色和大小
//    [navBar setTintColor:[UIColor whiteColor]];
//    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
//    [barItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:barItemFontSize]} forState:UIControlStateNormal];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
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

@end
