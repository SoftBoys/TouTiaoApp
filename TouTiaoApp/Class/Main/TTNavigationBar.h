//
//  TTNavigationBar.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTNavigationBar;
@protocol TTNavigationBarDataSource <NSObject>

@optional
- (BOOL)navigationBarNeedsBottomLine:(TTNavigationBar *)navigationBar;
- (UIColor *)navigationBarBottomColor:(TTNavigationBar *)navigationBar;
- (BOOL)navigationBarNeedsGradient:(TTNavigationBar *)navigationBar;
- (NSAttributedString *)navigationBarTitle:(TTNavigationBar *)navigationBar;

- (UIView *)navigationBarLeftView:(TTNavigationBar *)navigationBar;
- (UIView *)navigationBarRightView:(TTNavigationBar *)navigationBar;
- (UIView *)navigationBarTitleView:(TTNavigationBar *)navigationBar;

- (UIImage *)navigationBarLeftImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar;
- (UIImage *)navigationBarRightImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar;

@end

@protocol TTNavigationBarDelegate <NSObject>
@optional
- (void)leftButtonEvent:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar;
- (void)rightButtonEvent:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar;
//- (void)leftButtonEvent:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar;
@end

@interface TTNavigationBar : UIView <TTNavigationBarDataSource, TTNavigationBarDelegate>
@property (nonatomic, weak) id<TTNavigationBarDelegate> delegate;
@property (nonatomic, weak) id<TTNavigationBarDataSource> dataSource;

- (void)updateNavigationBar;

@end
