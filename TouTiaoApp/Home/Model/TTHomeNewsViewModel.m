//
//  TTHomeNewsViewModel.m
//  TouTiaoApp
//
//  Created by gjw on 2018/7/27.
//  Copyright © 2018年 guojunwei. All rights reserved.
//

#import "TTHomeNewsViewModel.h"
#import "TTHomeNewsModel.h"

@implementation TTHomeNewsViewModel
+ (instancetype)viewModelWithModel:(TTHomeNewsModel *)model {
    TTHomeNewsViewModel *viewModel = [TTHomeNewsViewModel new];
    viewModel.model = model;
    return viewModel;
}
- (void)setModel:(TTHomeNewsModel *)model {
    _model = model;
    
    if (_model) {
        
        
        UIFont *titleFont = [UIFont systemFontOfSize:18];
        _title = [model.title tt_attributeStringWithFont:titleFont lineSpace:5];
        CGFloat titleX = 15;
        CGFloat titleY = 10;
        CGFloat titleW = kScreenWidth - titleX*2;
        
        
        CGFloat sourceY = 0;
        // 图片list
        if (model.image_list.count) {
            CGFloat titleH = [model.title tt_sizeWithFont:titleFont width:titleW lineSpace:5].height;
            _titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
            
            CGFloat imageY = CGRectGetMaxY(_titleFrame) + 10;
            CGFloat imageX = titleX;
            CGFloat space = 4;
            CGFloat imageW = (kScreenWidth - imageX*2 - space*2)/3;
            CGFloat imageH = (3.0/4.0)*imageW;
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger i = 0; i < model.image_list.count; i++) {
                if (i >= 3) {
                    break;
                }
                imageX = (imageW + space) * i + titleX;
                CGRect imageFrame = CGRectMake(imageX, imageY, imageW, imageH);
                TTWebImage *image = model.image_list[i];
                TTHomeImageFrame *frame = [TTHomeImageFrame new];
                frame.iconFrame = imageFrame;
                frame.iconURL = image.url;
                [array addObject:frame];
            }
            self.imageFrames = array;
            
            CGRect lastFrame = self.imageFrames.lastObject.iconFrame;
            
            sourceY = CGRectGetMaxY(lastFrame);
            
        } else if (model.middle_image.url.length) { // 右侧有图片
            
            CGFloat iconW = 110;
            CGFloat iconH = iconW * (3.0/4.0);
            CGFloat iconX = kScreenWidth - iconW - 15;
            CGFloat iconY = 12;
            
            CGRect iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
            _rightFrame = [TTHomeImageFrame new];
            _rightFrame.iconURL = model.middle_image.url;
            _rightFrame.iconFrame = iconFrame;
            titleW = CGRectGetMinX(iconFrame) - titleX - 10;
            CGFloat titleH = [model.title tt_sizeWithFont:titleFont width:titleW lineSpace:5].height;
            _titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
            
            sourceY = MAX(CGRectGetMaxY(_titleFrame), CGRectGetMaxY(iconFrame));
            sourceY = CGRectGetMaxY(_titleFrame);
            
        } else {
            
            CGFloat titleH = [model.title tt_sizeWithFont:titleFont width:titleW lineSpace:5].height;
            _titleFrame = CGRectMake(titleX, titleY, titleW, titleH);
            
            sourceY = CGRectGetMaxY(_titleFrame);
        }
        
        NSString *stick = nil;
        if (model.stick_style) {
            stick = @"置顶";
        } else if (model.hot) {
            stick = @"热";
        }
        if (stick.length) {
            UIFont *stickFont = [UIFont systemFontOfSize:10];
            //
            CGFloat stickX = titleX;
            CGFloat stickY = sourceY + 5;
            CGSize stickSize = [stick tt_sizeWithFont:stickFont width:kScreenWidth lineSpace:4];
            _stickFrame = CGRectMake(stickX, stickY, stickSize.width + 6, stickSize.height + 0);
            NSMutableAttributedString *attStick = [stick tt_attributeStringWithFont:stickFont lineSpace:0].mutableCopy;
            NSRange range = NSMakeRange(0, attStick.length);
            NSDictionary *attribute = [attStick attributesAtIndex:0 effectiveRange:&range];
            NSMutableParagraphStyle *style = attribute[NSParagraphStyleAttributeName];
            style.alignment = NSTextAlignmentCenter;
            
            _stick = attStick;
            
        }
        
        NSMutableString *muSource = [NSMutableString string];
        if (model.source) {
            [muSource appendString:[NSString stringWithFormat:@"%@   ",model.source]];
        }
        
        [muSource appendString:[NSString stringWithFormat:@"%@评论", @(model.comment_count)]];
        
        UIFont *sourceFont = [UIFont systemFontOfSize:11];
        _source = [muSource tt_attributeStringWithFont:sourceFont lineSpace:4];
        
        CGFloat sourceX = _stick ? CGRectGetMaxX(_stickFrame) + 4 : titleX;
        CGFloat sourceT = sourceY + 5;
        CGSize sourceSize = [muSource tt_sizeWithFont:sourceFont width:kScreenWidth lineSpace:4];
        _sourceFrame = CGRectMake(sourceX, sourceT, sourceSize.width, sourceSize.height + 4);
        
        
        
        
        if (_rightFrame) {
            self.cellheight = MAX(CGRectGetMaxY(_sourceFrame), CGRectGetMaxY(_rightFrame.iconFrame))  + 10;
        } else {
            self.cellheight = CGRectGetMaxY(_sourceFrame) + 10;
        }
        
        
    }
    
}
@end

@implementation  TTHomeImageFrame

@end
