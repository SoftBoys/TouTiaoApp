//
//  TTHomeTitleModel.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTHomeTitleModel : NSObject
@property (nonatomic, copy) NSString *category;
@property (nonatomic, assign) NSInteger flags;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger tip_new;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger stick;
@end
