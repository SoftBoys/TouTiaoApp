//
//  TTXiaoShiPinDetailCell.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/10.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinDetailCell.h"
#import "TTXiaoShiPinListModel.h"

#import "TTURLHandleManager.h"

typedef NS_ENUM(NSInteger, TTXiaoShiPinMaskType) {
    TTXiaoShiPinMaskTop,
    TTXiaoShiPinMaskBottom
};

@interface TTXiaoShiPinMaskView : UIView
@property (nonatomic, assign) TTXiaoShiPinMaskType type;
@end

@implementation TTXiaoShiPinMaskView

+ (Class)layerClass {
    return [CAGradientLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.type = TTXiaoShiPinMaskTop;
    }
    return self;
}
- (void)setType:(TTXiaoShiPinMaskType)type {
    _type = type;
    
    NSArray *colors = @[(id)[UIColor.blackColor colorWithAlphaComponent:0.4].CGColor,(id)[UIColor.blackColor colorWithAlphaComponent:0.0].CGColor];
    if (_type == TTXiaoShiPinMaskBottom) {
        colors = @[(id)[UIColor.blackColor colorWithAlphaComponent:0.0].CGColor,(id)[UIColor.blackColor colorWithAlphaComponent:0.6].CGColor];
    }
    CAGradientLayer *layer = (CAGradientLayer*)self.layer;
    layer.colors = colors;
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(0, 1);
    
}

@end


@interface TTXiaoShiPinDetailCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *playFatherView;
@property (nonatomic, strong) TTXiaoShiPinMaskView *topMaskView;
@property (nonatomic, strong) TTXiaoShiPinMaskView *bottomMaskView;
@property (nonatomic, strong) UIImageView *userView;
@property (nonatomic, strong) UILabel *labuser;
@property (nonatomic, strong) UILabel *labdesc;

@end
@implementation TTXiaoShiPinDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.playFatherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
        [self.topMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(kTopBarHeight);
        }];
        [self.bottomMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(0);
            make.height.mas_equalTo(120);
        }];
        
        CGFloat userW = 40;
        [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.bottom.mas_equalTo(-20);
            make.width.height.mas_equalTo(userW);
        }];
        self.userView.layer.masksToBounds = YES;
        self.userView.layer.cornerRadius = userW/2.0;
        self.userView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.userView.layer.borderWidth = 1;
        
        [self.labuser mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userView.mas_right).offset(8);
            make.centerY.mas_equalTo(self.userView);
        }];
        [self.labdesc mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userView.mas_left);
            make.bottom.mas_equalTo(self.userView.mas_top).offset(-10);
            make.right.mas_equalTo(-20);
        }];
    }
    return self;
}

- (void)setModel:(TTXiaoShiPinListModel *)model {
    _model = model;
    if (_model) {
        NSString *url = [_model.model.first_frame_image_list firstObject].url;
        [self.imageView tt_setImageWithURLString:url];
        
        [self.userView tt_setImageWithURLString:model.model.info.avatar_url];
        self.labuser.text = model.model.info.name;
        self.labdesc.text = model.model.title;
    }
}

#pragma mark -
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor tt_placeholderImageColor];
        [self.playFatherView addSubview:_imageView];
    }
    return _imageView;
}
- (UIView *)playFatherView {
    if (!_playFatherView) {
        _playFatherView = [UIView new];
        _playFatherView.tag = kXiaoShiPinContainerViewTag;
        [self.contentView addSubview:_playFatherView];
    }
    return _playFatherView;
}

- (TTXiaoShiPinMaskView *)topMaskView {
    if (!_topMaskView) {
        TTXiaoShiPinMaskView *maskView = [TTXiaoShiPinMaskView new];
        [self.contentView addSubview:maskView];
        _topMaskView = maskView;
        
        // close 按钮
        UIButton *button_close = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image_close = [UIImage imageNamed:@"ad_canvas_close_24x24_"];
        [button_close setImage:image_close forState:UIControlStateNormal];
        [button_close addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [maskView addSubview:button_close];
        [button_close mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(0);
            make.width.height.mas_equalTo(kNavigationHeight);
        }];
        
        // 更多按钮
        UIButton *button_more = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image_more = [UIImage imageNamed:@"ad_canvas_more_24x24_"];
        [button_more setImage:image_more forState:UIControlStateNormal];
        [button_more addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [maskView addSubview:button_more];
        [button_more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(0);
            make.width.height.mas_equalTo(kNavigationHeight);
        }];
        
        
    }
    return _topMaskView;
}
- (TTXiaoShiPinMaskView *)bottomMaskView {
    if (!_bottomMaskView) {
        _bottomMaskView = [TTXiaoShiPinMaskView new];
        _bottomMaskView.type = TTXiaoShiPinMaskBottom;
        [self.contentView addSubview:_bottomMaskView];
    }
    return _bottomMaskView;
}
- (UIImageView *)userView {
    if (!_userView) {
        _userView = [UIImageView new];
        _userView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIcon)];
        [_userView addGestureRecognizer:tap];
        [self.bottomMaskView addSubview:_userView];
    }
    return _userView;
}
- (UILabel *)labuser {
    if (!_labuser) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont tt_boldFontOfSize:16];
        [self.bottomMaskView addSubview:label];
        _labuser = label;
    }
    return _labuser;
}
- (UILabel *)labdesc {
    if (!_labdesc) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont tt_fontOfSize:14];
        label.numberOfLines = 0;
        [self.bottomMaskView addSubview:label];
        _labdesc = label;
    }
    return _labdesc;
}
#pragma mark -
- (void)closeBtnClick {
    if ([_delegate respondsToSelector:@selector(closeXiaoShiPinCell:)]) {
        [_delegate closeXiaoShiPinCell:self];
    }
}
- (void)moreBtnClick {
    
}
- (void)tapIcon {
    NSString *user_id = self.model.model.info.user_id;
    NSString *URL = kUserHomePageURL(user_id);
    [TTURLHandleManager parseAppURL:[NSURL URLWithString:URL]];
}
@end
