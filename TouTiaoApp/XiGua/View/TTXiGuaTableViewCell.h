//
//  TTXiGuaTableViewCell.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseTableViewCell.h"
#import <ZFPlayer/ZFAVPlayerManager.h>

static NSInteger kXiGuaContainerViewTag = 1000;
@class TTXiGuaVideoViewModel;
@interface TTXiGuaTableViewCell : TTBaseTableViewCell
@property (nonatomic, strong) TTXiGuaVideoViewModel *viewModel;

@property (nonatomic, copy) void (^playBlock)(TTXiGuaTableViewCell *cell, UIView *fatherView);

@property (nonatomic, assign) ZFPlayerPlaybackState playState;

@end

