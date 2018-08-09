//
//  TTConst.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MJExtension/MJExtension.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import "NSString+TTAttribute.h"
#import <Masonry/Masonry.h>
#import "UIImageView+TTWeb.h"
#import "UIFont+TTMore.h"
#import "UIColor+TTMore.h"
#import "UIImage+TTMore.h"


#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight    [UIApplication sharedApplication].statusBarFrame.size.height
#define kNavigationHeight   44.0f
#define kTopBarHeight       kStatusBarHeight + kNavigationHeight



#define kLINE_HEIGHT    1.0/[UIScreen mainScreen].scale



void dispatch_main_async_safe(dispatch_block_t block);
void dispatch_global_async(dispatch_block_t block);
