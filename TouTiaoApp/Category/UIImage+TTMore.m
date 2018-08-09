//
//  UIImage+TTMore.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "UIImage+TTMore.h"

@implementation UIImage (TTMore)

+ (UIImage *)tt_imageWithColor:(UIColor *)color {
    return [UIImage tt_imageWithColor:color size:CGSizeMake(1, 1)];
}
+ (UIImage *)tt_imageWithColor:(UIColor *)color size:(CGSize)size {
    if (color == nil || size.width <= 0 || size.height <= 0) {
        return nil;
    }

    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
