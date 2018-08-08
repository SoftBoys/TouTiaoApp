//
//  TTURLHandleManager.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//


#define kUserHomePageURL(user_id) [NSString stringWithFormat:@"%@?user_id=%@", @"toutiao://user_homepage", user_id]



#import <Foundation/Foundation.h>

@interface TTURLHandleManager : NSObject

+ (void)parseAppURL:(NSURL *)url;

+ (UIViewController *)topViewController;
@end
