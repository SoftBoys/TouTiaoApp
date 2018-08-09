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

#import "TTHomeNavSearchView.h"

#import "TTHomeDetailViewController.h"
#import "TTXiaoShiPinViewController.h"

@interface TTHomeViewController () <ZJScrollPageViewDelegate>
@property (nonatomic, strong) TTHomeNavSearchView *searchView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) TTScrollPageView *pageView;
@end

@implementation TTHomeViewController
- (NSString *)titleURLString {
    return TTURLManager.homeTitleURLString;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [UIColor tt_navRedColor];
    
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
                if ([model.category isEqualToString:@"hotsoon_video"]) {
                    TTXiaoShiPinViewController *shipinVC = [TTXiaoShiPinViewController new];
                    shipinVC.is_subVC = YES;
                    [self addChildViewController:shipinVC];
                    [titles addObject:model.name];
                } else {
                    TTHomeDetailViewController *detailVC = [TTHomeDetailViewController new];
                    [self addChildViewController:detailVC];
                    [titles addObject:model.name];
                }
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
- (UIView *)navigationBarLeftView:(TTNavigationBar *)navigationBar {
    
    UIImage *image = [[UIImage imageNamed:@"user_24x24_"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    TTHomeNavItemButton *button = [TTHomeNavItemButton buttonWithType:UIButtonTypeCustom];
    button.tintColor = [UIColor whiteColor];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:@"未登录" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    return button;
}
- (UIView *)navigationBarRightView:(TTNavigationBar *)navigationBar {
    UIImage *image = [[UIImage imageNamed:@"short_video_publish_icon_camera_24x24_"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    TTHomeNavItemButton *button = [TTHomeNavItemButton buttonWithType:UIButtonTypeCustom];
    button.tintColor = [UIColor whiteColor];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 44, 44);
    return button;
}
//- (UIImage *)navigationBarLeftImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
//    button.tintColor = [UIColor whiteColor];
//    return [[UIImage imageNamed:@"user_24x24_"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//}
//- (UIImage *)navigationBarRightImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
//    button.tintColor = [UIColor whiteColor];
//    return [[UIImage imageNamed:@"short_video_publish_icon_camera_24x24_"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//}

- (UIView *)navigationBarTitleView:(TTNavigationBar *)navigationBar {
    self.searchView.keywords = @"温室效应";
    return self.searchView;
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
- (TTHomeNavSearchView *)searchView {
    if (!_searchView) {
        TTHomeNavSearchView *searchView = [TTHomeNavSearchView new];
        searchView.frame = CGRectMake(0, 0, kScreenWidth-88, 30);
        _searchView = searchView;
    }
    return _searchView;
}
@end
