//
//  SearchHistoryView.h
//  services
//
//  Created by lqzhuang on 17/5/15.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchHistoryView;

@protocol SearchHistoryDelegate <NSObject>

-(void)SearchHistory:(SearchHistoryView *)view closeBtnClicked:(NSString *)text;
-(void)SearchHistory:(SearchHistoryView *)view textBtnClicked:(NSString *)text;
@end


@interface SearchHistoryView : UICollectionReusableView

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, weak) id<SearchHistoryDelegate> delegate;
@property (nonatomic, copy) NSString *type;

-(void)setDataWithType:(NSString *)type;

@end
