//
//  TTXiaoShiPinDetailCollectionView.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/11.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinDetailCollectionView.h"

@implementation TTXiaoShiPinDetailCollectionView
/** 开启支持多个手势 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer.view == self) {
        if (self.contentOffset.x <= 0 && gestureRecognizer.state != UIGestureRecognizerStatePossible) {
            return YES;
        }
    }
    return NO;
}
/** 触摸屏幕时保证 collectionView 可以响应 */
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    self.scrollEnabled = YES;
    return [super hitTest:point withEvent:event];
}

@end
