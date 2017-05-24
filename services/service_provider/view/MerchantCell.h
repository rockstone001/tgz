//
//  MerchantCell.h
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Merchant.h"

@interface MerchantCell : UICollectionViewCell

-(void)setData:(Merchant *)merchant;

+(CGFloat)getCellHeight:(Merchant *)merchant withCellWidth:(CGFloat)cellWidth;

@end
