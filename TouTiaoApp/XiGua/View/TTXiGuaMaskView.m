//
//  TTXiGuaMaskView.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiGuaMaskView.h"

#import "NSString+TTAttribute.h"

@interface TTXiGuaMaskView ()
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labplayed_count;
@end
@implementation TTXiGuaMaskView

+ (Class)layerClass {
    return [CAGradientLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CAGradientLayer *layer = (CAGradientLayer*)self.layer;
        layer.colors = @[(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor];
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(0, 1);
    }
    return self;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    
    CGFloat titleX = 15;
    CGFloat titleY = 8;
    CGFloat titleW = kScreenWidth - titleX*2;
    
    self.labtitle.frame = CGRectMake(titleX, titleY, titleW, 0);
    self.labtitle.text = title;
    [self.labtitle sizeToFit];
    
}
- (void)setPlayed_count:(NSUInteger)played_count {
    _played_count = played_count;
    NSString *unitString = [self unitStringWithCount:played_count];
    self.labplayed_count.text = [NSString stringWithFormat:@"%@次播放",unitString];
    [self.labplayed_count sizeToFit];
    
    CGRect countFrame = self.labplayed_count.frame;
    countFrame.origin = CGPointMake(15, CGRectGetMaxY(self.labtitle.frame)+3);
    self.labplayed_count.frame = countFrame;
}
- (NSString *)unitStringWithCount:(NSUInteger)count {
    NSInteger index = 0;
    NSInteger unit = 10000;
    while (count >= unit) {
        count = count / 10000;
        index ++;
    }
    NSString *string = @(count).stringValue;
    if (index == 1) {
        string = [NSString stringWithFormat:@"%@%@", @(count), @"万"];
    } else if (index == 2) {
        string = [NSString stringWithFormat:@"%@%@", @(count), @"亿"];
    }
    return string;
}
#pragma mark -
- (UILabel *)labtitle {
    if (!_labtitle) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont boldSystemFontOfSize:17];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [self addSubview:label];
        _labtitle = label;
    }
    return _labtitle;
}
- (UILabel *)labplayed_count {
    if (!_labplayed_count) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = [UIColor whiteColor];
//        label.numberOfLines = 0;
        [self addSubview:label];
        _labplayed_count = label;
    }
    return _labplayed_count;
}
@end
