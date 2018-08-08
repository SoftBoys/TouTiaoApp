//
//  TTTabBarController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTTabBarController.h"
#import "TTNavigationController.h"
#import "TTHomeViewController.h"
#import "TTXiGuaViewController.h"
#import "TTZhaoRenViewController.h"
#import "TTXiaoShiPinViewController.h"

@interface TTTabBarController ()

@end

@implementation TTTabBarController

+ (void)initialize {
    UITabBar *tabbar = [UITabBar appearance];
    
    [tabbar setTranslucent:NO];
    tabbar.barTintColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.00f];
    tabbar.barTintColor = [UIColor whiteColor];
    
    UITabBarItem * item = [UITabBarItem appearance];
    
    item.titlePositionAdjustment = UIOffsetMake(0, -5);
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.31f green:0.31f blue:0.31f alpha:1.00f];;
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    selectAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.97 green:0.35f blue:0.35f alpha:1.00f];
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addChildVC:[TTHomeViewController new] title:@"首页" norImageName:@"home_tabbar_32x32_" selImageName:@"home_tabbar_press_32x32_"];
    [self addChildVC:[TTXiGuaViewController new] title:@"西瓜视频" norImageName:@"video_tabbar_32x32_" selImageName:@"video_tabbar_press_32x32_"];
    [self addChildVC:[TTZhaoRenViewController new] title:@"找人" norImageName:@"addfriend_tabbar_32x32_" selImageName:@"addfriend_tabbar_press_32x32_"];
    [self addChildVC:[TTXiaoShiPinViewController new] title:@"小视频" norImageName:@"huoshan_tabbar_32x32_" selImageName:@"huoshan_tabbar_press_32x32_"];
    
    
}

- (TTNavigationController *)addChildVC:(UIViewController *)viewController title:(NSString *)title norImageName:(NSString *)norImageName selImageName:(NSString *)selImageName {
    
    
    TTNavigationController *nav = [[TTNavigationController alloc] initWithRootViewController:viewController];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [[UIImage imageNamed:norImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self addChildViewController:nav];
    return nav;
}

@end
