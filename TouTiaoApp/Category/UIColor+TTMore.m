//
//  UIColor+TTMore.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "UIColor+TTMore.h"

@implementation UIColor (TTMore)

+ (UIColor *)tt_navRedColor {
    return [UIColor tt_colorWithRed:(0.97*255) green:(0.35*255) blue:(0.35*255)];
}
+ (UIColor *)tt_navLineColor {
    return [UIColor tt_colorWithRed:(226) green:(226) blue:(226)];
}
+ (UIColor *)tt_homePageTitleColor {
    return [UIColor tt_colorWithRed:(0) green:(0) blue:(0)];
}
+ (UIColor *)tt_homeTitleColor {
    return [UIColor tt_colorWithRed:(0) green:(0) blue:(0)];
}
+ (UIColor *)tt_homeTimeColor {
    return [UIColor tt_colorWithRed:(156) green:(156) blue:(156)];
}

+ (UIColor *)tt_placeholderImageColor {
    return [UIColor tt_colorWithRed:(206) green:(206) blue:(206)];
}
+ (UIColor *)tt_homeCellSepLineColor {
    return [UIColor tt_colorWithRed:(226) green:(226) blue:(226)];
}
#pragma mark -
+ (UIColor *)tt_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
+ (UIColor *)tt_colorWithHexString:(NSString *)hexString {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *cstring = [hexString stringByTrimmingCharactersInSet:set];
    
    if ([cstring.lowercaseString hasPrefix:@"0x"]) {
        cstring = [cstring substringFromIndex:2];
    }
    if ([cstring hasPrefix:@"#"]) {
        cstring = [cstring substringFromIndex:1];
    }
    if (cstring.length != 6) {
        return [UIColor clearColor];
    }
    NSRange range;
    range.length = 2;
    
    // R
    range.location = 0;
    NSString *redString = [cstring substringWithRange:range];
    // G
    range.location = 2;
    NSString *greenString = [cstring substringWithRange:range];
    // B
    range.location = 4;
    NSString *blueString = [cstring substringWithRange:range];
    
    unsigned int red,green,blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    
    return [self tt_colorWithRed:red green:green blue:blue];
}
@end
