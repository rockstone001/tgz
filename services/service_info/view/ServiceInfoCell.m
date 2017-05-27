//
//  ServiceInfoCell.m
//  services
//
//  Created by lqzhuang on 17/5/6.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "ServiceInfoCell.h"
//#import "UIImageView+AFNetworking.h"
#import "NSString+extension.h"
#import "UIImageView+WebCache.h"
//cell里子视图的间隔
#define kCellMargin 10
//cell里名字的高度
#define kUsernameHeight 30
//头像宽度
#define kAvatarWidth 50
//时间宽度
#define kTimeWidth 60
//单行高度
#define kLineHeight 30
//最大行数
#define kMaxLines 5
//图片一行张数
#define kCollectionItemRowNum 3

#define kCollectionCellId @"serviceInfoImageCell"
//cell的左右留白
#define kMarginLeftRight 10
//cell的顶部留白
#define kMarginTop 10
#define kSpacingLineHeight 1

@interface ServiceInfoCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UIView *wrapperView;

@property (nonatomic, copy) NSString *reuseID;

@end

@implementation ServiceInfoCell

-(UIView *)wrapperView
{
    if (!_wrapperView) {
        _wrapperView = [[UIView alloc] init];
        _wrapperView.backgroundColor = kLightGrayBG;
        //    cell.backgroundColor = [UIColor lightGrayColor];
        
        _wrapperView.layer.cornerRadius = 10;
        _wrapperView.layer.masksToBounds = YES;
        _wrapperView.frame = CGRectMake(0, 0, 375, 200);
    }
    return _wrapperView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)serviceInfoCell:(UITableView *)tableView withModel:(ServiceInfo *)serviceInfo withReuseID:(NSString *)reuseID indexPath:(NSIndexPath *)indexPath
{
    ServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[ServiceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.frame = tableView.frame;
    }
    //解决重叠问题
    [cell.wrapperView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [cell addSubviews];
    cell.reuseID = reuseID;
    cell.indexPath = indexPath;
    [cell setServiceInfo:serviceInfo];
    [cell layoutSubviews2];
    [cell bindEvent];
    
    return cell;
}


-(void)addSubviews
{
    UIImageView *avatar = [[UIImageView alloc] init];
    avatar.layer.cornerRadius = kAvatarWidth / 2;
    avatar.layer.masksToBounds = YES;
    UILabel *username = [[UILabel alloc] init];
    username.font = [UIFont systemFontOfSize:kTextSize];
    username.textColor = kLightBlue;
    UILabel *createdAt = [[UILabel alloc] init];
    createdAt.font = [UIFont systemFontOfSize:kTextSize];
    createdAt.textColor = kLightGray;
    UILabel *text = [[UILabel alloc] init];
    text.font = [UIFont systemFontOfSize:kTextSize];
    text.numberOfLines = 0;
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *images = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    images.dataSource = self;
    images.delegate = self;
    [images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellId];
    images.backgroundColor = kLightGrayBG;
    
    //增加签名属性
    UILabel *signature = [[UILabel alloc] init];
    signature.font = [UIFont systemFontOfSize:kSubTextSize];
    signature.textColor = kLightGray;
    signature.numberOfLines = 0;
    
    //增加间隔线
    UILabel *spacingLine = [[UILabel alloc] init];
    spacingLine.backgroundColor = kSpacingLineColor;
    
    //增加点赞、评论、私信图标
    LikeButton *like = [[LikeButton alloc] init];
    LikeButton *comment = [[LikeButton alloc] init];
    LikeButton *message = [[LikeButton alloc] init];
    [like setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    [comment setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [message setImage:[UIImage imageNamed:@"message"] forState:UIControlStateNormal];
    
    //增加优惠券的展示
    
    
    //关联到属性
    _avatar = avatar;
    _username = username;
    _createdAt = createdAt;
    _text = text;
    _images = images;
    _signature = signature;
    _like = like;
    _comment = comment;
    _message = message;
    _spacingLine = spacingLine;
    
    //添加到本控件
    [self.contentView addSubview:self.wrapperView];
    [self.wrapperView addSubview:self.avatar];
    [self.wrapperView addSubview:self.username];
    [self.wrapperView addSubview:self.createdAt];
    [self.wrapperView addSubview:self.text];
    [self.wrapperView addSubview:self.images];
    [self.wrapperView addSubview:self.signature];
    [self.wrapperView addSubview:self.like];
    [self.wrapperView addSubview:self.comment];
    [self.wrapperView addSubview:self.message];
    [self.wrapperView addSubview:self.spacingLine];
}

-(void)setServiceInfo:(ServiceInfo *)info
{
    self.imageList = info.images;
    //设置数据
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
//    [self.avatar setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    [self.username setText:info.username];
    [self.createdAt setText:info.createdAt];
    [self.text setText:info.text];
    [self.signature setText:info.signature];
    [self.like setTitle:[NSString stringWithFormat:@"赞(%@)", info.likes] forState:UIControlStateNormal];
    [self.comment setTitle:[NSString stringWithFormat:@"评论(%@)", info.comments] forState:UIControlStateNormal];
    [self.message setTitle:@"私信" forState:UIControlStateNormal];
    self.liked = info.liked ? YES : NO;
    if (self.liked) {
        [self.like setImage:[UIImage imageNamed:@"liked"] forState:UIControlStateNormal];
    }
    
    //优惠券
    NSMutableArray *marr = [NSMutableArray array];
    for (Coupon *coupon in info.coupons) {
        CouponView *couponView = [[CouponView alloc] initWithPrice:coupon.price withDesc:coupon.desc];
        couponView.isExpired = coupon.isExpired;
        [marr addObject:couponView];
    }
    _couponViews = marr;
}

-(void)layoutSubviews2
{
    CGFloat leftY = kCellMargin + kAvatarWidth;
    //设置子控件的frame
    self.avatar.frame = CGRectMake(kCellMargin, kCellMargin, kAvatarWidth, kAvatarWidth);
    
    CGFloat rightX = kCellMargin * 2 + kAvatarWidth;
    CGFloat cellWidth = self.frame.size.width - kCellMargin * 2 - kMarginLeftRight * 2;
    CGFloat rightWidth = self.frame.size.width - rightX - kCellMargin - kMarginLeftRight * 2;
    
    //时间
    CGFloat timeWidth = [self.createdAt.text getStringWidth:kTextSize];
    self.createdAt.frame = CGRectMake(rightX + rightWidth - timeWidth, kCellMargin, timeWidth, kAvatarWidth * 0.5);
    
    //用户名
    self.username.frame = CGRectMake(rightX, kCellMargin, rightWidth - timeWidth, kUsernameHeight);
    
    CGFloat y = kCellMargin + kUsernameHeight;
    //用户签名
    CGSize signatureSize = [self.signature.text getSizeWithMaxSize:CGSizeMake(rightWidth, kMaxLines * kLineHeight) fontSize:kSubTextSize];
    self.signature.frame = CGRectMake(rightX, y, signatureSize.width, signatureSize.height);
    
    y += signatureSize.height;
    
    y = y > leftY ? y : leftY;
    
    y += kCellMargin;
    
    //优惠券
    if (self.couponViews.count > 0) {
        CGFloat couponWidth = kCouponRightWidth + kCoupoLeftWidth;
        NSInteger index = 0;
        CGFloat x = kCellMargin;
        for (CouponView *couponView in self.couponViews) {
            [self.wrapperView addSubview:couponView];
            couponView.frame = CGRectMake(x, y, couponWidth, kCouponHeight);
            index ++;
            y += (index / 2.0 > 0 && index % 2 == 0) ? (kCouponHeight + kCellMargin) : 0;
            x = index % 2 == 0 ? kCellMargin : cellWidth - couponWidth + kCellMargin;
        }
        y += kCouponHeight + kCellMargin;
    }
    
    //图文的文字
    CGSize textSize = [self.text.text getSizeWithMaxSize:CGSizeMake(cellWidth, kMaxLines * kLineHeight) fontSize:kTextSize];
    self.text.frame = CGRectMake(kCellMargin, y, cellWidth, textSize.height);
    
    y += textSize.height + kCellMargin;
    if (self.imageList.count > 0) {
        CGFloat collectionItemWidth = (cellWidth - (kCollectionItemRowNum - 1) * kCellMargin) / kCollectionItemRowNum;
        NSInteger rowNum = ceil(self.imageList.count * 1.0 / kCollectionItemRowNum);
        CGFloat collectionHeight = rowNum * collectionItemWidth + (rowNum - 1) * kCellMargin;
        self.images.frame = CGRectMake(kCellMargin, y, cellWidth, collectionHeight);
//        NSLog(@"%@", NSStringFromCGRect(CGRectMake(rightX, y, rightWidth, collectionHeight)));
        y += kCellMargin + collectionHeight;
        self.layout.itemSize = CGSizeMake(collectionItemWidth, collectionItemWidth);
    }
    self.spacingLine.frame = CGRectMake(kCellMargin, y, cellWidth, kSpacingLineHeight);
    y += kSpacingLineHeight;
    //点赞、评论、私信
    CGFloat bottomBtnWidth = cellWidth / 3;
    CGRect bottomBtnFrame = CGRectMake(kCellMargin, y, bottomBtnWidth, kLikeBtnHeight);
    self.message.frame = bottomBtnFrame;
    bottomBtnFrame.origin.x += bottomBtnWidth;
    self.comment.frame = bottomBtnFrame;
    bottomBtnFrame.origin.x += bottomBtnWidth;
    self.like.frame = bottomBtnFrame;
    
    y += kLikeBtnHeight;
    
    self.wrapperView.frame = CGRectMake(kMarginLeftRight, kMarginTop, self.frame.size.width - 2 * kMarginLeftRight, y);
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.wrapperView.frame.size.height + kMarginTop);
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//    NSLog(@"%zd", self.imageList.count);
    return self.imageList.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellId forIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:cell.bounds];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.imageList[indexPath.row]]];
