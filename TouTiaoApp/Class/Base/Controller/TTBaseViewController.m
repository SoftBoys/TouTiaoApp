//
//  TTBaseViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTBaseViewController () 

@end

@implementation TTBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.navigationBar];
//    CGRect navFrame = self.navigationBar.frame;
//    navFrame.size.height = kTopBarHeight;
////    CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
//    self.navigationBar.frame = navFrame;
}
#pragma mark - TTNavigationBarDataSource
- (BOOL)navigationBarNeedsBottomLine:(TTNavigationBar *)navigationBar; {
    return YES;
}
- (UIColor *)navigationBarBottomColor:(TTNavigationBar *)navigationBar {
    return [UIColor tt_navLineColor];
}
- (BOOL)navigationBarNeedsGradient:(TTNavigationBar *)navigationBar {
    return NO;
}
- (NSAttributedString *)navigationBarTitle:(TTNavigationBar *)navigationBar {
    NSString *title = self.navigationItem.title ?: self.title;
    return [title tt_attributeStringWithFont:[UIFont tt_boldFontOfSize:17] lineSpace:0];
    return nil;
}
- (UIImage *)navigationBarLeftImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
    UIImage *image = self.navigationController.viewControllers.count > 1 ? [UIImage imageNamed:@"personal_home_back_black_24x24_"]:nil;
    [button setImage:image forState:UIControlStateNormal];
    
    return nil;
}
- (void)leftButtonEvent:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - TTNavigationBarDelegate
#pragma mark -
- (TTNavigationBar *)navigationBar {
    if (!_navigationBar) {
        CGRect navFrame = CGRectMake(0, 0, kScreenWidth, kTopBarHeight);
        TTNavigationBar *navigationBar = [[TTNavigationBar alloc] initWithFrame:navFrame];
        navigationBar.delegate = self;
        navigationBar.dataSource = self;
        navigationBar.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:navigationBar];
        _navigationBar = navigationBar;
    }
    return _navigationBar;
}

@end
