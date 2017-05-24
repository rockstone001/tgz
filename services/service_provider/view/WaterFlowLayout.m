//
//  WaterFlowLayout.m
//  services
//
//  Created by lqzhuang on 17/5/22.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "WaterFlowLayout.h"
//cell的间隔
#define kCellMargin 8
//瀑布流的列数
#define kColCount 2

@interface WaterFlowLayout()

@property (nonatomic, strong) NSMutableArray *attrs;
@property (nonatomic, strong) NSMutableArray *currentColumn;

@end

@implementation WaterFlowLayout

-(NSMutableArray *)attrs
{
    if (!_attrs) {
        _attrs = [NSMutableArray array];
    }
    return _attrs;
}

-(NSMutableArray *)currentColumn
{
    if (!_currentColumn) {
        _currentColumn = [NSMutableArray array];
        [_currentColumn addObject:@{@"x":@(kCellMargin), @"y":@(kCellMargin + kHeaderViewHeight)}];
        [_currentColumn addObject:@{@"x":@(kCellMargin * 2 + self.cellWidth), @"y":@(kCellMargin + kHeaderViewHeight)}];
    }
    return _currentColumn;
}

//初始化操作
-(void)prepareLayout
{
    [super prepareLayout];
    //自定义代码
    self.cellWidth = (self.collectionView.bounds.size.width - kCellMargin * (kColCount + 1) ) / kColCount;
    [self.attrs removeAllObjects];
    self.currentColumn = nil;
    
    //    NSLog(@"all attrs = %@", self.attrs);
    
    UICollectionViewLayoutAttributes *headerAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
    headerAttrs.frame = CGRectMake(0, 0, self.collectionView.bounds.size.width, kHeaderViewHeight);
    [self.attrs addObject:headerAttrs];
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    //    NSMutableArray *array = [NSMutableArray array];
    NSInteger items = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < items; i++) {
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrs addObject:attr];
    }
    
    return [self.attrs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attrs = nil;
    if (indexPath.row + 1 >= self.attrs.count) {
        attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat height = [self.layoutDelegate WaterFlowLayout:self getCellHeightAtIndexPath:indexPath];
        CGFloat x, y;
        NSDictionary *col1 = [self.currentColumn objectAtIndex:0];
        NSDictionary *col2 = [self.currentColumn objectAtIndex:1];
        if ([col1[@"y"] floatValue] <= [col2[@"y"] floatValue]) {
            x = [col1[@"x"] floatValue];
            y = [col1[@"y"] floatValue];
            [self.currentColumn replaceObjectAtIndex:0 withObject:@{@"x":@(kCellMargin), @"y":@(y + kCellMargin + height)}];
        } else {
            x = [col2[@"x"] floatValue];
            y = [col2[@"y"] floatValue];
            [self.currentColumn replaceObjectAtIndex:1 withObject:@{@"x":@(kCellMargin * 2 + self.cellWidth), @"y":@(y + kCellMargin + height)}];
        }
        
        attrs.frame = CGRectMake(x, y, self.cellWidth, height);
    } else {
        attrs = self.attrs[indexPath.row + 1];
    }

    return attrs;
}


//可滚动范围
-(CGSize)collectionViewContentSize
{
    CGFloat longest = [self.currentColumn[0][@"y"] floatValue];
    for (NSInteger i =0; i < self.currentColumn.count; i++) {
        CGFloat rolHeight = [self.currentColumn[i][@"y"] floatValue];
        if(longest < rolHeight){
            longest = rolHeight;
        }
    }
    return CGSizeMake(self.collectionView.frame.size.width, longest);
}

//这个函数不一定有用 先放着
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

//-(CGSize)headerReferenceSize
//{
//    return CGSizeMake(300, 100);
//}

@end
