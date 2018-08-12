//
//  TTXiaoShiPinDetailCell.h
//  TouTiaoApp
//
//  Created by gjw on 2018/8/10.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger kXiaoShiPinContainerViewTag = 10000;

@class TTXiaoShiPinListModel, TTXiaoShiPinDetailCell;

@protocol TTXiaoShiPinDetailCell <NSObject>
@optional
- (void)closeXiaoShiPinCell:(TTXiaoShiPinDetailCell *)cell;

@end

@interface TTXiaoShiPinDetailCell : UICollectionViewCell
@property (nonatomic, strong) TTXiaoShiPinListModel *model;
@property (nonatomic, weak) id<TTXiaoShiPinDetailCell> delegate;
@end
