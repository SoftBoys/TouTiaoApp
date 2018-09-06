//
//  TTRefreshFooter.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRefreshFooter.h"

@interface TTRefreshFooter ()
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIImageView *imageView;
@end
@implementation TTRefreshFooter

- (void)prepare {
    [super prepare];
    
    self.mj_h = 50;
    
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont boldSystemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    self.label = label;
    
    UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_add_video_16x16_"]];
    logo.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logo];
    self.imageView = logo;
    self.automaticallyHidden = YES;
    
    
    
}
- (void)placeSubviews {
    [super placeSubviews];
    self.label.frame = self.bounds;
    self.imageView.bounds = CGRectMake(0, 0, 16, 16);
    self.imageView.center = CGPointMake(self.mj_w * 0.5 + 60, self.mj_h * 0.5);
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            self.label.text = @"上拉加载数据";
            self.imageView.hidden = NO;
            [self stopRotation];
            break;
        case MJRefreshStateRefreshing:
            self.label.text = @"正在努力加载";
            self.imageView.hidden = NO;
            [self startRotation];
            break;
        case MJRefreshStateNoMoreData:
            self.label.text = @"木有数据了";
            self.imageView.hidden = YES;
            [self stopRotation];
            break;
        default:
            break;
    }
}

- (void)startRotation {
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(0);
    animation.toValue = @(M_PI*2);
    animation.repeatCount = MAXFLOAT;
    animation.duration = 2;
    
    [self.imageView.layer addAnimation:animation forKey:@"rotation"];
}
- (void)stopRotation {
    
    if ([self.imageView.layer animationForKey:@"rotation"]) {
        [self.imageView.layer removeAnimationForKey:@"rotation"];
    }
}
@end
