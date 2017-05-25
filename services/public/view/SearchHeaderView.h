//
//  SearchHeaderView.h
//  services
//
//  Created by lqzhuang on 17/5/24.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchHeaderView : UIView

@property (nonatomic, weak) UISearchBar *searchBar;

@property (nonatomic, copy) NSString *type;

-(instancetype)initWithFrame:(CGRect)frame withType:(NSString *)type;

@end
