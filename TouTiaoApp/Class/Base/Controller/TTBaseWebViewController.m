//
//  TTBaseWebViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseWebViewController.h"

@interface TTBaseWebViewController ()
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation TTBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_gotoURL.length) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_gotoURL]];
        [self.webView loadRequest:request];
    }
    
    [self addObserver];
    
//    self.webView.backgroundColor = [UIColor redColor];
//    self.webView.scrollView.backgroundColor = [UIColor orangeColor];
    
}
#pragma mark - TTBaseWebViewControllerDelegate
- (void)backBtnClick:(UIButton *)button webViewController:(TTBaseViewController *)viewController {
    
}
- (void)closeBtnClick:(UIButton *)button webViewController:(TTBaseViewController *)viewController {
    
}
#pragma mark - TTBaseWebViewControllerDataSource
- (UIColor *)webViewControllerProgressColor:(TTBaseViewController *)viewController {
    return kCOLOR_NAV_RED;
}
- (BOOL)webViewControllerIsNeedProgerss:(TTBaseViewController *)viewController {
    return YES;
}

#pragma mark -
- (void)addObserver {
//    [self removeObserver];
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.webView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)removeObserver {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"contentSize"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat progress = [change[NSKeyValueChangeNewKey] floatValue];
        if ([self respondsToSelector:@selector(webViewControllerIsNeedProgerss:)]) {
            self.progressView.hidden = ![self webViewControllerIsNeedProgerss:self];
        }
        self.progressView.progress = progress;
        
        if (progress >= 1.0) {
            [UIView animateWithDuration:0.25 animations:^{
                self.progressView.alpha = 0.0f;
                self.progressView.progress = 0.0f;
            }];
        }
        
        if ([self respondsToSelector:@selector(webViewControllerProgressColor:)]) {
            self.progressView.tintColor = [self webViewControllerProgressColor:self];
        }
        
        
        
    }
}
- (void)dealloc {
    [self removeObserver];
}
#pragma mark -
- (WKWebView *)webView {
    if (!_webView) {
        CGRect webFrame = CGRectMake(0, 0, kScreenWidth, self.view.bounds.size.height);
        WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:[self congiguration]];
//        webView.scrollView.scrollEnabled = NO;
        webView.frame = webFrame;
        webView.frame = self.view.bounds;
        
//        webView.scrollView.backgroundColor = [UIColor redColor];
        webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:webView];
        
        webView.scrollView.contentInset = UIEdgeInsetsMake(kTopBarHeight, 0, 0, 0);
        
        _webView = webView;
    }
    return _webView;
}
- (WKWebViewConfiguration *)congiguration {
    //初始化一个WKWebViewConfiguration对象
    WKWebViewConfiguration *config = [WKWebViewConfiguration new];
    //    初始化偏好设置属性：preferences
    config.preferences = [WKPreferences new];
    //The minimum font size in points default is 0;
    config.preferences.minimumFontSize = 0;
    //是否支持JavaScript
    config.preferences.javaScriptEnabled = YES;
    //不通过用户交互，是否可以打开窗口
    config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    // 检测各种特殊的字符串：比如电话、网站
    config.dataDetectorTypes = UIDataDetectorTypeNone;
    // 播放视频
    config.allowsInlineMediaPlayback = YES;
    
    return config;
}
- (UIProgressView *)progressView {
    if (!_progressView) {
        UIProgressView *progressView = [UIProgressView new];
        progressView.frame = CGRectMake(0, kTopBarHeight, kScreenWidth, 1);
        progressView.transform = CGAffineTransformMakeScale(1.0, 0.5);
        [self.navigationBar addSubview:progressView];
        _progressView = progressView;
    }
    return _progressView;
}
@end
