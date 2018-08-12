//
//  TTUserHomePageViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/31.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTUserHomePageViewController.h"
#import "TTUserHomePageRequest.h"
#import "TTURLManager.h"

#import "TTUserHomePageModel.h"

#import <SwipeTableView/SwipeTableView.h>
#import "TTUserHomePageHeadView.h"


@interface TTUserHomePageViewController () <UIScrollViewDelegate, SwipeTableViewDelegate, SwipeTableViewDataSource>
@property (nonatomic, strong) SwipeTableView *swipeTableView;
@property (nonatomic, strong) TTUserHomePageHeadView *headerView;
@property (nonatomic, strong) UIView *sectionView;

@property (nonatomic, strong) UIColor *navBackColor;
@property (nonatomic, strong) UIColor *navBottomColor;
@property (nonatomic, strong) UIImage *leftImage;
@end

@implementation TTUserHomePageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationBar.backgroundColor = [UIColor clearColor];
    self.swipeTableView.backgroundColor = [UIColor whiteColor];
    
    [self loadData];
    
    [self.swipeTableView reloadData];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.swipeTableView.currentScrollView];
}


- (void)loadData {
    
    TTUserHomePageRequest *request = [TTUserHomePageRequest new];
    request.urlString = TTURLManager.userHomePageURLString;
    request.user_id = _user_id;
    [request sendRequestWithCompletion:^(id responseJSON, NSError *error) {
        if (responseJSON) {
            NSDictionary *data = responseJSON[@"data"];
            
            TTUserHomePageModel *model = [TTUserHomePageModel mj_objectWithKeyValues:data];
            
            self.headerView.model = model;
            
            [self.swipeTableView reloadData];
            
        }
    }];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentInset.top + scrollView.contentOffset.y;
//    NSLog(@"offsetY:%.2f", offsetY);
    CGFloat maxHeight = self.headerView.bounds.size.height - (kTopBarHeight);
//    NSLog(@"height:%@  maxHeight:%@", @(self.headerView.bounds.size.height), @(maxHeight));
    if (offsetY < 0) {
        _leftImage = [UIImage imageNamed:@"personal_home_back_white_24x24_"];
        _navBackColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        _navBottomColor = [[UIColor tt_navLineColor] colorWithAlphaComponent:0];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
    } else if (offsetY < maxHeight) {
        _leftImage = [UIImage imageNamed:@"personal_home_back_white_24x24_"];
        CGFloat alpha = offsetY/maxHeight;
        _navBackColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
        _navBottomColor = [[UIColor tt_navLineColor] colorWithAlphaComponent:alpha];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        
        _leftImage = [UIImage imageNamed:@"personal_home_back_black_24x24_"];
        _navBackColor = [[UIColor whiteColor] colorWithAlphaComponent:1];
        _navBottomColor = [[UIColor tt_navLineColor] colorWithAlphaComponent:1];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    self.navigationBar.backgroundColor = _navBackColor;
    [self.navigationBar updateNavigationBar];
    [self.headerView scrollViewDidScroll:scrollView];
}
#pragma mark -
- (UIColor *)navigationBarBottomColor:(TTNavigationBar *)navigationBar {
    return _navBottomColor;
}
- (UIImage *)navigationBarLeftImage:(UIButton *)button navigationBar:(TTNavigationBar *)navigationBar {
    return _leftImage;
}



#pragma mark -
- (NSInteger)numberOfItemsInSwipeTableView:(SwipeTableView *)swipeView {
    return 4;
}
- (UIScrollView *)swipeTableView:(SwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view {
    
    UITableView *tableView = (UITableView *)view;
    if (tableView == nil) {
        tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.frame = swipeView.bounds;
        tableView.delegate = self;
//        tableView.contentInset = UIEdgeInsetsMake(-kTopBarHeight, 0, 0, 0);
        if ([tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    tableView.backgroundColor = index % 2 ? [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]:[UIColor colorWithRed:0.25 green:0.45 blue:0.35 alpha:1.0];
    return tableView;
}

#pragma mark -
- (SwipeTableView *)swipeTableView {
    if (!_swipeTableView) {
        _swipeTableView = [[SwipeTableView alloc] initWithFrame:self.view.bounds];
        _swipeTableView.delegate = self;
        _swipeTableView.dataSource = self;
        [self.view addSubview:_swipeTableView];
        
        _swipeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _swipeTableView.shouldAdjustContentSize = YES;
        
//        _swipeTableView.swipeHeaderTopInset = kTopBarHeight;
        _swipeTableView.stickyHeaderTopInset = kTopBarHeight;
        
        _swipeTableView.swipeHeaderView = self.headerView;
        _swipeTableView.swipeHeaderBar = self.sectionView;
        
//        CGRect frame = self.headerView.frame;
//        frame.size.height += kTopBarHeight;
//        self.headerView.frame = frame;
        
        _sectionView.backgroundColor = [UIColor yellowColor];
        
        _swipeTableView.scrollEnabled = YES;
        
    }
    return _swipeTableView;
}
- (TTUserHomePageHeadView *)headerView {
    if (!_headerView) {
        TTUserHomePageHeadView *headView = [[TTUserHomePageHeadView alloc] init];
//        headView.backgroundColor = [UIColor redColor];
        headView.frame = CGRectMake(0, 0, kScreenWidth, 250);
        _headerView = headView;
    }
    return _headerView;
}
- (UIView *)sectionView {
    if (!_sectionView) {
        UIView *sectionView = [UIView new];
        sectionView.backgroundColor = [UIColor orangeColor];
        sectionView.frame = CGRectMake(0, 0, kScreenWidth, 44);
        _sectionView = sectionView;
    }
    return _sectionView;
}
@end
