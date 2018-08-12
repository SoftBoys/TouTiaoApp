//
//  TTXiGuaTableViewCell.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiGuaTableViewCell.h"
#import "TTVideoListModel.h"
#import "TTXiGuaVideoViewModel.h"

#import "TTXiGuaMaskView.h"

#import "TTURLHandleManager.h"

#import <ZFPlayer/ZFPlayer.h>

@interface TTXiGuaTableViewCell ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIImageView *playView;
@property (nonatomic, strong) TTXiGuaMaskView *maskTitleView;
@property (nonatomic, strong) UILabel *labtime;
@property (nonatomic, strong) UIImageView *user_logo;
@property (nonatomic, strong) UILabel *labuser;
@end
@implementation TTXiGuaTableViewCell
- (void)setupUI {
    
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.maskTitleView];
    
    self.backView.tag = kXiGuaContainerViewTag;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.backView addGestureRecognizer:tap];
    
    
    [self.contentView addSubview:self.labuser];
    [self.contentView addSubview:self.user_logo];
    
    [self.labuser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.backView.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    CGFloat userW = 44;
    [self.user_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(userW);
        make.bottom.mas_equalTo(self.labuser.mas_top).offset(8);
    }];
    
    self.user_logo.layer.masksToBounds = YES;
    self.user_logo.layer.cornerRadius = userW/2;
    self.user_logo.layer.borderColor = [UIColor whiteColor].CGColor;
    self.user_logo.layer.borderWidth = 1;
    
    
    self.user_logo.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap_logo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_logoClick)];
    [self.user_logo addGestureRecognizer:tap_logo];
    

    
}
- (void)tapClick {
    
    __weak typeof(self) weakself = self;
    if (self.playBlock) {
        self.playBlock(weakself, weakself.backView);
    }
}
- (void)tap_logoClick {
    NSString *user_id = self.viewModel.model.user_info.user_id;
    if (user_id) {
        [TTURLHandleManager parseAppURL:[NSURL URLWithString:kUserHomePageURL(user_id)]];
    }
}

- (void)setViewModel:(TTXiGuaVideoViewModel *)viewModel {
    _viewModel = viewModel;
    
    if (_viewModel) {
        TTVideoDetailModel *model = viewModel.model;
        self.maskTitleView.frame = CGRectMake(0, 0, kScreenWidth, 100);
        
        self.maskTitleView.title = model.title;
        self.maskTitleView.played_count = model.video_watch_count;
        
        NSString *url = model.playInfo.poster_url;
        [self.backView tt_setImageWithURLString:url];
        self.backView.frame = viewModel.backImageViewFrame;
        
        
        self.labtime.text = viewModel.durationText;
        
        TTVideoUserInfoModel *user = viewModel.model.user_info;
        self.labuser.text = user.name;
        
        [self.user_logo tt_setImageWithURLString:user.avatar_url];
        
    }
    
    
}
- (void)setPlayState:(ZFPlayerPlaybackState)playState {
    _playState = playState;
    if (_playState == ZFPlayerPlayStatePlayStopped) {
        self.user_logo.hidden = NO;
    } else {
        self.user_logo.hidden = YES;
    }
}

#pragma mark -
- (UIImageView *)backView {
    if (!_backView) {
        UIImageView *imageView = [UIImageView new];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        _backView = imageView;
        _backView.userInteractionEnabled = YES;
        
        [_backView addSubview:self.playView];
        [_backView addSubview:self.labtime];
        
        [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.width.height.mas_equalTo(44);
        }];
        
        CGFloat timeW = 60;
        CGFloat timeH = 20;
        [self.labtime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-10);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(timeH);
            make.width.mas_equalTo(timeW);
        }];
        self.labtime.layer.cornerRadius = timeH/2.0;
        self.labtime.layer.masksToBounds = YES;
        
        
        
    }
    return _backView;
}
- (UIImageView *)playView {
    if (!_playView) {
        _playView = [UIImageView new];
        _playView.image = [UIImage imageNamed:@"Play"];
    
    }
    return _playView;
}
- (TTXiGuaMaskView *)maskTitleView {
    if (!_maskTitleView) {
        _maskTitleView = [TTXiGuaMaskView new];
    }
    return _maskTitleView;
}
- (UILabel *)labtime {
    if (!_labtime) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        _labtime = label;
    }
    return _labtime;
}
- (UILabel *)labuser {
    if (!_labuser) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
//        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        label.font = [UIFont boldSystemFontOfSize:15];
//        label.textAlignment = NSTextAlignmentCenter;
        _labuser = label;
    }
    return _labuser;
}
- (UIImageView *)user_logo {
    if (!_user_logo) {
        UIImageView *imageView = [UIImageView new];
        imageView.userInteractionEnabled = YES;
        _user_logo = imageView;
    }
    return _user_logo;
}
@end
