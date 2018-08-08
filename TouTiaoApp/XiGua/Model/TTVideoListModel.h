//
//  TTVideoListModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTVideoUserInfoModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *user_id;

@end

@interface TTVideoURLInfoModel : NSObject
@property (nonatomic, copy) NSString *main_url;
@property (nonatomic, copy) NSString *backup_url_1;
@end

@interface TTVideoURLLevelModel : NSObject
@property (nonatomic, strong) TTVideoURLInfoModel *video_1; // 360p
@property (nonatomic, strong) TTVideoURLInfoModel *video_2; // 480p
@property (nonatomic, strong) TTVideoURLInfoModel *video_3; // 720p
@end

@interface TTVideoPlayInfoModel : NSObject
@property (nonatomic, copy) NSString *poster_url;
@property (nonatomic, assign) NSTimeInterval video_duration;
@property (nonatomic, strong) TTVideoURLLevelModel *video_list;
@end

@interface TTVideoDetailModel : NSObject

@property (nonatomic, copy) NSString *media_name;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *video_play_info;

@property (nonatomic, strong) TTVideoPlayInfoModel *playInfo;
@property (nonatomic, strong) TTVideoUserInfoModel *user_info;
@property (nonatomic, assign) NSInteger video_watch_count;
@end


@interface TTVideoListModel : NSObject

@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) TTVideoDetailModel *videoModel;

@end
