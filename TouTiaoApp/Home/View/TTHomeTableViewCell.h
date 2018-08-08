//
//  TTHomeTableViewCell.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseTableViewCell.h"

@class TTHomeNewsViewModel;
@interface TTHomeTableViewCell : TTBaseTableViewCell
@property (nonatomic, strong) TTHomeNewsViewModel *viewModel;
@end
