//
//  MerchantSearchResultViewController.m
//  services
//
//  Created by lqzhuang on 17/5/24.
//  Copyright © 2017年 lqzhuang. All rights reserved.
//

#import "MerchantSearchResultViewController.h"
#import "WaterFlowLayout.h"
#import "SearchHistoryView.h"
#import "MerchantCell.h"
#import "SearchViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface MerchantSearchResultViewController () <WaterFlowLayoutDelegate, CLLocationManagerDelegate, UICollectionViewDelegateFlowLayout, SearchHistoryDelegate>


@property (nonatomic, strong) NSMutableArray *merchants;

@property (nonatomic, strong) CLLocationManager *locManager;

@property (nonatomic, assign) CGFloat longitude; //经度
@property (nonatomic, assign) CGFloat latitude; //纬度

@property (nonatomic, copy) NSString *searchText;

@end

@implementation MerchantSearchResultViewController

static NSString * const reuseIdForSearch = @"merchantCellID";
static NSString * const headerReuseIdForSearch = @"headerID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MerchantCell class] forCellWithReuseIdentifier:reuseIdForSearch];
    [self.collectionView registerClass:[SearchHistoryView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdForSearch];
    
    ((WaterFlowLayout *)self.collectionView.collectionViewLayout).layoutDelegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)merchants
{
    if (!_merchants) {
        _merchants = [NSMutableArray array];
    }
    return _merchants;
}

-(CLLocationManager *)locManager
{
    if (!_locManager) {
        _locManager = [[CLLocationManager alloc] init];
        _locManager.delegate = self;
        
        if ([_locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [_locManager requestWhenInUseAuthorization];
        }
    }
    return _locManager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.merchants.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MerchantCell *cell = (MerchantCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdForSearch forIndexPath:indexPath];
    [cell setData:(Merchant *)self.merchants[indexPath.row]];
//    NSLog(@"cell == %@", cell);
    
    return cell;

}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(void)refreshList
{
    NSString *urlString = [kAPIHost stringByAppendingPathComponent:kSearchMerchants];
    if ([self.type isEqualToString:@"附近"]) {
        if (!self.longitude) {
            if ([CLLocationManager locationServicesEnabled]) { // 判断是否打开了位置服务
                [self.locManager startUpdatingLocation]; // 开始更新位置
            }
            return;
        }
    } else {
        //        urlString = [kAPIHost stringByAppendingPathComponent:kGetMerchants];
    }
    
    //    NSLog(@"%@", urlString);
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:5];
    [[manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        //        NSLog(@"%@", responseObject);
        //        NSLog(@"http response");
        if (responseObject[@"code"] && [responseObject[@"code"] integerValue] == 0) {
            [self.merchants removeAllObjects];
            for (NSDictionary *dict in responseObject[@"msg"]) {
//                                NSLog(@"%@", dict);
                Merchant *merchant = [Merchant merchant:dict];
                [self.merchants addObject:merchant];
            }
            [self.collectionView reloadData];
        }
    }] resume];
}


#pragma mark <WaterFlowLayoutDelegate>
-(CGFloat)WaterFlowLayout:(WaterFlowLayout *)collectionViewLayout getCellHeightAtIndexPath:(NSIndexPath *)indexPath
{
    Merchant *merchant = (Merchant *)self.merchants[indexPath.row];
    return [MerchantCell getCellHeight:merchant withCellWidth:collectionViewLayout.cellWidth];
}

#pragma mark <CLLocationManagerDelegate>
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    self.longitude = location.coordinate.longitude;
    self.latitude = location.coordinate.latitude;
    [self.locManager stopUpdatingLocation];
    //    NSLog(@"%.5f, %.5f", self.longitude, self.latitude);
    [self refreshList];
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    SearchHistoryView *view = [[SearchHistoryView alloc] init];
    [view setDataWithType:kMerchantSearchPlaceHolder];
    return view.bounds.size;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        SearchHistoryView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReuseIdForSearch forIndexPath:indexPath];
        view.delegate = self;
        [view setDataWithType:kMerchantSearchPlaceHolder];
        return view;
    }
    return nil;
    //    NSLog(@"%@", view);
}

#pragma mark <SearchViewDelegate>
-(void)searchView:(SearchViewController *)searchViewController refreshSearchResult:(NSString *)searchText
{
    if ([searchText isEqualToString:@""]) {
        //搜索关键字为空 显示搜索历史
        SearchHistoryView *historyView = [[SearchHistoryView alloc] init];
        [historyView setDataWithType:kSearchPlaceHolder];
        historyView.delegate = self;
        self.merchants = nil;
        self.collectionView.tag = 0;
        [self.collectionView reloadData];
    } else {
//        NSLog(@"text === %@", searchText);
        //不为空 显示搜索结果
        self.collectionView.tag = 1;
        [self refreshList];
    }
}

#pragma mark <SearchHistoryDelegate>
-(void)SearchHistory:(SearchHistoryView *)view closeBtnClicked:(NSString *)text
{
//    [self.collectionView reloadData];
}

-(void)SearchHistory:(SearchHistoryView *)view textBtnClicked:(NSString *)text
{
    SearchViewController *svc = (SearchViewController *)self.parentViewController;
    svc.searchBar.text = text;
    [svc searchBar:svc.searchBar textDidChange:text];
    [svc.searchBar resignFirstResponder];
    [svc setCancelBtnEnabled];
}

@end
