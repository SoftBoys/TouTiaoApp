//
//  TTNumberFormatter.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTNumberFormatter.h"

@implementation TTNumberFormatter

+ (NSString *)formatterStringWithInteger:(NSInteger)count {
    
    NSUInteger unit = 10000;
    
    NSInteger index = 0;
    while (count >= unit) {
        count = count/unit;
        index ++;
    }
    NSString *string = @(count).stringValue;
    
    if (index == 0) {
        string = [NSString stringWithFormat:@"%@", @(count)];
    } else if (index == 1) {
        string = [NSString stringWithFormat:@"%@%@", @(count), @"万"];
    } else if (index == 2) {
        string = [NSString stringWithFormat:@"%@%@", @(count), @"亿"];
    } else if (index == 3) {
        string = [NSString stringWithFormat:@"%@%@", @(count), @"兆"];
    }
    return string;
}

@end
