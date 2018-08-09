//
//  TTHomeNavSearchView.h
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTHomeNavSearchView : UIView
/** 关键词 */
@property (nonatomic, copy) NSString *keywords;
/** 点击回调 */
@property (nonatomic, copy) void (^clickHandle)(NSString *keywords);

@end


@interface TTHomeNavItemButton : UIButton

@end
