//
//  TTHomeViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeViewController.h"
#import "TTScrollPageView.h"
#import "TTURLManager.h"
#import "TTHomeTitlesRequest.h"
#import "TTHomeTitleModel.h"

#import "TTHomeDetailViewController.h"

@interface TTHomeViewController () <ZJScrollPageViewDelegate>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) TTScrollPageView *pageView;
@end

@implementation TTHomeViewController
- (NSString *)titleURLString {
    return TTURLManager.homeTitleURLString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [UIColor colorWithRed:0.97 green:0.35f blue:0.35f alpha:1.00f];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    [self loadData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}


- (void)loadData {
    NSString *urlString = [self titleURLString];
    if (urlString == nil) {
        return;
    }
    [TTRequestManager cancelURLString:urlString];
    TTHomeTitlesRequest *request = [TTHomeTitlesRequest new];
    request.urlString = urlString;
    [request sendRequestWithCompletion:^(id responseJSON, NSError *error) {
        if (responseJSON) {
            NSDictionary *data = responseJSON[@"data"];
            NSArray *titleArray = nil;
            if ([data isKindOfClass:[NSDictionary class]]) { // 首页
                titleArray = [[TTHomeTitleModel mj_objectArrayWithKeyValuesArray:data[@"data"]] copy];
            } else if ([data isKindOfClass:[NSArray class]]) { // 西瓜
                NSMutableArray *titleList = [TTHomeTitleModel mj_objectArrayWithKeyValuesArray:data];
                TTHomeTitleModel *model = [TTHomeTitleModel new];
                model.category = @"video";
                model.name = @"推荐";
                [titleList insertObject:model atIndex:1];
                titleArray = [titleList copy];
            }
            
            self.titleArray = titleArray;
            
            NSMutableArray *titles = @[].mutableCopy;
//            NSLog(@"------begin-------");
            for (TTHomeTitleModel *model in self.titleArray) {
                TTHomeDetailViewController *detailVC = [TTHomeDetailViewController new];
                [self addChildViewController:detailVC];
//                NSLog(@"category:%@ name:%@", model.category, model.name);
                [titles addObject:model.name];
            }
//            NSLog(@"------end-------");
            [self.pageView reloadWithNewTitles:titles];
            if (titles.count > 1) {
                [self.pageView setSelectedIndex:1 animated:NO];
            }
            
        }
    }];
}
#pragma mark - 
- (BOOL)navigationBarNeedsBottomLine:(TTNavigationBar *)navigationBar {
    return NO;
}
- (UIImage *)navigationBarLeftImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
    return nil;
}
- (UIImage *)navigationBarRightImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
    return nil;
}

- (UIView *)navigationBarTitleView:(TTNavigationBar *)navigationBar {
    return nil;
}
#pragma mark - ZJScrollPageViewDelegate
- (NSInteger)numberOfChildViewControllers {
    return [self.titleArray count];
}
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    
    TTHomeDetailViewController *detailVC = self.childViewControllers[index];
    detailVC.titleModel = self.titleArray[index];
    return detailVC;
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods {
    return NO;
}
- (BOOL)shouldAutorotate {
    return NO;
}
#pragma mark -
- (TTScrollPageView *)pageView {
    if (!_pageView) {
        CGFloat pageY = CGRectGetHeight(self.navigationBar.bounds);
        CGFloat pageH = CGRectGetHeight(self.view.bounds) - pageY;
        CGRect pageFrame = CGRectMake(0, pageY, kScreenWidth, pageH);
        _pageView = [[TTScrollPageView alloc] initWithFrame:pageFrame segmentStyle:nil titles:nil parentViewController:self delegate:self];
        [self.view addSubview:_pageView];
    }
    return _pageView;
}

@end
