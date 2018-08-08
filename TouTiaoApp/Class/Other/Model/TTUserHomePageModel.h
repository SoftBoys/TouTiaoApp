//
//  TTUserHomePageModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/31.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTTopTab;
@interface TTUserHomePageModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *bg_img_url;
@property (nonatomic, copy) NSString *avatar_url;
@property (nonatomic, copy) NSString *big_avatar_url;
@property (nonatomic, copy) NSString *user_description;
@property (nonatomic, copy) NSArray <TTTopTab*> *top_tab;

@end

@interface TTTopTab : NSObject
@property (nonatomic, copy) NSString *show_name;
@property (nonatomic, copy) NSString *type;

@end
