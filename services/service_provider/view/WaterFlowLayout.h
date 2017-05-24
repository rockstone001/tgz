//
//  WaterFlowLayout.h
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>

-(CGFloat)WaterFlowLayout:(WaterFlowLayout *)collectionViewLayout getCellHeightAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface WaterFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <WaterFlowLayoutDelegate> layoutDelegate;

@property (nonatomic, assign) CGFloat cellWidth;

@end
