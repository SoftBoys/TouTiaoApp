//
//  TTHomeNewsViewModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseViewModel.h"

@class TTHomeNewsModel, TTHomeImageFrame;
@interface TTHomeNewsViewModel : TTBaseViewModel
+ (instancetype)viewModelWithModel:(TTHomeNewsModel *)model;
@property (nonatomic, strong) TTHomeNewsModel *model;

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, copy) NSAttributedString *title;

@property (nonatomic, assign) CGRect stickFrame;
@property (nonatomic, copy) NSAttributedString *stick;

@property (nonatomic, assign) CGRect sourceFrame;
@property (nonatomic, copy) NSAttributedString *source;

@property (nonatomic, strong) TTHomeImageFrame *rightFrame;

@property (nonatomic, copy) NSArray <TTHomeImageFrame*> *imageFrames;


@end

@interface TTHomeImageFrame : NSObject
@property (nonatomic, assign) CGRect iconFrame;
@property (nonatomic, copy) NSString *iconURL;
@end

