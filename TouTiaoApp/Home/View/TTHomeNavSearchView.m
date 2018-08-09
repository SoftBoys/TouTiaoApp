//
//  TTHomeNavSearchView.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeNavSearchView.h"

@interface TTHomeNavSearchView ()
@property (nonatomic, weak) UIImageView *iconView;
@property (nonatomic, weak) UILabel *labsearch;
@end
@implementation TTHomeNavSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        
        CGFloat iconW = 14;
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
            make.width.height.mas_equalTo(iconW);
        }];
        
        [self.labsearch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).offset(6);
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-5);
        }];
//        self.labsearch.backgroundColor = [UIColor tt_navRedColor];
        
    }
    return self;
}
- (void)setKeywords:(NSString *)keywords {
    _keywords = keywords;
    self.labsearch.text = _keywords;
}
#pragma mark -
- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *iconView = [UIImageView new];
        iconView.image = [UIImage imageNamed:@"search_small_14x14_"];
        [self addSubview:iconView];
        _iconView = iconView;
    }
    return _iconView;
}
- (UILabel *)labsearch {
    if (!_labsearch) {
        UILabel *label = [UILabel new];
        label.textColor = [UIColor tt_colorWithHexString:@"#000000"];
        label.font = [UIFont tt_fontOfSize:14];
        [self addSubview:label];
        _labsearch = label;
    }
    return _labsearch;
}

@end



@implementation TTHomeNavItemButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont tt_boldFontOfSize:9];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        
    }
    return self;
}
- (void)setHighlighted:(BOOL)highlighted {}
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect imageFrame = CGRectMake(0, 0, 0, 0);
    if (self.currentImage) {
        imageFrame.size = self.currentImage.size;
        CGFloat imageX = (CGRectGetWidth(self.bounds) - self.currentImage.size.width)/2;
        CGFloat imageY = CGRectGetHeight(self.bounds)/2 - self.currentImage.size.height/2 - 6;
        imageFrame.origin = CGPointMake(imageX, imageY);
    }
    return imageFrame;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect imageFrame = [self imageRectForContentRect:CGRectZero];
    CGFloat titleY = CGRectGetMaxY(imageFrame);
    CGRect titleFrame = CGRectMake(0, titleY, CGRectGetWidth(self.bounds), 10);
    return titleFrame;
}
@end
