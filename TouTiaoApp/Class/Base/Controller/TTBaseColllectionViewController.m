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
+ (UICollectionViewFlowLayout *)defaultLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat space = 1;
    CGFloat width = (kScreenWidth-space)/2.0;
    CGFloat height = width * 1.5;
    layout.minimumLineSpacing = space;
    layout.minimumInteritemSpacing = space;
    layout.itemSize = CGSizeMake(width, height);
    return layout;
}
- (instancetype)init {
    return [self initWithLayout:[TTBaseColllectionViewController defaultLayout]];
}
- (instancetype)initWithLayout:(UICollectionViewLayout *)layout {
    if (self = [super init]) {
        
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.autoresizingMask  = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView = collectionView;
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.collectionView.frame = self.view.bounds;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
}
#pragma mark -
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}


@end
