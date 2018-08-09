//
//  TTXiaoShiPinDetailViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/8/9.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTXiaoShiPinDetailViewController.h"

@interface TTXiaoShiPinDetailViewController ()

@end

@implementation TTXiaoShiPinDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarHidden = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
