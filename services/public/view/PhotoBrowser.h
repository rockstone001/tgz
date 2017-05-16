//
//  PhotoBrowser.h
//  services
//
//  Created by lqzhuang on 17/5/9.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoBrowserDelegate;



@interface PhotoBrowser : UIView

@property (nonatomic, strong) NSArray *images;
@property (nonatomic, weak) UIPageControl *pageCtrl;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) PhotoBrowserDelegate *scrollDelegate;

-(void)show;
-(instancetype)init:(NSArray *)images currentIndex:(NSInteger)index;

@end

@interface  PhotoBrowserDelegate: UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) PhotoBrowser *target;

@end
