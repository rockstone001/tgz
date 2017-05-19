//
//  ServiceInfoCell.h
//  services
//
//  Created by lqzhuang on 17/5/6.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceInfo.h"
#import "LikeButton.h"
#import "CouponView.h"
@class ServiceInfoCell;

@protocol ServiceInfoCollectionCellDelegate <NSObject>

-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCellImage:(NSArray *)images currentIndex:(NSIndexPath *)indexPath;

@end

@protocol ServiceInfoCellDelegate <NSObject>

-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickLikeButton:(NSIndexPath *)indexPath;
-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCommentButton:(NSIndexPath *)indexPath;
@end

@interface ServiceInfoCell : UITableViewCell

@property (nonatomic, weak) UIImageView *avatar;
@property (nonatomic, weak) UILabel *username;
@property (nonatomic, weak) UILabel *text;
@property (nonatomic, weak) UILabel *createdAt;
@property (nonatomic, weak) UICollectionView *images;
@property (nonatomic, weak) UILabel *signature;
@property (nonatomic, weak) LikeButton *like;
@property (nonatomic, assign) BOOL liked;
@property (nonatomic, weak) LikeButton *comment;
@property (nonatomic, weak) LikeButton *message;
@property (nonatomic, weak) UILabel *spacingLine;
@property (nonatomic, assign) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray <CouponView *> *couponViews;



@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic,weak) id<ServiceInfoCollectionCellDelegate> collectionDelegate;
@property (nonatomic,weak) id<ServiceInfoCellDelegate> delegate;

+(CGFloat)getCellHeight:(ServiceInfo *)info withFrame:(CGRect)frame;

+(instancetype)serviceInfoCell:(UITableView *)tableView withModel:(ServiceInfo *)serviceInfo withReuseID:(NSString *)reuseID indexPath:(NSIndexPath *)indexPath;

@end
