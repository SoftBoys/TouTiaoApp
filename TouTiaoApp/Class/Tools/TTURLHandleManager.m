//
//  TTURLHandleManager.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTURLHandleManager.h"

#import "TTWebViewController.h"
#import "TTUserHomePageViewController.h"

// @"toutiao://detail?"


//#define kUserHomePageURL(user_id) [NSString stringWithFormat:@"%@?user_id=%@", @"toutiao://user_homepage", user_id]

@implementation TTURLHandleManager

+ (void)parseAppURL:(NSURL *)url {
    
    if ([url.scheme hasPrefix:@"http"]) {
        TTWebViewController *webVC = [TTWebViewController new];
        webVC.gotoURL = url.absoluteString;
        [self.topViewController.navigationController pushViewController:webVC animated:YES];
        return;
    }
    
    if ([url.scheme.lowercaseString hasPrefix:@"toutiao"]) {
        
        NSString *clsString = [self getClassStringWithHost:url.host];
        if (clsString) {
            
            NSDictionary *param = [self queryWithQueryString:url.query];
            
            UIViewController *vc = [NSClassFromString(clsString) new];
            if ([vc isKindOfClass:[TTUserHomePageViewController class]]) {
                TTUserHomePageViewController *homePageVC = (TTUserHomePageViewController*)vc;
                homePageVC.user_id = param[@"user_id"];
                [self.topViewController.navigationController pushViewController:homePageVC animated:YES];
                
            }
            
            
        }
        
        
    }
    
}
#pragma mark - host 映射 class
+ (NSString *)getClassStringWithHost:(NSString *)host {
    NSString *clsString = nil;
    if ([host.lowercaseString isEqualToString:@"user_homepage"]) {
        clsString = NSStringFromClass(TTUserHomePageViewController.class);
    }
    
    return clsString;
}
#pragma mark - 解析params
+ (NSDictionary *)queryWithQueryString:(NSString *)queryString {
    if (queryString.length == 0) {
        return nil;
    }
    
    NSMutableDictionary *muQuery = @{}.mutableCopy;
    [[queryString componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString * _Nonnull keyvalueString, NSUInteger idx, BOOL * _Nonnull stop) {
        __block NSString *key = nil;
        __block NSString *value = nil;
        [[keyvalueString componentsSeparatedByString:@"="] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                key = obj;
            } else if (idx == 1) {
                value = obj;
            }
        }];
        
        if (key && value) {
            muQuery[key] = value;
        }
    }];
    return muQuery.copy;
    
}


+ (UIViewController *)topViewController {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;

    UIViewController *rootViewController = window.rootViewController;
    
    UIViewController *resultVC = [self __topViewController:rootViewController];
    while (resultVC.presentedViewController) {
        resultVC = [self __topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
+ (UIViewController *)__topViewController:(UIViewController *)topViewController {
//    UIViewController *topViewController = viewController;
    if ([topViewController isKindOfClass:[UITabBarController class]]) {
        topViewController = [(UITabBarController *)topViewController selectedViewController];
        return [self __topViewController:topViewController];
    }
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        topViewController = [(UINavigationController *)topViewController topViewController];
        return [self __topViewController:topViewController];
    }
    if ([topViewController isKindOfClass:UIViewController.class]) {
        return topViewController;
    }
    return nil;
}
@end
