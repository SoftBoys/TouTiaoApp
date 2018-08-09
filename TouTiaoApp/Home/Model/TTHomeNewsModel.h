//
//  TTHomeNewsModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTWebImage, TTHomeNewsModel;

@interface TTHomeNewsListModel : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) TTHomeNewsModel *newsModel;
@end

@interface TTHomeNewsModel : NSObject
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *stick_label; // 标签
@property (nonatomic, copy) NSString *source; // 来源
@property (nonatomic, copy) NSString *label; // 标签
@property (nonatomic, assign) NSInteger comment_count; // 评论数

@property (nonatomic, strong) TTWebImage *middle_image;
@property (nonatomic, copy) NSArray <TTWebImage*> *image_list;

@property (nonatomic, copy) NSString *url; // 链接
/** 标签【置顶】 */
@property (nonatomic, assign) BOOL stick_style;
/** 标签 【火】 */
@property (nonatomic, assign) BOOL hot;
@end

@interface TTWebImage : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *url;

@end
