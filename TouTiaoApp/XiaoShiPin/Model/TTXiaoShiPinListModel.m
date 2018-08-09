//
//  TTXiaoShiPinListModel.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinListModel.h"
#import <MJExtension/MJExtension.h>

@implementation TTXiaoShiPinListModel

- (TTXiaoShiPinDetailModel *)model {
    if (!_model) {
        NSDictionary *dict = [_content mj_JSONObject];
        _model = [TTXiaoShiPinDetailModel mj_objectWithKeyValues:dict[@"raw_data"]];
    }
    return _model;
}

@end

@implementation TTXiaoShiPinDetailModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"action":@"action",
             @"info":@"user.info",
             @"play_addr":@"video.play_addr",
             @"download_addr":@"video.download_addr",
             };
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"first_frame_image_list":[TTXiaoShiPinVideoModel class]};
}

@end

@implementation TTXiaoShiPinActionModel



@end

@implementation TTXiaoShiPinVideoModel



@end