//    [imageView setImageWithURL:[NSURL URLWithString:self.imageList[indexPath.row]]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

+(CGFloat)getCellHeight:(ServiceInfo *)info withFrame:(CGRect)frame;
{
    CGFloat cellWidth = frame.size.width - kCellMargin * 2 - kMarginLeftRight * 2;
    CGFloat y = kCellMargin + kAvatarWidth;
    CGFloat rightX = kCellMargin * 2 + kAvatarWidth + kMarginLeftRight;
    CGFloat rightWidth = frame.size.width - rightX - kCellMargin - kMarginLeftRight;

    CGFloat rightY = kCellMargin + kUsernameHeight;
    
    rightY += [info.signature getSizeWithMaxSize:CGSizeMake(rightWidth, kMaxLines * kLineHeight) fontSize:kSubTextSize].height;
    
    y = y > rightY ? y : rightY;
    
    NSInteger couponRows = ceil(info.coupons.count / 2.0);
    if (couponRows > 0) {
        y += couponRows * (kCouponHeight + kCellMargin);
    }
    
    y += kCellMargin + [info.text getSizeWithMaxSize:CGSizeMake(cellWidth, kMaxLines * kLineHeight) fontSize:kTextSize].height;
    if (info.images.count > 0) {
        CGFloat collectionItemWidth = (cellWidth - (kCollectionItemRowNum - 1) * kCellMargin) / kCollectionItemRowNum;
        NSInteger rowNum = ceil(info.images.count * 1.0 / kCollectionItemRowNum);
        CGFloat collectionHeight = rowNum * collectionItemWidth + (rowNum - 1) * kCellMargin;
        
        y += kCellMargin + collectionHeight;
    }
    y += kSpacingLineHeight;
    y += kLikeBtnHeight;
    
    
    return y + kCellMargin + kMarginTop;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.collectionDelegate respondsToSelector:@selector(ServiceInfoCell:didClickCellImage:currentIndex:)]) {
        [self.collectionDelegate ServiceInfoCell:self didClickCellImage:self.imageList currentIndex:indexPath];
    }
}

-(void)bindEvent
{
    [self.like addTarget:self action:@selector(likeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.comment addTarget:self action:@selector(commentBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}

-(void)likeBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(ServiceInfoCell: didClickLikeButton:)]) {
        [self.delegate ServiceInfoCell:self didClickLikeButton:self.indexPath];
    }
}

-(void)commentBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(ServiceInfoCell: didClickCommentButton:)]) {
        [self.delegate ServiceInfoCell:self didClickCommentButton:self.indexPath];
    }
}

@end
