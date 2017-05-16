//
//  PhotoBrowser.m
//  services
//
//  Created by lqzhuang on 17/5/9.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "PhotoBrowser.h"
//#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIScrollView+touch.h"

@implementation PhotoBrowser

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init:(NSArray *)images currentIndex:(NSInteger)index
{
    CGRect frame = [UIScreen mainScreen].bounds;
    if (self = [super initWithFrame:frame]) {
        self.images = images;
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:frame];
        self.scrollView = scrollView;
        //设置scroll代理
        PhotoBrowserDelegate *delegate = [[PhotoBrowserDelegate alloc] init];
        delegate.target = self;
        self.scrollView.delegate = delegate;
        self.scrollDelegate = delegate;
        
        self.scrollView.contentSize = CGSizeMake(frame.size.width * images.count, frame.size.height);
        self.scrollView.pagingEnabled = YES;
        self.scrollView.backgroundColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:1/255.0 alpha:.7];
        
        [self addSubview:scrollView];
        //添加图片
        [self addImageViews];
        //设置初始偏移量
        CGPoint offset = self.scrollView.contentOffset;
        offset.x = self.bounds.size.width * index;
        self.scrollView.contentOffset = offset;
        
        //添加圆点
        [self addPageControl];
        self.pageCtrl.currentPage = index;
    }
    
    return self;
}

-(void)addImageViews
{
    CGRect frame = [UIScreen mainScreen].bounds;
    NSInteger index = 0;
    UIImage *defaultImage = [UIImage imageNamed:@"photo_default"];
    CGRect imageViewFrame = CGRectZero;
    for (NSString *imageUrl in self.images) {
        imageViewFrame = [self getImageViewFrame:frame imageViewSize:defaultImage.size];
        imageViewFrame.origin.x += frame.size.width * index;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageViewFrame];
        __weak UIImageView *weakImageView = imageView;
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:defaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            CGRect pFrame = [UIScreen mainScreen].bounds;
            CGRect frame = [self getImageViewFrame:pFrame imageViewSize:image.size];
            frame.origin.x += pFrame.size.width * index;
            weakImageView.frame = frame;
            
        }];
        
        [self.scrollView addSubview:imageView];
        index ++;
    }
}

-(void)addPageControl
{
    CGRect frame = [UIScreen mainScreen].bounds;
    UIPageControl *pageCtrl = [[UIPageControl alloc] init];
    self.pageCtrl = pageCtrl;
    CGFloat x = 0, y, width, height = 20;
    y = frame.size.height - height;
    width = frame.size.width;
    self.pageCtrl.frame = CGRectMake(x, y, width, height);
    [self addSubview:self.pageCtrl];
    [self.pageCtrl bringSubviewToFront:self];
    
    _pageCtrl.numberOfPages = self.images.count;
}

-(CGRect)getImageViewFrame:(CGRect)frame imageViewSize:(CGSize)imageSize
{
    CGFloat scale, x, y, width, height;
    
    CGFloat scale1 = frame.size.width / imageSize.width;
    CGFloat scale2 = frame.size.height / imageSize.height;
    
    scale = scale1 > scale2 ? scale2 : scale1;
    
    width = imageSize.width * scale;
    height = imageSize.height * scale;
    
    x = ((NSInteger)(width) == (NSInteger)(frame.size.width)) ? 0 : (frame.size.width - width) * 0.5;
    y = ((NSInteger)(height) == (NSInteger)(frame.size.height)) ? 0 : (frame.size.height - height) * 0.5;
    
    return CGRectMake(x, y, width, height);
}

-(void)show
{
//     NSLog(@"%@", self.scrollView.delegate);
    [[[UIApplication sharedApplication] keyWindow] addSubview: self];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
//    NSLog(@"%@", touches);
    self.scrollDelegate = nil;
    [self removeFromSuperview];
}

-(void)dealloc
{
    self.images = nil;
    NSLog(@"%s", __func__);
}

@end

@implementation PhotoBrowserDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = (NSInteger)(scrollView.contentOffset.x / self.target.frame.size.width);
    self.target.pageCtrl.currentPage = index;
}

@end
