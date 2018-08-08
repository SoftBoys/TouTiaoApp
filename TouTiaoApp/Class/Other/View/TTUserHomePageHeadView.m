//
//  TTUserHomePageHeadView.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/1.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTUserHomePageHeadView.h"
#import "TTUserHomePageModel.h"

@interface TTUserHomePageHeadView ()
@property (nonatomic, strong) TTUserHomePageStrenchView *strenchView;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation TTUserHomePageHeadView

- (void)setModel:(TTUserHomePageModel *)model {
    _model = model;
    if (_model) {
        [self.strenchView tt_setImageWithURLString:model.bg_img_url];
        [self.iconView tt_setImageWithURLString:model.avatar_url];
        
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.strenchView scrollViewDidScroll:scrollView];
}

#pragma mark -
- (TTUserHomePageStrenchView *)strenchView {
    if (!_strenchView) {
        _strenchView = [TTUserHomePageStrenchView new];
        [self addSubview:_strenchView];
        [_strenchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_equalTo(0);
            make.height.mas_equalTo(130);
        }];
    }
    return _strenchView;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [UIImageView new];
        [self addSubview:_iconView];
        CGFloat iconW = 70;
        [_iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.strenchView.mas_bottom);
            make.width.height.mas_equalTo(iconW);
        }];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = iconW/2.0;
    }
    return _iconView;
}
@end

@interface TTUserHomePageStrenchView ()
@property (nonatomic, strong) UIImageView *backView;
@end
@implementation TTUserHomePageStrenchView



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentInset.top + scrollView.contentOffset.y;
    
    if (offsetY <= 0) {
        
        CGFloat scale = 1 + (-offsetY/self.bounds.size.height);
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0, offsetY/2);

        self.transform = CGAffineTransformScale(transform, scale, scale);
    } else {
        self.transform = CGAffineTransformIdentity;
    }
    
    
}

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [UIImageView new];
        _backView.backgroundColor = [UIColor greenColor];
        [self addSubview:_backView];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left
        }];
    }
    return _backView;
}
@end
