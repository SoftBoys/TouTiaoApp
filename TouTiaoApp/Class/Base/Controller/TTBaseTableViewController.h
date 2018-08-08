//
//  TTBaseTableViewController.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseViewController.h"
#import "TTBaseTableViewCell.h"

@interface TTBaseTableViewController : TTBaseViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;




- (UIEdgeInsets)sepLineEdgeInsetsAtIndexPath:(NSIndexPath *)indexPath;
@end
