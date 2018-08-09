//
//  TTXiaoShiPinViewController.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRequestCollectionViewController.h"
#import "TTScrollPageView.h"

@class TTHomeTitleModel;
@interface TTXiaoShiPinViewController : TTRequestCollectionViewController <ZJScrollPageViewChildVcDelegate>
/** 通过首页入口进去的 */
@property (nonatomic, assign) BOOL is_subVC;
@property (nonatomic, strong) TTHomeTitleModel *titleModel;

@end
