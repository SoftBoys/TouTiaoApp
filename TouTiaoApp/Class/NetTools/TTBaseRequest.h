//
//  TTBaseRequest.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTRequestManager.h"
#import "TTURLManager.h"

@interface TTBaseRequest : NSObject

@property (nonatomic, assign) BOOL isPost;
@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, copy) NSString *device_platform;
@property (nonatomic, copy) NSString *iid;
@property (nonatomic, copy) NSDictionary *extraParamters;

- (instancetype)initWithURLString:(NSString *)URLString isPost:(BOOL)isPost;
- (void)sendRequestWithCompletion:(TTResponseHandle)completion;

@end
