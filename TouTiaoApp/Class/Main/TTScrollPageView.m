//
//  TTScrollPageView.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTScrollPageView.h"

@interface TTScrollPageView ()
@property (nonatomic, strong) CALayer *bottomLayer;
@end
@implementation TTScrollPageView
+ (ZJSegmentStyle *)segmentStyle {
    ZJSegmentStyle *style = [ZJSegmentStyle new];
    style.showLine = NO;
    
    style.gradualChangeTitleColor = YES;
    style.titleFont = [UIFont systemFontOfSize:16];
    style.scaleTitle = YES;
    style.titleBigScale = 1.05;
    style.animatedContentViewWhenTitleClicked = NO;
//    style.scrollLineColor = kColorWithHexString(@"#f29800");
//    style.scrollLineHeight = 0;
    //        style.normalTitleColor = [UIColor jl_red:0 green:0 blue:0];
    style.normalTitleColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    
    style.selectedTitleColor = kCOLOR_NAV_RED;
//    style.selectedTitleColor = style.scrollLineColor;
    
    style.autoAdjustTitlesWidth = YES;
    
    style.showExtraButton = NO;
    return style;
}
- (instancetype)initWithFrame:(CGRect)frame segmentStyle:(ZJSegmentStyle *)segmentStyle titles:(NSArray<NSString *> *)titles parentViewController:(UIViewController *)parentViewController delegate:(id<ZJScrollPageViewDelegate>)delegate {
    
    ZJSegmentStyle *style = segmentStyle ?:[TTScrollPageView segmentStyle];
    
    if (self = [super initWithFrame:frame segmentStyle:style titles:titles parentViewController:parentViewController delegate:delegate]) {
        
        [self.segmentView.layer addSublayer:self.bottomLayer];
        
    }
    return self;
    
}

- (CALayer *)bottomLayer {
    if (!_bottomLayer) {
        UIView *segmentView = self.segmentView;
        
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor lightGrayColor].CGColor;
        
        CGFloat layerY = CGRectGetHeight(segmentView.bounds);
        CGFloat layerW = CGRectGetWidth(segmentView.bounds);
        CGFloat layerH = kLINE_HEIGHT;
        layer.frame = CGRectMake(0, layerY, layerW, layerH);
        [segmentView.layer addSublayer:layer];
        _bottomLayer = layer;
    }
    return _bottomLayer;
}

@end
