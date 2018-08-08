//
//  TTHomeDetailViewController.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTRequestTableViewController.h"
#import "TTScrollPageView.h"

@class TTHomeTitleModel;
@interface TTHomeDetailViewController : TTRequestTableViewController <ZJScrollPageViewChildVcDelegate>
@property (nonatomic, strong) TTHomeTitleModel *titleModel;

- (NSString *)listURLString;

@end
