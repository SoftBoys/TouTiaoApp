//
//  UIColor+TTMore.h
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TTMore)

+ (UIColor *)tt_navRedColor;
+ (UIColor *)tt_navLineColor;

+ (UIColor *)tt_homePageTitleColor;
+ (UIColor *)tt_homeTitleColor;
+ (UIColor *)tt_homeTimeColor;

+ (UIColor *)tt_placeholderImageColor;
+ (UIColor *)tt_homeCellSepLineColor;
//
+ (UIColor *)tt_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;
+ (UIColor *)tt_colorWithHexString:(NSString *)hexString;
@end
