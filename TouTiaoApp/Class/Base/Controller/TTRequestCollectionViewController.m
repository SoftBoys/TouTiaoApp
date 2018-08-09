//
//  TTRequestCollectionViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRequestCollectionViewController.h"
#import "TTRefreshFooter.h"
#import "TTRefreshGifHeader.h"

@interface TTRequestCollectionViewController ()

@end

@implementation TTRequestCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak typeof(self) weakself = self;
    self.collectionView.mj_header = [TTRefreshGifHeader headerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        [strongself loadIsMore:NO];
    }];
    self.collectionView.mj_footer = [TTRefreshFooter footerWithRefreshingBlock:^{
        __strong typeof(weakself) strongself = weakself;
        [strongself loadIsMore:YES];
    }];
    
    [self.collectionView.mj_header beginRefreshing];
    
}

- (void)loadIsMore:(BOOL)isMore {
    
}

- (void)endHeaderFooterRefresh {
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}

@end
