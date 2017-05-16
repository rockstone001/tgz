//
//  ServiceInfoCell.m
//  services
//
//  Created by lqzhuang on 17/5/6.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "ServiceInfoCell.h"
#import "UIImageView+AFNetworking.h"
#import "NSString+extension.h"
#define kCellMargin 10
#define kAvatarWidth 50
#define kTextSize 14
#define kTimeSize 12
#define kLineHeight 30
#define kMaxLines 5
#define kCollectionItemRowNum 3
#define kCollectionCellId @"serviceInfoImageCell"



@interface ServiceInfoCell() <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, copy) NSString *reuseID;

@end

@implementation ServiceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)serviceInfoCell:(UITableView *)tableView withModel:(ServiceInfo *)serviceInfo withReuseID:(NSString *)reuseID
{
    ServiceInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[ServiceInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        //设置cell的宽度
        CGRect tmp = cell.frame;
        tmp.size.width = tableView.frame.size.width;
        cell.frame = tmp;
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell addSubviews];
    cell.reuseID = reuseID;
    [cell setServiceInfo:serviceInfo];
    [cell layoutSubviews];
    
    cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
//    cell.backgroundColor = [UIColor lightGrayColor];
    
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    
    return cell;
}


-(void)addSubviews
{
    UIImageView *avatar = [[UIImageView alloc] init];
    UILabel *username = [[UILabel alloc] init];
    username.font = [UIFont systemFontOfSize:kTextSize];
    username.textColor = [UIColor colorWithRed:93/255.0 green:112/255.0 blue:151/255.0 alpha:1];
    UILabel *createdAt = [[UILabel alloc] init];
    createdAt.font = [UIFont systemFontOfSize:kTimeSize];
    createdAt.textColor = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1];
    UILabel *text = [[UILabel alloc] init];
    text.font = [UIFont systemFontOfSize:kTextSize];
    text.numberOfLines = 0;
    self.layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *images = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    images.dataSource = self;
    images.delegate = self;
    [images registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellId];
    images.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    //关联到属性
    _avatar = avatar;
    _username = username;
    _createdAt = createdAt;
    _text = text;
    _images = images;
    
    //添加到本控件
    [self.contentView addSubview:self.avatar];
    [self.contentView addSubview:self.username];
    [self.contentView addSubview:self.createdAt];
    [self.contentView addSubview:self.text];
    [self.contentView addSubview:self.images];
}

