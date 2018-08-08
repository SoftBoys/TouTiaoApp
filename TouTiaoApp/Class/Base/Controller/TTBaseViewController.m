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
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.view bringSubviewToFront:self.navigationBar];
}
#pragma mark - TTNavigationBarDataSource
- (BOOL)navigationBarNeedsBottomLine:(TTNavigationBar *)navigationBar; {
    return YES;
}
- (UIColor *)navigationBarBottomColor:(TTNavigationBar *)navigationBar {
    return [UIColor lightGrayColor];
}
- (BOOL)navigationBarNeedsGradient:(TTNavigationBar *)navigationBar {
    return NO;
}
- (NSAttributedString *)navigationBarTitle:(TTNavigationBar *)navigationBar {
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
