//
//  TTRefreshGifHeader.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRefreshGifHeader.h"

@interface TTRefreshGifHeader ()
@property (weak, nonatomic) UILabel *label;
@end
@implementation TTRefreshGifHeader

- (void)prepare {
    [super prepare];
    
    // dropdown_loading_00
    
    NSMutableArray *imageList = @[].mutableCopy;
    for (NSInteger i = 0; i < 16; i++) {
        NSString *imageName = [NSString stringWithFormat:@"dropdown_loading_0%@",@(i)];
        UIImage *image = [UIImage imageNamed:imageName];
        [imageList addObject:image];
    }
    
    CGFloat duration = 2;
    [self setImages:imageList duration:duration forState:MJRefreshStateIdle];
    [self setImages:imageList duration:duration forState:MJRefreshStateRefreshing];
    [self setImages:imageList duration:duration forState:MJRefreshStatePulling];
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont boldSystemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.stateLabel.hidden = YES;
    self.label = label;
    
}
- (void)placeSubviews {
    [super placeSubviews];
    self.label.frame = CGRectMake(0, self.mj_h - 15, self.mj_w, 15);
    self.gifView.frame = CGRectMake((self.mj_w - 25) / 2.0, 5, 25, 25);
}
#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state {
    
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"下拉推荐";
            break;
        case MJRefreshStatePulling:
            self.label.text = @"松开推荐";
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"推荐中";
            break;
        default:
            break;
    }
}

@end
