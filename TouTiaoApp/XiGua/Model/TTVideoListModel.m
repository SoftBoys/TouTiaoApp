//
//  TTVideoListModel.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTVideoListModel.h"

@implementation TTVideoUserInfoModel
@end
@implementation TTVideoURLInfoModel
- (NSString *)main_url {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:_main_url options:(0)];
    return [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
}
- (NSString *)backup_url_1 {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:_backup_url_1 options:(0)];
    return [[NSString alloc] initWithData:data encoding:(NSUTF8StringEncoding)];
}
@end
@implementation TTVideoURLLevelModel
@end
@implementation TTVideoPlayInfoModel
@end
@implementation TTVideoDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"video_watch_count":@"video_detail_info.video_watch_count"};
}
- (TTVideoPlayInfoModel *)playInfo {
    if (!_playInfo) {
        _playInfo = [TTVideoPlayInfoModel mj_objectWithKeyValues:self.video_play_info.mj_JSONObject];
    }
    return _playInfo;
}
@end
@implementation TTVideoListModel

- (TTVideoDetailModel *)videoModel {
    if (!_videoModel) {
        NSDictionary *content = [self.content mj_JSONObject];
        _videoModel = [TTVideoDetailModel mj_objectWithKeyValues:content];
    }
    return _videoModel;
}

@end
