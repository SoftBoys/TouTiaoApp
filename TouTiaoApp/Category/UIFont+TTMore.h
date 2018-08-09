//
//  UIFont+TTMore.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TTMore)

+ (UIFont *)tt_navTitleFont;
+ (UIFont *)tt_homePageTitleFont;
+ (UIFont *)tt_homeTitleFont;
+ (UIFont *)tt_homeTimeFont;


//
+ (UIFont *)tt_fontOfSize:(CGFloat)fontSize;
+ (UIFont *)tt_boldFontOfSize:(CGFloat)fontSize;
@end
