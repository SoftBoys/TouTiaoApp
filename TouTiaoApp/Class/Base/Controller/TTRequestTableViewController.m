//
//  TTRequestTableViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRequestTableViewController.h"

#import "TTRefreshGifHeader.h"
#import "TTRefreshFooter.h"

@interface TTRequestTableViewController ()

@end

@implementation TTRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) weakself = self;
    self.tableView.mj_header = [TTRefreshGifHeader headerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        [strongself loadIsMore:NO];
    }];
    self.tableView.mj_footer = [TTRefreshFooter footerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        [strongself loadIsMore:YES];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)loadIsMore:(BOOL)more {
    
}
- (void)endHeaderFooterRefresh {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
@end
