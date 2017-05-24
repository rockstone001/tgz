//
//  MerchantsViewController.h
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowLayout.h"

@interface MerchantsViewController : UICollectionViewController

@property (nonatomic, copy) NSString *type;

-(void)refreshList;

@end
