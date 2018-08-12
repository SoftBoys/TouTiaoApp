//
//  TTHomeDetailViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeDetailViewController.h"

#import "TTHomeTitleModel.h"
#import "TTHomeNewsRequest.h"
#import "TTHomeNewsModel.h"
#import "TTHomeNewsViewModel.h"

#import "TTHomeTableViewCell.h"

#import "TTURLHandleManager.h"
#import "TTXiGuaTableViewCell.h"

#import "TTVideoListModel.h"
#import "TTXiGuaVideoViewModel.h"

#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFAVPlayerManager.h>

@interface TTHomeDetailViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
@end

@implementation TTHomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.hidden = YES;
    
//    self.view.backgroundColor = [UIColor redColor];
//    self.tableView.backgroundColor = [UIColor yellowColor];
    self.tableView.frame = self.view.bounds;
    

}
- (void)viewWillAppear:(BOOL)animated {
    
}

- (NSString *)listURLString {
    return TTURLManager.homeListURLString;
}
- (void)loadIsMore:(BOOL)more {
    
    if (self.titleModel == nil) {
        return;
    }
    NSString *urlString = ([self.titleModel.category isEqualToString:@"video"] || [self.titleModel.category hasPrefix:@"subv_"]) ? TTURLManager.videoListURLString : TTURLManager.homeListURLString;
    
    [TTRequestManager cancelURLString:urlString];
    
    NSString *category = self.titleModel.category;
    urlString = [category isEqualToString:@"video"] ? TTURLManager.videoListURLString:urlString;
    TTHomeNewsRequest *request = [TTHomeNewsRequest new];
    request.urlString = urlString;
    request.category = category;
    request.tt_from = !more ? @"pull":@"load_more";
//    request.refresh_reason = !more ? @(1):nil;
//    request.session_refresh_idx = !more ? @(1):nil;
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
                
                // 小视频
                if ([category isEqualToString:@"hotsoon_video"]) {
                    
                }
                // 视频
                else if ([category isEqualToString:@"video"]||[category hasPrefix:@"subv_"]) {
                    for (NSDictionary *dict in data) {
                        TTVideoListModel *model = [TTVideoListModel mj_objectWithKeyValues:dict];
                        [model videoModel];
                        if (model.videoModel.playInfo.video_list == nil) {
                            continue;
                        }
                        
                        TTXiGuaVideoViewModel *viewModel = [TTXiGuaVideoViewModel new];
                        viewModel.model = model.videoModel;
                        [self.dataArray addObject:viewModel];
                        
                    }
                }
                // 文章
                else {
                    for (NSDictionary *dict in data) {
                        
                        TTHomeNewsListModel *model = [TTHomeNewsListModel mj_objectWithKeyValues:dict];
//                        [model newsModel];
                        if (model.newsModel.title.length == 0) {
                            continue;
                        }
                        
                        TTHomeNewsViewModel *viewModel = [TTHomeNewsViewModel viewModelWithModel:[model newsModel]];
                        [self.dataArray addObject:viewModel];
                    }
                    
                }
                
                
            }
            
            dispatch_main_async_safe(^{
                [self endHeaderFooterRefresh];
                
                [self.tableView reloadData];
            });
        });
        
    }];
}
- (void)playAtCell:(TTXiGuaTableViewCell *)cell indexPath:(NSIndexPath *)indexPath scrollToTop:(BOOL)scrollToTop {
    
    
    TTVideoPlayInfoModel *playModel = cell.viewModel.model.playInfo;
    
    NSString *videoURL = playModel.video_list.video_2.main_url;
    
    NSString *title = cell.viewModel.model.title;
    [self.controlView showTitle:title coverURLString:playModel.poster_url fullScreenMode:ZFFullScreenModeLandscape];
    
    [self.player playTheIndexPath:indexPath assetURL:[NSURL URLWithString:videoURL] scrollToTop:scrollToTop];
    
    self.player.playerPlayStatChanged = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset, ZFPlayerPlaybackState playState) {
        NSLog(@"changed:");
        cell.playState = playState;
    };
    
//    ZFPlayerModel *player = [[ZFPlayerModel alloc] init];
//    player.indexPath = indexPath;
//    player.fatherViewTag = fatherView.tag;
//    player.scrollView = self.tableView;
//    player.indexPath = indexPath;
//    player.title = cell.viewModel.model.title;
//    player.videoURL = [NSURL URLWithString:videoURL];
//    player.placeholderImageURLString = playModel.poster_url;
    
    
    
//    [self.playerView playerControlView:nil playerModel:player];
//    [self.playerView autoPlayTheVideo];
    
}
#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *viewModel = self.dataArray[indexPath.row];
    
    // 视频
    if ([viewModel isKindOfClass:[TTXiGuaVideoViewModel class]]) {
        __weak typeof(self) weakself = self;
        TTXiGuaTableViewCell *cell = [TTXiGuaTableViewCell cellForTableView:tableView];
        cell.viewModel = (TTXiGuaVideoViewModel*)viewModel;
        cell.playBlock = ^(TTXiGuaTableViewCell *cell, UIView *fatherView) {
            __strong typeof(weakself) strongself = weakself;
            [strongself playAtCell:cell indexPath:indexPath scrollToTop:NO];
        };
        return cell;
    }
    
    // 文章
    if ([viewModel isKindOfClass:[TTHomeNewsViewModel class]]) {
        TTHomeTableViewCell *cell = [TTHomeTableViewCell cellForTableView:tableView];
        cell.viewModel = (TTHomeNewsViewModel*)viewModel;
        return cell;
    }
    
    TTHomeTableViewCell *cell = [TTHomeTableViewCell cellForTableView:tableView];
//    cell.viewModel = viewModel;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTHomeNewsViewModel *viewModel = self.dataArray[indexPath.row];
    return [viewModel cellheight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TTHomeNewsViewModel *viewModel = self.dataArray[indexPath.row];
    if ([viewModel isKindOfClass:[TTHomeNewsViewModel class]]) {
        if (viewModel.model.url.length) {
            [TTURLHandleManager parseAppURL:[NSURL URLWithString:viewModel.model.url]];
        }
    }
    
}

#pragma mark -
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}
- (ZFPlayerController *)player {
    if (!_player) {
        ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
        _player = [ZFPlayerController playerWithScrollView:self.tableView playerManager:playerManager containerViewTag:kXiGuaContainerViewTag];
        _player.controlView = self.controlView;
        _player.shouldAutoPlay = NO;
        
        __weak typeof(self) weakself = self;
        _player.playerDidToEnd = ^(id<ZFPlayerMediaPlayback>  _Nonnull asset) {
            __strong typeof(weakself) strongself = weakself;
            // 全屏时 关闭自动播放下
            if (strongself.player.isFullScreen) {
                [strongself.player stopCurrentPlayingCell];
            } else if (strongself.player.playingIndexPath.row < self.dataArray.count-1) {
                // 自动播放
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:strongself.player.playingIndexPath.row+1 inSection:0];
                TTXiGuaTableViewCell *cell = [strongself.tableView cellForRowAtIndexPath:indexPath];
                [strongself playAtCell:cell indexPath:indexPath scrollToTop:YES];
            }
        };
        
    }
    return _player;
}
- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [[ZFPlayerControlView alloc] init];
        
        UILabel *titleLabel = _controlView.portraitControlView.titleLabel;
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
//        UILabel *titleLabel = _controlView.portraitControlView.titleLabel;
    }
    return _controlView;
}
@end
