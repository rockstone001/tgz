//
//  NSString+extension.m
//  0118-QQ聊天
//
//  Created by lqzhuang on 17/1/20.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)

-(CGSize)getSizeWithMaxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize
{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}

-(CGFloat)getStringWidth:(CGFloat)fontSize
{
    return [self sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}].width;
}

- (NSString *)VerticalString{
    NSMutableString * str = [[NSMutableString alloc] initWithString:self];
    NSInteger count = str.length;
    for (int i = 1; i < count; i ++) {
        [str insertString:@"\n" atIndex:i*2 - 1];
    }
    return str;
}


@end
