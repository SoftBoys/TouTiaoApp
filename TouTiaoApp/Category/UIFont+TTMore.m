//
//  UIFont+TTMore.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "UIFont+TTMore.h"

@implementation UIFont (TTMore)

+ (UIFont *)tt_navTitleFont {
    return [UIFont tt_boldFontOfSize:17];
}
+ (UIFont *)tt_homePageTitleFont {
    return [UIFont tt_fontOfSize:16];
}
+ (UIFont *)tt_homeTitleFont {
    return [UIFont tt_fontOfSize:18];
}
+ (UIFont *)tt_homeTimeFont {
    return [UIFont tt_fontOfSize:10];
}


//
+ (UIFont *)tt_fontOfSize:(CGFloat)fontSize {
    return [UIFont systemFontOfSize:fontSize];
}
+ (UIFont *)tt_boldFontOfSize:(CGFloat)fontSize {
    return [UIFont boldSystemFontOfSize:fontSize];
}


@end
