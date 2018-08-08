//
//  TTBaseRequest.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseRequest.h"
#import <MJExtension/MJExtension.h>

@interface TTBaseRequest ()

@end
@implementation TTBaseRequest
- (instancetype)init {
    return [self initWithURLString:nil isPost:NO];
}
- (instancetype)initWithURLString:(NSString *)URLString isPost:(BOOL)isPost {
    if (self = [super init]) {
        _urlString = URLString;
        _isPost = isPost;
        _device_platform = @"iphone";
        _iid = @"39017203220";
    }
    return self;
}
- (void)sendRequestWithCompletion:(TTResponseHandle)completion {
    if (self.urlString.length == 0 || self.urlString == nil) {
        return;
    }
    
    NSMutableDictionary *parameters = [self parames];
    if (self.isPost) {
        [TTRequestManager postWithURLString:self.urlString parameters:parameters completion:^(id responseJSON, NSError *error) {
            completion ? completion(responseJSON, error):nil;
        }];
    } else {
        [TTRequestManager getWithURLString:self.urlString parameters:parameters completion:^(id responseJSON, NSError *error) {
            completion ? completion(responseJSON, error):nil;
        }];
    }
}


- (NSMutableDictionary *)parames {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.extraParamters) {
        [params addEntriesFromDictionary:self.extraParamters];
    }
    NSDictionary *keyValues = self.mj_keyValues;
    if (keyValues) {
        [params addEntriesFromDictionary:keyValues];
    }
    
    if ([params.allKeys containsObject:@"isPost"]) {
        [params removeObjectForKey:@"isPost"];
    }
    if ([params.allKeys containsObject:@"urlString"]) {
        [params removeObjectForKey:@"urlString"];
    }
    if ([params.allKeys containsObject:@"extraParamters"]) {
        [params removeObjectForKey:@"extraParamters"];
    }
//    if ([params.allKeys containsObject:@"isPost"]) {
//        [params removeObjectForKey:@"isPost"];
//    }
    
    return params;
}
@end
