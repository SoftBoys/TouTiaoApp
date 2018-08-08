//
//  TTUserHomePageHeadView.h
//  TouTiaoApp
//
//  Created by gjw on 2018/8/1.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTUserHomePageModel, TTUserHomePageStrenchView;
@interface TTUserHomePageHeadView : UIView <UIScrollViewDelegate>
@property (nonatomic, strong) TTUserHomePageModel *model;
@end


@interface TTUserHomePageStrenchView : UIImageView <UIScrollViewDelegate>

@end
