//
//  TTHomeTableViewCell.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeTableViewCell.h"
#import "TTHomeNewsViewModel.h"
#import "TTHomeNewsModel.h"


@interface TTHomeTableViewCell ()
@property (nonatomic, strong) UILabel *labtitle;
@property (nonatomic, strong) UILabel *labstick;
@property (nonatomic, strong) UILabel *labsource;
@property (nonatomic, strong) UIImageView *rightIconView;
@property (nonatomic, strong) NSMutableArray <UIImageView*>*iconViews;
@end
@implementation TTHomeTableViewCell

- (void)setupUI {
    
}
- (void)setViewModel:(TTHomeNewsViewModel *)viewModel {
    _viewModel = viewModel;
    if (_viewModel) {
//        self.labtitle.text = viewModel.model.title;
        self.labtitle.frame = viewModel.titleFrame;
        self.labtitle.attributedText = viewModel.title;
//        self.labtitle.backgroundColor = [UIColor redColor];
        
        self.labstick.frame = viewModel.stickFrame;
        self.labstick.attributedText = viewModel.stick;
    
        
        self.labsource.frame = viewModel.sourceFrame;
        self.labsource.attributedText = viewModel.source;
        
        self.rightIconView.frame = viewModel.rightFrame.iconFrame;
        [self.rightIconView tt_setImageWithURLString:viewModel.rightFrame.iconURL];
        
        self.rightIconView.hidden = viewModel.rightFrame == nil;
        
        NSArray <TTHomeImageFrame*> *imageFrames = viewModel.imageFrames;
        if (self.iconViews.count < imageFrames.count) {
            for (NSInteger i = self.iconViews.count; i < imageFrames.count; i++) {
                UIImageView *imageView = [UIImageView new];
                imageView.backgroundColor = [UIColor tt_placeholderImageColor];
//                imageView.contentMode = UIViewContentModeScaleAspectFit;
                [self.contentView addSubview:imageView];
                [self.iconViews addObject:imageView];
            }
        }
        
        [self.iconViews enumerateObjectsUsingBlock:^(UIImageView *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < imageFrames.count) {
                TTHomeImageFrame *frame = imageFrames[idx];
                [obj tt_setImageWithURLString:frame.iconURL];
                obj.frame = frame.iconFrame;
                obj.hidden = NO;
            } else {
                obj.hidden = YES;
            }
        }];

    }
}
#pragma mark -
- (UILabel *)labtitle {
    if (!_labtitle) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        _labtitle = label;
    }
    return _labtitle;
}
- (UILabel *)labstick {
    if (!_labstick) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor tt_navRedColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        label.layer.masksToBounds = YES;
        label.layer.cornerRadius = 3;
        label.layer.borderColor = [label.textColor CGColor];
        label.layer.borderWidth = kLINE_HEIGHT;
        _labstick = label;
    }
    return _labstick;
}
- (UILabel *)labsource {
    if (!_labsource) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.textColor = [UIColor tt_homeTimeColor];
        [self.contentView addSubview:label];
        _labsource = label;
    }
    return _labsource;
}
- (UIImageView *)rightIconView {
    if (!_rightIconView) {
        UIImageView *imageView = [UIImageView new];
        imageView.backgroundColor = [UIColor tt_placeholderImageColor];
//        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        _rightIconView = imageView;
    }
    return _rightIconView;
}

- (NSMutableArray<UIImageView *> *)iconViews {
    if (!_iconViews) {
        _iconViews = @[].mutableCopy;
    }
    return _iconViews;
}
@end
