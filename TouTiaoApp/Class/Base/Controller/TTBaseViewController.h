//
//  TTBaseViewController.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/26.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTNavigationBar.h"

@interface TTBaseViewController : UIViewController <TTNavigationBarDelegate, TTNavigationBarDataSource>
@property (nonatomic, strong) TTNavigationBar *navigationBar;
@end
