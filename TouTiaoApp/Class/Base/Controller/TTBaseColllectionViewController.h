//
//  TTBaseColllectionViewController.h
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTBaseColllectionViewController : TTBaseViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
- (instancetype)initWithLayout:(UICollectionViewLayout *)layout;
@end