-(void)setServiceInfo:(ServiceInfo *)info
{
    self.imageList = info.images;
    //设置数据
    [self.avatar setImageWithURL:[NSURL URLWithString:info.avatar] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    [self.username setText:info.username];
    [self.createdAt setText:info.createdAt];
    [self.text setText:info.text];
    
//    CGRect frame = self.bounds;
//    frame.size.height = [self getCellHeight];
//    
//    self.frame = frame;
//    NSLog(@"%@", NSStringFromCGRect(self.frame));
}

-(void)layoutSubviews
{
    //设置子控件的frame
    self.avatar.frame = CGRectMake(kCellMargin, kCellMargin, kAvatarWidth, kAvatarWidth);
    
    CGFloat rightX = kCellMargin * 2 + kAvatarWidth;
    CGFloat rightWidth = self.frame.size.width - rightX - kCellMargin;
    
    CGSize usernameSize = [self.username.text getSizeWithMaxSize:CGSizeMake(rightWidth, kLineHeight) fontSize:kTextSize];
    self.username.frame = CGRectMake(rightX, kCellMargin, rightWidth, usernameSize.height);
    
    CGFloat y = kCellMargin * 2 + usernameSize.height;
    CGSize textSize = [self.text.text getSizeWithMaxSize:CGSizeMake(rightWidth, kMaxLines * kLineHeight) fontSize:kTextSize];
    self.text.frame = CGRectMake(rightX, y, rightWidth, textSize.height);
    
    y += textSize.height + kCellMargin;
    if (self.imageList.count > 0) {
        CGFloat collectionItemWidth = (rightWidth - (kCollectionItemRowNum - 1) * kCellMargin) / kCollectionItemRowNum;
        NSInteger rowNum = ceil(self.imageList.count * 1.0 / kCollectionItemRowNum);
        CGFloat collectionHeight = rowNum * collectionItemWidth + (rowNum - 1) * kCellMargin;
        self.images.frame = CGRectMake(rightX, y, rightWidth, collectionHeight);
//        NSLog(@"%@", NSStringFromCGRect(CGRectMake(rightX, y, rightWidth, collectionHeight)));
        y += kCellMargin * 2 + collectionHeight;
        self.layout.itemSize = CGSizeMake(collectionItemWidth, collectionItemWidth);
    }
    
    CGSize createdAtSize = [self.createdAt.text getSizeWithMaxSize:CGSizeMake(rightWidth, kLineHeight) fontSize:kTimeSize];
    self.createdAt.frame = CGRectMake(rightX, y, rightWidth, createdAtSize.height);
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
    
    [imageView setImageWithURL:[NSURL URLWithString:self.imageList[indexPath.row]]];
    [cell.contentView addSubview:imageView];
    
    return cell;
}

+(CGFloat)getCellHeight:(ServiceInfo *)info withFrame:(CGRect)frame;
{
    CGFloat y = kCellMargin + kAvatarWidth;
    CGFloat rightX = kCellMargin * 2 + kAvatarWidth;
    CGFloat rightWidth = frame.size.width - rightX - kCellMargin;

    CGFloat rightY = kCellMargin + [info.username getSizeWithMaxSize:CGSizeMake(rightWidth, kLineHeight) fontSize:kTextSize].height;
    rightY += kCellMargin * 2 + [info.text getSizeWithMaxSize:CGSizeMake(rightWidth, kMaxLines * kLineHeight) fontSize:kTextSize].height;
    if (info.images.count > 0) {
        CGFloat collectionItemWidth = (rightWidth - (kCollectionItemRowNum - 1) * kCellMargin) / kCollectionItemRowNum;
        NSInteger rowNum = ceil(info.images.count * 1.0 / kCollectionItemRowNum);
        CGFloat collectionHeight = rowNum * collectionItemWidth + (rowNum - 1) * kCellMargin;
        
        rightY += kCellMargin * 2 + collectionHeight;
    }
    rightY += kCellMargin * 2 + [info.createdAt getSizeWithMaxSize:CGSizeMake(rightWidth, kLineHeight) fontSize:kTimeSize].height;
    
    return (y > rightY ? y : rightY) + kCellMargin;
}

-(CGFloat)getCellHeight
{
    CGFloat y = kCellMargin + kAvatarWidth;
    CGFloat rightX = kCellMargin * 2 + kAvatarWidth;
    CGFloat rightWidth = self.frame.size.width - rightX - kCellMargin;
    
    CGFloat rightY = kCellMargin + [self.username.text getSizeWithMaxSize:CGSizeMake(rightWidth, kLineHeight) fontSize:kTextSize].height;
    rightY += kCellMargin * 2 + [self.text.text getSizeWithMaxSize:CGSizeMake(rightWidth, kMaxLines * kLineHeight) fontSize:kTextSize].height;
    if (self.imageList.count > 0) {
        CGFloat collectionItemWidth = (rightWidth - (kCollectionItemRowNum - 1) * kCellMargin) / kCollectionItemRowNum;
        NSInteger rowNum = ceil(self.imageList.count * 1.0 / kCollectionItemRowNum);
        CGFloat collectionHeight = rowNum * collectionItemWidth + (rowNum - 1) * kCellMargin;
        
        rightY += kCellMargin * 2 + collectionHeight;
    }
    rightY += kCellMargin * 2 + [self.createdAt.text getSizeWithMaxSize:CGSizeMake(rightWidth, kLineHeight) fontSize:kTimeSize].height;
    
    return (y > rightY ? y : rightY) + kCellMargin;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(ServiceInfoCell:didClickCellImage:currentIndex:)]) {
        [self.delegate ServiceInfoCell:self didClickCellImage:self.imageList currentIndex:indexPath];
    }
}

@end
