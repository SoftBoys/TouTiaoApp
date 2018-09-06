//
//  TTBaseTableViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseTableViewController.h"


@interface TTBaseTableViewController ()

@end

@implementation TTBaseTableViewController
- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}
- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super init]) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
        
        _tableView.separatorColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        
        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _tableView.separatorColor = [UIColor tt_homeCellSepLineColor];
        
        // ios 11
        if ([_tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        CGRect headFrame = CGRectMake(0, 0, kScreenWidth, CGFLOAT_MIN);
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:headFrame];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:headFrame];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    CGFloat tableY = CGRectGetHeight(self.navigationBar.bounds);
    CGFloat tableH = CGRectGetHeight(self.view.bounds) - tableY;
    CGFloat tableW = CGRectGetWidth(self.view.bounds);
    self.tableView.frame = CGRectMake(0, tableY, tableW, tableH);
    
}

#pragma mark -
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTBaseTableViewCell *cell = [TTBaseTableViewCell cellForTableView:tableView];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIEdgeInsets insets = [self sepLineEdgeInsetsAtIndexPath:indexPath];
    tableView.layoutMargins = insets;
    tableView.separatorInset = insets;
    cell.layoutMargins = insets;
    cell.separatorInset = insets;
    
}
- (UIEdgeInsets)sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath {
    return UIEdgeInsetsZero;
}

@end
