//
//  TTRequestManager.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRequestManager.h"
#import <AFNetworking.h>
//

static NSString *kHost = @"https://lf.snssdk.com";

@interface AFHTTPSessionManager (Shared)
+ (instancetype)shareManager;
@end

@implementation AFHTTPSessionManager (Shared)
+ (instancetype)shareManager {
    static AFHTTPSessionManager *_manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:kHost]];
        _manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
        serializer.removesKeysWithNullValues = YES;
        
        [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _manager.requestSerializer.timeoutInterval = 10.0f;
        [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        _manager.responseSerializer = serializer;
    });
    return _manager;
}
@end

@implementation TTRequestManager
+ (AFHTTPSessionManager *)manager {
    return [AFHTTPSessionManager shareManager];
}

+ (void)getWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(TTResponseHandle)completion {
    
    [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
    }];
    
}
+ (void)postWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(TTResponseHandle)completion {
    [self.manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}


+ (void)cancelURLString:(NSString *)URLString {
    [self.manager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.currentRequest.URL.absoluteString containsString:URLString]) {
            [obj cancel];
            *stop = YES;
        }
    }];
}
@end
