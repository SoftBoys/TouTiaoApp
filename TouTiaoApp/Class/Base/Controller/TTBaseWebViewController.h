//
//  TTBaseWebViewController.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseViewController.h"
#import <WebKit/WebKit.h>

@class TTBaseWebViewController;
@protocol TTBaseWebViewControllerDelegate <NSObject>
@optional
- (void)closeBtnClick:(UIButton *)button webViewController:(TTBaseViewController *)viewController;
- (void)backBtnClick:(UIButton *)button webViewController:(TTBaseViewController *)viewController;
@end
@protocol TTBaseWebViewControllerDataSource <NSObject>
@optional
- (BOOL)webViewControllerIsNeedProgerss:(TTBaseViewController *)viewController;
- (UIColor *)webViewControllerProgressColor:(TTBaseViewController *)viewController;

@end


@interface TTBaseWebViewController : TTBaseViewController <TTBaseWebViewControllerDelegate, TTBaseWebViewControllerDataSource>
@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, copy) NSString *gotoURL;
@end
