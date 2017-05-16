//
//  ServiceInfoCell.h
//  services
//
//  Created by lqzhuang on 17/5/6.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceInfo.h"
@class ServiceInfoCell;

@protocol ServiceInfoCellDelegate <NSObject>

-(void)ServiceInfoCell:(ServiceInfoCell *)serviceInfoCell didClickCellImage:(NSArray *)images currentIndex:(NSIndexPath *)indexPath;

@end

@interface ServiceInfoCell : UITableViewCell

@property (nonatomic, weak) UIImageView *avatar;
@property (nonatomic, weak) UILabel *username;
@property (nonatomic, weak) UILabel *text;
@property (nonatomic, weak) UILabel *createdAt;
@property (nonatomic, weak) UICollectionView *images;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic,weak) id<ServiceInfoCellDelegate> delegate;


+(CGFloat)getCellHeight:(ServiceInfo *)info withFrame:(CGRect)frame;
-(CGFloat)getCellHeight;

+(instancetype)serviceInfoCell:(UITableView *)tableView withModel:(ServiceInfo *)serviceInfo withReuseID:(NSString *)reuseID;

@end
