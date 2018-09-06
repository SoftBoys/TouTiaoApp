//
//  TTHomeNewsRequest.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeNewsRequest.h"

@implementation TTHomeNewsRequest
- (instancetype)init {
    if (self = [super init]) {
        _tt_from = @"pull";
        _ts = [[NSDate date] timeIntervalSince1970];
        _count = 10;
//        _refresh_reason = 1;
    }
    return self;
}
@end
