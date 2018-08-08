//
//  TTURLManager.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTURLManager.h"

@implementation TTURLManager
+ (NSString *)homeTitleURLString {
    return @"/article/category/get_subscribed/v4/";
}
+ (NSString *)homeListURLString {
    return @"/api/news/feed/v85/";
}
+ (NSString *)videoTitleURLString {
    return @"video_api/get_category/v3/";
}
+ (NSString *)videoListURLString {
    return @"/api/news/feed/v64/";
}

+ (NSString *)userHomePageURLString {
    return @"user/profile/homepage/v6/";
}
@end
