//
//  MerchantCell.m
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MerchantCell.h"
#import "DistanceButton.h"
//#import "UIImageView+AFNetworking.h"
#import "NSString+extension.h"
#import "UIImageView+WebCache.h"

//cell里子视图的间隔
#define kCellMargin 8
//cell里名字的高度
#define kNameHeight 30
//icon宽度
#define kIconWidth 40
//单行高度
#define kLineHeight 30
//最大行数
#define kMaxLines 5
//粉丝数和距离的Btn的宽度
#define kBtnWidth 65
//关注btn的宽度
#define kFollowBtnWidth 45
//btn的高度
#define kBtnHeight 20

//商家名字的文字大小
#define knameTextSize 13


@interface MerchantCell ()

@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) DistanceButton *follows;
@property (nonatomic, strong) DistanceButton *distance;
@property (nonatomic, strong) UIButton *follow;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *desc;
@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;

@property (nonatomic, assign) CGFloat cellWidth;

@end


@implementation MerchantCell

-(void)setData:(Merchant *)merchant
{
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    _cellWidth = self.frame.size.width - kCellMargin * 2;
    [self setAttributes:merchant];
    [self addSubviews];
    self.backgroundColor = kLightGrayBG;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    [self layoutSubviews];
}

-(void)setAttributes:(Merchant *)merchant
{
    CGFloat width = 0;
    //商家头像
    _icon = [[UIImageView alloc] init];
    _icon.bounds = CGRectMake(0, 0, kIconWidth, kIconWidth);
    [_icon sd_setImageWithURL:[NSURL URLWithString:merchant.icon]];
    _icon.layer.cornerRadius = kIconWidth * 0.5;
    _icon.layer.masksToBounds = YES;
    //商家的名字
    _name = [[UILabel alloc] init];
    _name.font = [UIFont systemFontOfSize:knameTextSize];
    _name.textColor = [UIColor blackColor];
    _name.text = merchant.name;
    width = [merchant.name getStringWidth:knameTextSize];
    if (width > _cellWidth - kIconWidth - kCellMargin) {
        width = _cellWidth - kIconWidth - kCellMargin;
    }
    _name.bounds = CGRectMake(0, 0, width, kLineHeight);
    //商家的粉丝数
    _follows = [[DistanceButton alloc] init];
    [_follows setImage:[UIImage imageNamed:@"grayHeart"] forState:UIControlStateNormal];
    [_follows setImage:[UIImage imageNamed:@"heart"] forState:UIControlStateSelected];
    [_follows setTitle:merchant.follows forState:UIControlStateNormal];
    _follows.bounds = CGRectMake(0, 0, kBtnWidth, kBtnHeight);
    
    //关注商家按钮
    _follow = [[UIButton alloc] init];
    [_follow setTitle:@"关注" forState:UIControlStateNormal];
    [_follow setTitle:@"已关注" forState:UIControlStateSelected];
    _follow.titleLabel.font = [UIFont systemFontOfSize:kSubTextSize];
    [_follow setBackgroundColor:kSpacingLineColor];
    [_follow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _follow.layer.cornerRadius = 5;
    _follow.layer.masksToBounds = YES;
    
    _follow.bounds = CGRectMake(0, 0, kFollowBtnWidth, kBtnHeight);
    //商家的距离
    _distance = [[DistanceButton alloc] init];
    [_distance setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [_distance setTitle:merchant.distance forState:UIControlStateNormal];
    _distance.bounds = CGRectMake(0, 0, kBtnWidth, kBtnHeight);
    
    //商家的宣传图
    _logo = [[UIImageView alloc] init];
    [_logo sd_setImageWithURL:[NSURL URLWithString:merchant.logo]];
    
    CGFloat imageHeight = [merchant.imageHeight floatValue] / [merchant.imageWidth floatValue] * _cellWidth;
    _logo.bounds = CGRectMake(0, 0, _cellWidth, imageHeight);
    
    //商家的口号
    _desc = [[UILabel alloc] init];
    _desc.font = [UIFont systemFontOfSize:knameTextSize];
    _desc.textColor = kLightGray;
    _desc.text = merchant.desc;
    _desc.numberOfLines = 0;
    CGSize size = [merchant.desc getSizeWithMaxSize:CGSizeMake(_cellWidth, kLineHeight * kMaxLines) fontSize:knameTextSize];
    _desc.bounds = CGRectMake(0, 0, size.width, size.height);
//    _desc.backgroundColor = [UIColor redColor];
}

-(void)addSubviews
{
    [self.contentView addSubview:_icon];
    [self.contentView addSubview:_name];
    [self.contentView addSubview:_follows];
    [self.contentView addSubview:_distance];
    [self.contentView addSubview:_follow];
    [self.contentView addSubview:_logo];
    [self.contentView addSubview:_desc];
}

-(void)layoutSubviews
{
    CGRect frame = _icon.bounds;
    CGFloat height = 0;
    frame.origin.x = kCellMargin;
    frame.origin.y = kCellMargin;
    _icon.frame = frame;
    
    frame = _name.bounds;
    frame.origin.x = kCellMargin * 2 + _icon.bounds.size.width;
    frame.origin.y = kCellMargin;
    _name.frame = frame;
    
    frame = _follows.bounds;
    frame.origin.x = kCellMargin * 2 + _icon.bounds.size.width;
    frame.origin.y = kCellMargin * 2 + _name.bounds.size.height;
    _follows.frame = frame;
    
    frame = _follow.bounds;
    frame.origin.y = kCellMargin * 2 + _name.bounds.size.height;
    frame.origin.x = _cellWidth + kCellMargin - _follow.bounds.size.width;
    _follow.frame = frame;
    
    height = kCellMargin * 2 + _icon.bounds.size.height;
    if (height < (kCellMargin * 3 + _name.bounds.size.height + _follow.bounds.size.height)) {
        height = kCellMargin * 3 + _name.bounds.size.height + _follow.bounds.size.height;
    }
    
    frame = _distance.bounds;
    frame.origin.x = kCellMargin;
    frame.origin.y = height;
    _distance.frame = frame;
    height += _distance.bounds.size.height + kCellMargin;
    
    frame = _logo.bounds;
    frame.origin.x = kCellMargin;
    frame.origin.y = height;
    _logo.frame = frame;
    height += _logo.bounds.size.height + kCellMargin;
    
    frame = _desc.bounds;
    frame.origin.x = kCellMargin;
    frame.origin.y = height;
    _desc.frame = frame;
    height += _desc.bounds.size.height + kCellMargin;
    
//    self.bounds = CGRectMake(0, 0, _cellWidth + 2 * kCellMargin, height);
    
}

+(CGFloat)getCellHeight:(Merchant *)merchant withCellWidth:(CGFloat)cellWidth
{
    CGFloat height = kCellMargin * 2 + kIconWidth;
    
    if (height < (kCellMargin * 3 + kLineHeight + kBtnHeight)) {
        height = kCellMargin * 3 + kLineHeight + kBtnHeight;
    }
    //距离
    height += kCellMargin + kBtnHeight;
    //logo
    CGFloat imageHeight = [merchant.imageHeight floatValue] / [merchant.imageWidth floatValue] * (cellWidth - 2 * kCellMargin);
    height += kCellMargin + imageHeight;
    
    //desc
    CGSize size = [merchant.desc getSizeWithMaxSize:CGSizeMake(cellWidth, kLineHeight * kMaxLines) fontSize:knameTextSize];
    height += size.height + kCellMargin;
    
    return height;
}

//-(void)prepareForReuse
//{
//    [super prepareForReuse];
//}

@end
