//
//  NSString+TTAttribute.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TTAttribute)
- (CGSize)tt_sizeWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace;
- (CGSize)tt_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpace:(CGFloat)lineSpace;

- (NSAttributedString *)tt_attributeStringWithFont:(UIFont *)font lineSpace:(CGFloat)lineSpace;
@end
