//
//  PhotoBrowserController.h
//  services
//
//  Created by lqzhuang on 17/5/11.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserController : UIViewController

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) UIPageControl *pageCtrl;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger index;
//@property (nonatomic, strong) PhotoBrowserDelegate *scrollDelegate;

@end
