//
//  UIImageView+TTWeb.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "UIImageView+TTWeb.h"

#import <SDWebImage/UIImageView+WebCache.h>


@implementation UIImageView (TTWeb)

- (void)tt_setImageWithURLString:(NSString *)urlString {
//    [self yy_setImageWithURL:[NSURL URLWithString:urlString] placeholder:nil];
//    [self yy_setImageWithURL:[NSURL URLWithString:urlString] options:0];
    [self sd_setImageWithURL:[NSURL URLWithString:urlString]];
    
}

@end
