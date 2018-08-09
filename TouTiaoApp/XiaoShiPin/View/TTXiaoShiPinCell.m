//
//  TTXiaoShiPinTableViewCell.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinCell.h"

#import "TTXiaoShiPinListModel.h"
#import "TTNumberFormatter.h"



@interface TTXiaoShiPinCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CAGradientLayer *maskLayer;
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UIImageView *playView;
@property (nonatomic, strong) UILabel *labplay_count;
@property (nonatomic, strong) UILabel *lablike_count;
@end

@implementation TTXiaoShiPinCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor tt_navRedColor];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];

        CGFloat playH = 16;
        [self.playView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(-8);
            make.width.height.mas_equalTo(playH);
        }];

        [self.labplay_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.playView.mas_right).offset(5);
            make.centerY.mas_equalTo(self.playView);
//            make.height.mas_equalTo(playH);
        }];
        [self.lablike_count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(self.playView);
        }];

        [self.labtitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.mas_equalTo(self.playView.mas_top).offset(-8);
            make.right.mas_equalTo(-10);
        }];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.maskLayer.frame = self.bounds;
}
- (void)setModel:(TTXiaoShiPinListModel *)model {
    _model = model;
    if (_model) {
        NSString *urlString = [_model.model.first_frame_image_list firstObject].url;
        [self.imageView tt_setImageWithURLString:urlString];
        
        
        NSString *play_count = [NSString stringWithFormat:@"%@次播放",[TTNumberFormatter formatterStringWithInteger:_model.model.action.play_count]];
        self.labplay_count.text = play_count;
        
        
        NSString *like_count = [NSString stringWithFormat:@"%@%@",[TTNumberFormatter formatterStringWithInteger:_model.model.action.digg_count], @"次播放"];
        self.lablike_count.text = like_count;
        
        self.labtitle.attributedText = [_model.model.title tt_attributeStringWithFont:[UIFont tt_boldFontOfSize:17] lineSpace:5];
        
    }
}
#pragma mark -
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.backgroundColor = [UIColor tt_placeholderImageColor];
        [self.contentView addSubview:_imageView];
        
        UIColor *color1 = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        UIColor *color2 = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        UIColor *color3 = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.colors = @[(id)color1.CGColor, (id)color2.CGColor, (id)color3.CGColor];
        layer.locations = @[@0, @0.65, @1];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
        [_imageView.layer addSublayer:layer];
        _maskLayer = layer;
        
    }
    return _imageView;
}
- (UILabel *)labtitle {
    if (!_labtitle) {
        _labtitle = [UILabel new];
        _labtitle.numberOfLines = 2;
        _labtitle.lineBreakMode = NSLineBreakByTruncatingTail;
        _labtitle.textColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_labtitle];
        
    }
    return _labtitle;
}
- (UILabel *)lablike_count {
    if (!_lablike_count) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont tt_fontOfSize:13];
        [self.contentView addSubview:label];
        _lablike_count = label;
    }
    return _lablike_count;
}

- (UIImageView *)playView {
    if (!_playView) {
        _playView = [UIImageView new];
        _playView.image = [[UIImage imageNamed:@"audio_play_detail_24x24_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.contentView addSubview:_playView];
    }
    return _playView;
}
- (UILabel *)labplay_count {
    if (!_labplay_count) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont tt_fontOfSize:13];
        [self.contentView addSubview:label];
        _labplay_count = label;
    }
    return _labplay_count;
}

@end
