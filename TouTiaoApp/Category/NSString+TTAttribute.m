//
//  NSString+TTAttribute.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "NSString+TTAttribute.h"

@implementation NSString (TTAttribute)
- (CGSize)tt_sizeWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace {
    return [self tt_sizeWithFont:font maxSize:CGSizeMake(width, MAXFLOAT) lineSpace:lineSpace];
}
- (CGSize)tt_sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize lineSpace:(CGFloat)lineSpace {
    
    NSMutableDictionary *attributes = @{}.mutableCopy;
    attributes[NSFontAttributeName] = font;
    if (lineSpace > 0) {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineSpacing = lineSpace;
        attributes[NSParagraphStyleAttributeName] = style;
    }
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}

- (NSAttributedString *)tt_attributeStringWithFont:(UIFont *)font lineSpace:(CGFloat)lineSpace {
    NSMutableDictionary *attributes = @{}.mutableCopy;
    attributes[NSFontAttributeName] = font;
    if (lineSpace > 0) {
        NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
        style.lineSpacing = lineSpace;
        attributes[NSParagraphStyleAttributeName] = style;
    }
    
    NSMutableAttributedString *muAtt = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
    return muAtt;
}
@end
