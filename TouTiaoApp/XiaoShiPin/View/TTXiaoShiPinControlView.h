//
//  TTXiaoShiPinControlView.h
//  TouTiaoApp
//
//  Created by gjw on 2018/8/11.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZFPlayer/ZFPlayer.h>

@interface TTXiaoShiPinControlView : UIView <ZFPlayerMediaControl>


- (void)setCoverImageWithURLString:(NSString *)URLString;

- (void)resetControlView;
@end
