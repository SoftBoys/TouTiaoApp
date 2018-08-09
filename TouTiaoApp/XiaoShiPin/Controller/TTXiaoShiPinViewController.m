//
//  TTXiaoShiPinViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinViewController.h"

#import "TTURLManager.h"
#import "TTRequestManager.h"
#import "TTHomeNewsRequest.h"

#import "TTXiaoShiPinListModel.h"
#import "TTXiaoShiPinCell.h"

#import "TTXiaoShiPinDetailViewController.h"

@interface TTXiaoShiPinViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TTXiaoShiPinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"小视频";
    
    CGFloat collectionY = 0;
    if (self.is_subVC) {
        collectionY = 0;
        self.navigationBar.hidden = YES;
    } else {
        collectionY = kTopBarHeight;
        self.navigationBar.hidden = NO;
    }
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(collectionY);
    }];
    
    [self.collectionView registerClass:TTXiaoShiPinCell.class forCellWithReuseIdentifier:@"cellID"];
    
}
- (void)viewWillAppear:(BOOL)animated {
    if (!self.is_subVC) {
        [super viewWillAppear:animated];
    }
}

- (void)loadIsMore:(BOOL)more {
    
    NSString *urlString = TTURLManager.homeListURLString;
    [TTRequestManager cancelURLString:urlString];
    
    TTHomeNewsRequest *request = [TTHomeNewsRequest new];
    request.category = @"hotsoon_video";
    request.urlString = urlString;
    request.tt_from = !more ? @"pull":@"load_more";
    if (more) {
        request.max_behot_time = [NSString stringWithFormat:@"%.ld", (long)[[NSDate date] timeIntervalSince1970]];
    } else {
        request.min_behot_time = [NSString stringWithFormat:@"%.ld", (long)[[NSDate date] timeIntervalSince1970]];
    }
    [request sendRequestWithCompletion:^(id responseJSON, NSError *error) {
        dispatch_global_async(^{
            more ?: [self.dataArray removeAllObjects];
            if (responseJSON) {
                NSArray *data = responseJSON[@"data"];
                for (NSDictionary *dict in data) {
                    TTXiaoShiPinListModel *model = [TTXiaoShiPinListModel mj_objectWithKeyValues:dict];
                    [model model];
                    [self.dataArray addObject:model];
                }
                
            }
            
            dispatch_main_async_safe(^{
                [self endHeaderFooterRefresh];
                [self.collectionView reloadData];
            });
        });
        
        
    }];
    
    
}
#pragma mark -
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTXiaoShiPinCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.item];
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TTXiaoShiPinListModel *detail = self.dataArray[indexPath.item];
    TTXiaoShiPinDetailViewController *detailVC = [TTXiaoShiPinDetailViewController new];
    detailVC.detail = detail;
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark -

#pragma mark -
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
