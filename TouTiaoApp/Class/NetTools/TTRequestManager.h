//
//  TTRequestManager.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TTResponseHandle)(id responseJSON, NSError *error);

@interface TTRequestManager : NSObject

+ (void)getWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(TTResponseHandle)completion;
+ (void)postWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters completion:(TTResponseHandle)completion;

+ (void)cancelURLString:(NSString *)URLString;
@end
