//
//  CGXSlideTitleItemCell.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/20.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideTitleItemCell.h"

@implementation CGXSlideTitleItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    _textLabel = [[UILabel alloc] init];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_textLabel];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _textLabel.frame = self.bounds;
}

@end
