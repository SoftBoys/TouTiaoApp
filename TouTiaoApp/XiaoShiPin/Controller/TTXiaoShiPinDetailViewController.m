//
//  TTXiaoShiPinDetailViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinDetailViewController.h"
#import "TTXiaoShiPinDetailCollectionView.h"
#import "TTXiaoShiPinDetailCell.h"

#import "TTRequestManager.h"
#import "TTHomeNewsRequest.h"
#import "TTXiaoShiPinListModel.h"

#import "TTURLHandleManager.h"

#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import "TTXiaoShiPinControlView.h"



@interface TTXiaoShiPinDetailViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate, TTXiaoShiPinDetailCell>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *urls;
@property (nonatomic, strong) TTXiaoShiPinDetailCollectionView *collectionView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) TTXiaoShiPinControlView *controlView;
@end

@implementation TTXiaoShiPinDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [UIApplication sharedApplication].statusBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.player.currentPlayerManager.playState == ZFPlayerPlayStatePaused) {
        [self.player.currentPlayerManager  play];
    }
    
    
    
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.player.currentPlayerManager.isPlaying) {
        [self.player.currentPlayerManager pause];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.frame = self.view.bounds;
    
    self.navigationBar.hidden = YES;
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[TTXiaoShiPinDetailCell class] forCellWithReuseIdentifier:@"detailID"];
    
//    self.player;
    
    [self loadMore:NO];
    
    self.collectionView.alwaysBounceHorizontal = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = YES;
 
    
}

- (void)loadMore:(BOOL)more {
    NSString *urlString = TTURLManager.homeListURLString;
    [TTRequestManager cancelURLString:urlString];
    
    
    TTHomeNewsRequest *request = [TTHomeNewsRequest new];
    request.category = @"hotsoon_video_detail_draw";
    request.urlString = urlString;
    request.tt_from = @"pre_load_more_draw";
    request.count = 20;
//    if (more) {
//        request.max_behot_time = [NSString stringWithFormat:@"%.ld", (long)[[NSDate date] timeIntervalSince1970]];
//    } else {
//        request.min_behot_time = [NSString stringWithFormat:@"%.ld", (long)[[NSDate date] timeIntervalSince1970]];
//    }
    [request sendRequestWithCompletion:^(id responseJSON, NSError *error) {
        dispatch_global_async(^{
            more ?: [self.dataArray removeAllObjects];
            more ?: [self.urls removeAllObjects];
            if (responseJSON) {
                NSArray *data = responseJSON[@"data"];
                for (NSDictionary *dict in data) {
                    TTXiaoShiPinListModel *model = [TTXiaoShiPinListModel mj_objectWithKeyValues:dict];
                    [model model];
                    [self.dataArray addObject:model];
                    
                    NSString *url = model.model.play_addr.url_list.firstObject;
                    [self.urls addObject:[NSURL URLWithString:url]];
                }
            }
            if (self.detail) {
                [self.dataArray insertObject:self.detail atIndex:0];
            }
            dispatch_main_async_safe(^{
                
                [self.collectionView reloadData];
                
                NSIndexPath *indexPath = self.collectionView.zf_playingIndexPath;
                
                self.player.assetURLs = self.urls;
                
                if (!more) {
                    [self.collectionView layoutIfNeeded];
                    [self.collectionView setContentOffset:CGPointMake(0, 0)];
                    __weak typeof(self) weakself = self;
                    [self.collectionView zf_filterShouldPlayCellWhileScrolled:^(NSIndexPath * _Nonnull indexPath) {
                        __strong typeof(weakself) strongself = weakself;
                        [strongself playVideoAtIndexPath:indexPath];
                    }];
                }
                
                if (indexPath) {
                    [self playVideoAtIndexPath:indexPath];
                }
                
            });
        });
        
        
    }];
}
- (void)playVideoAtIndexPath:(NSIndexPath *)indexPath {
    TTXiaoShiPinListModel *model = self.dataArray[indexPath.item];
    
    NSString *playURL = model.model.play_addr.url_list.firstObject;
    [self.player playTheIndexPath:indexPath assetURL:[NSURL URLWithString:playURL] scrollToTop:NO];
//    [self.player playTheIndexPath:indexPath scrollToTop:NO];
    
    [self.controlView resetControlView];
    NSString *coverURL = model.model.first_frame_image_list.firstObject.url;
    [self.controlView setCoverImageWithURLString:coverURL];
    
}
#pragma mark -
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTXiaoShiPinListModel *model = self.dataArray[indexPath.item];
    TTXiaoShiPinDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailID" forIndexPath:indexPath];
    cell.delegate = self;
    cell.model = model;
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataArray count];
}
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    return;
    if (scrollView == self.collectionView) {
        CGFloat offsetX = scrollView.contentOffset.x + scrollView.contentInset.left;
        if (offsetX < 0) {
            scrollView.scrollEnabled = NO;
        } else {
            scrollView.scrollEnabled = YES;
        }
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating");
}
#pragma mark - TTXiaoShiPinDetailCell
- (void)closeXiaoShiPinCell:(TTXiaoShiPinDetailCell *)cell {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (TTXiaoShiPinDetailCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        flowLayout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        TTXiaoShiPinDetailCollectionView *collectionView = [[TTXiaoShiPinDetailCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
        
        __weak typeof(self) weakself = self;
        _collectionView.zf_scrollViewDidStopScrollCallback = ^(NSIndexPath * _Nonnull indexPath) {
            __strong typeof(weakself) strongself = weakself;
            if (indexPath.item == strongself.dataArray.count - 1) {
//                [strongself loadMore:YES];
            }
            [strongself playVideoAtIndexPath:indexPath];
        };
        
    }
    return _collectionView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (NSMutableArray *)urls {
    if (!_urls) {
        _urls = @[].mutableCopy;
    }
    return _urls;
}
- (ZFPlayerController *)player {
    if (!_player) {
        ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
        
        _player = [ZFPlayerController playerWithScrollView:self.collectionView playerManager:playerManager containerViewTag:kXiaoShiPinContainerViewTag];
        
        
        _player.controlView = self.controlView;
        
        _player.playerDisapperaPercent = 0.8;
        _player.WWANAutoPlay = YES;
        _player.allowOrentitaionRotation = NO;
        
        _player.disableGestureTypes = ZFPlayerDisableGestureTypesDoubleTap | ZFPlayerDisableGestureTypesPan | ZFPlayerDisableGestureTypesPinch;
        
        __weak typeof(self) weakself = self;
        _player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            __strong typeof(weakself) strongself = weakself;
            [strongself.player.currentPlayerManager replay];
        };
        
        
        
    }
    return _player;
}
- (TTXiaoShiPinControlView *)controlView {
    if (!_controlView) {
        TTXiaoShiPinControlView *controlView = [TTXiaoShiPinControlView new];
        
        _controlView = controlView;
    }
    return _controlView;
}
@end
