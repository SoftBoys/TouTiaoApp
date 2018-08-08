//
//  TTHomeNewsModel.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeNewsModel.h"

@implementation TTHomeNewsListModel
- (TTHomeNewsModel *)newsModel {
    if (!_newsModel) {
        _newsModel = [TTHomeNewsModel mj_objectWithKeyValues:[self.content mj_JSONObject]];
    }
    return _newsModel;
}
@end
@implementation TTHomeNewsModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"image_list":[TTWebImage class]};
}
@end
@implementation TTWebImage

@end
