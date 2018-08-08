//
//  TTXiGuaVideoViewModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseViewModel.h"

@class TTVideoDetailModel;
@interface TTXiGuaVideoViewModel : TTBaseViewModel
@property (nonatomic, strong) TTVideoDetailModel *model;

@property (nonatomic, assign) CGRect backImageViewFrame;

@property (nonatomic, copy) NSString *durationText;

@end
