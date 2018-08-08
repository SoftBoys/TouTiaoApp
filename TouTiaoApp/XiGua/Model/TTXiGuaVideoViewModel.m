//
//  TTXiGuaVideoViewModel.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiGuaVideoViewModel.h"
#import "TTVideoListModel.h"

@implementation TTXiGuaVideoViewModel

- (void)setModel:(TTVideoDetailModel *)model {
    _model = model;
    if (_model) {
        CGFloat imageW = kScreenWidth;
        CGFloat imageH = imageW * 0.56;
        _backImageViewFrame = CGRectMake(0, 0, imageW, imageH);
        
        
        
        self.cellheight = CGRectGetMaxY(_backImageViewFrame) + 45;
        
        int seconds = model.playInfo.video_duration;
        _durationText = [NSString stringWithFormat:@"%02d:%02d", seconds/60, seconds%60];
        
    }
}
@end
