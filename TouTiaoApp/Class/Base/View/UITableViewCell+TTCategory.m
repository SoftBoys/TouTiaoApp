//
//  UITableViewCell+TTCategory.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "UITableViewCell+TTCategory.h"

@implementation UITableViewCell (TTCategory)
+ (instancetype)cellForTableView:(UITableView *)tableView {
    NSString *identifier = NSStringFromClass(self.class);
    [tableView registerClass:[self class] forCellReuseIdentifier:identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    return cell;
}
@end
