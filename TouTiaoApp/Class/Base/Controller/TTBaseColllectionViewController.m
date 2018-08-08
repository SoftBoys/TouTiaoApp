//
//  TTBaseColllectionViewController.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/30.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTBaseColllectionViewController.h"

@interface TTBaseColllectionViewController ()

@end

@implementation TTBaseColllectionViewController
- (instancetype)initWithLayout:(UICollectionViewLayout *)layout {
    if (self = [super init]) {
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.autoresizingMask  = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        collectionView.frame = self.view.bounds;
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
