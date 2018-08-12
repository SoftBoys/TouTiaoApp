//
//  TTXiaoShiPinControlView.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/11.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinControlView.h"
#import <ZFPlayer/ZFSpeedLoadingView.h>
#import <ZFPlayer/UIImageView+ZFCache.h>
#import <ZFPlayer/ZFSliderView.h>

@interface TTXiaoShiPinControlView ()
@property (nonatomic, strong) UIImageView *coverView; // 封面
@property (nonatomic, strong) ZFSpeedLoadingView *activity; // 加载loading
@property (nonatomic, strong) ZFSliderView *sliderView;
@end
@implementation TTXiaoShiPinControlView
@synthesize player = _player;

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.width.height.mas_equalTo(80);
        }];
        
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
        }];
        
//        self.activity.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)resetControlView {
    self.sliderView.value = 0;
    self.sliderView.bufferValue = 0;
}
- (void)setCoverImageWithURLString:(NSString *)URLString {
    [self.coverView setImageWithURLString:URLString placeholder:nil];
}

- (void)setPlayer:(ZFPlayerController *)player {
    _player = player;
    [player.currentPlayerManager.view insertSubview:self.coverView atIndex:0];
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}
- (void)videoPlayer:(ZFPlayerController *)videoPlayer loadStateChanged:(ZFPlayerLoadState)state {
    if (state == ZFPlayerLoadStatePrepare) {
        self.coverView.hidden = NO;
    } else if (state == ZFPlayerLoadStatePlaythroughOK) {
        self.coverView.hidden = YES;
    }
    
    if (state == ZFPlayerLoadStateStalled || state == ZFPlayerLoadStatePrepare) {
        [self.activity startAnimating];
    } else {
        [self.activity stopAnimating];
    }
}
- (void)videoPlayer:(ZFPlayerController *)videoPlayer prepareToPlay:(NSURL *)assetURL {
    
}
// 缓冲进度
- (void)videoPlayer:(ZFPlayerController *)videoPlayer bufferTime:(NSTimeInterval)bufferTime {
    self.sliderView.bufferValue = videoPlayer.bufferProgress;
}
// 当前播放进度
- (void)videoPlayer:(ZFPlayerController *)videoPlayer currentTime:(NSTimeInterval)currentTime totalTime:(NSTimeInterval)totalTime {
    self.sliderView.value = videoPlayer.progress;
}

#pragma mark -
-(UIImageView *)coverView {
    if (!_coverView) {
        _coverView = [UIImageView new];
        _coverView.backgroundColor = [UIColor tt_placeholderImageColor];
    }
    return _coverView;
}
- (ZFSpeedLoadingView *)activity {
    if (!_activity) {
        _activity = [ZFSpeedLoadingView new];
        [self addSubview:_activity];
    }
    return _activity;
}
- (ZFSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [ZFSliderView new];
        _sliderView.maximumTrackTintColor = [UIColor clearColor];
        _sliderView.minimumTrackTintColor = [UIColor whiteColor];
        _sliderView.bufferTrackTintColor  = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        _sliderView.sliderHeight = 1;
        _sliderView.isHideSliderBlock = NO;
        [self addSubview:_sliderView];
    }
    return _sliderView;
}

@end
