//
//  NSString+extension.h
//  0118-QQ聊天
//
//  Created by lqzhuang on 17/1/20.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (extension)

-(CGSize)getSizeWithMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize;

-(CGFloat)getStringWidth:(CGFloat)fontSize;

-(NSString *)VerticalString;
@end
