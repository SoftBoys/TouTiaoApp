//
//  TTXiaoShiPinListModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTVideoListModel.h"

@class TTXiaoShiPinDetailModel, TTXiaoShiPinActionModel, TTXiaoShiPinVideoModel;
@interface TTXiaoShiPinListModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) TTXiaoShiPinDetailModel *model;
@end

@interface TTXiaoShiPinDetailModel : NSObject
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) TTXiaoShiPinActionModel *action; // action
@property (nonatomic, strong) TTVideoUserInfoModel *info; // user.info
@property (nonatomic, copy) NSArray <TTXiaoShiPinVideoModel*> *first_frame_image_list;
@property (nonatomic, strong) TTXiaoShiPinVideoModel *play_addr; // video.play_addr
@property (nonatomic, strong) TTXiaoShiPinVideoModel *download_addr; // video.download_addr
@end

@interface TTXiaoShiPinActionModel : NSObject
@property (nonatomic, assign) NSInteger bury_count;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, assign) NSInteger digg_count; // 点赞次数
@property (nonatomic, assign) NSInteger play_count; // 播放次数
@property (nonatomic, assign) NSInteger read_count;
@property (nonatomic, assign) NSInteger user_bury;
@property (nonatomic, assign) NSInteger user_digg;
@property (nonatomic, assign) NSInteger user_repin;
@property (nonatomic, assign) NSInteger forward_count;
@end

@interface TTXiaoShiPinVideoModel : NSObject
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSArray *url_list;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@end
