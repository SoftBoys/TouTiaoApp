//
//  TTNavigationBar.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTNavigationBar.h"

@interface TTNavigationBar ()
@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) CALayer *bottomLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;

@property (nonatomic, strong) UIButton *defaultLeftButton;
@property (nonatomic, strong) UIButton *defaultRightButton;
@property (nonatomic, strong) UILabel *defaultLabTitle;
@end
@implementation TTNavigationBar
- (instancetype)init {
    if (self = [super init]) {
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    // 左侧view
    CGRect leftFrame = self.leftView.bounds;
    leftFrame.origin = CGPointMake(0, kStatusBarHeight);
    self.leftView.frame = leftFrame;
    // 右侧view
    CGRect rightFrame = self.rightView.bounds;
    rightFrame.origin = CGPointMake(kScreenWidth-rightFrame.size.width, kStatusBarHeight);
    self.rightView.frame = rightFrame;
    
    // titleView
    CGFloat marginX = MAX(CGRectGetWidth(self.leftView.frame), CGRectGetWidth(self.rightView.frame));
    CGFloat titleW = MIN(CGRectGetWidth(self.titleView.frame), (kScreenWidth-marginX*2));
    CGFloat titleX = (kScreenWidth-titleW)/2.0;
    CGFloat titleH = CGRectGetHeight(self.titleView.frame);
    CGFloat titleY = kStatusBarHeight + (kNavigationHeight - titleH)*0.5;
    if (titleH <= 0) {
        titleH = kNavigationHeight;
        titleY = kStatusBarHeight;
    }
    
    self.titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // bottomLayer
    CGFloat bottomH = 1.0/[UIScreen mainScreen].scale;
    self.bottomLayer.frame = CGRectMake(0, CGRectGetMaxY(self.bounds), kScreenWidth, bottomH);
    
    CGFloat gradientH = 10;
    self.gradientLayer.frame = CGRectMake(0, CGRectGetMaxY(self.bounds), kScreenWidth, gradientH);
    
    
}
- (void)setDataSource:(id<TTNavigationBarDataSource>)dataSource {
    _dataSource = dataSource;
    [self setupDataSourceUI];
}

- (void)updateNavigationBar {
    [self setupDataSourceUI];
}

- (void)setupDataSourceUI {
    // 分割线
    if ([self.dataSource respondsToSelector:@selector(navigationBarNeedsBottomLine:)]) {
        self.bottomLayer.hidden = ![self.dataSource navigationBarNeedsBottomLine:self];
    } else {
        self.bottomLayer.hidden = NO;
    }
    // 分割线颜色
    if ([self.dataSource respondsToSelector:@selector(navigationBarBottomColor:)]) {
        self.bottomLayer.backgroundColor = [self.dataSource navigationBarBottomColor:self].CGColor;
    }
    // leftView
    if ([self.dataSource respondsToSelector:@selector(navigationBarLeftView:)]) {
        self.leftView = [self.dataSource navigationBarLeftView:self];
    } else if ([self.dataSource respondsToSelector:@selector(navigationBarLeftImage:navigationBar:)]) {
        UIButton *button = self.defaultLeftButton;
        UIImage *image = [self.dataSource navigationBarLeftImage:button navigationBar:self];
        if (image) {
            [button setImage:image forState:UIControlStateNormal];
        }
        self.leftView = button;
    }
    // rightView
    if ([self.dataSource respondsToSelector:@selector(navigationBarRightView:)]) {
        self.rightView = [self.dataSource navigationBarRightView:self];
    } else if ([self.dataSource respondsToSelector:@selector(navigationBarRightImage:navigationBar:)]) {
        UIButton *button = self.defaultRightButton;
        UIImage *image = [self.dataSource navigationBarRightImage:button navigationBar:self];
        if (image) {
            [button setImage:image forState:UIControlStateNormal];
        }
        self.rightView = button;
    }
    // titleView
    if ([self.dataSource respondsToSelector:@selector(navigationBarTitleView:)]) {
        self.titleView = [self.dataSource navigationBarTitleView:self];
    } else if ([self.dataSource respondsToSelector:@selector(navigationBarTitle:)]) {
        NSAttributedString *title = [self.dataSource navigationBarTitle:self];
        
        UILabel *label = self.defaultLabTitle;
        label.attributedText = title;
        [label sizeToFit];
        self.titleView = label;
    }
    
    // 渐变
    if ([self.dataSource respondsToSelector:@selector(navigationBarNeedsGradient:)]) {
        self.gradientLayer.hidden = ![self.dataSource navigationBarNeedsGradient:self];
    } else {
        self.gradientLayer.hidden = YES;
    }
    
    
    [self layoutIfNeeded];
}
- (void)setTitleView:(UIView *)titleView {
    
    if (_titleView == titleView) {
        return;
    }

    [_titleView removeFromSuperview];
    [self addSubview:titleView];
    _titleView = titleView;
    
    
    
}
- (void)setLeftView:(UIView *)leftView {
    if (_leftView == leftView) {
        return;
    }
    [_leftView removeFromSuperview];
    [self addSubview:leftView];
    _leftView = leftView;
    
    if ([_leftView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)_leftView;
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}
- (void)setRightView:(UIView *)rightView {
    if (_rightView == rightView) {
        return;
    }
    [_rightView removeFromSuperview];
    [self addSubview:rightView];
    _rightView = rightView;
    if ([_rightView isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)_rightView;
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}
- (void)leftButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(leftButtonEvent:navigationBar:)]) {
        [self.delegate leftButtonEvent:button navigationBar:self];
    }
}
- (void)rightButtonClick:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(rightButtonEvent:navigationBar:)]) {
        [self.delegate rightButtonEvent:button navigationBar:self];
    }
}
#pragma mark -
- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        CALayer *layer = [CALayer layer];
        [self.layer addSublayer:layer];
        _bottomLayer = layer;
    }
    return _bottomLayer;
}
- (CAGradientLayer *)gradientLayer {
    if (!_gradientLayer) {
        UIColor *color1 = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        UIColor *color2 = [[UIColor lightGrayColor] colorWithAlphaComponent:0.0];
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)color1.CGColor, (__bridge id)color2.CGColor];
        gradientLayer.locations = @[@0, @1];
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        
        [self.layer addSublayer:gradientLayer];
        
        _gradientLayer = gradientLayer;
    }
    return _gradientLayer;
}

- (UIButton *)defaultLeftButton {
    if (!_defaultLeftButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        
        _defaultLeftButton = button;
    }
    return _defaultLeftButton;
}
- (UIButton *)defaultRightButton {
    if (!_defaultRightButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 44, 44);
        
        _defaultRightButton = button;
    }
    return _defaultRightButton;
}
- (UILabel *)defaultLabTitle {
    if (!_defaultLabTitle) {
        _defaultLabTitle = [[UILabel alloc] init];
    }
    return _defaultLabTitle;
}
@end
