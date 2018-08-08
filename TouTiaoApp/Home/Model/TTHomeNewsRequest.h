//
//  TTHomeNewsRequest.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseRequest.h"

@interface TTHomeNewsRequest : TTBaseRequest
@property (nonatomic , copy)NSString *category;

@property (nonatomic , copy)NSString *tt_from;
@property (nonatomic, assign) NSUInteger ts;
@property (nonatomic, strong) NSNumber *refresh_reason;
@property (nonatomic, strong) NSNumber *session_refresh_idx;

@property (nonatomic, strong) NSString *min_behot_time;
@property (nonatomic, strong) NSString *max_behot_time;

//@property (nonatomic , copy)NSString *iid;
//@property (nonatomic , copy)NSString *device_platform;
//@property (nonatomic , copy)NSString *version_code;

@end
