//
//  CGXSlideShowCell.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2018/3/15.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import "CGXSlideShowCell.h"

@implementation CGXSlideShowCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}
- (UILabel *)tagsLabel
{
    if (!_tagsLabel) {
        _tagsLabel = [UILabel new];
        [self.contentView addSubview:_tagsLabel];
        _tagsLabel.frame = CGRectMake(0, 0,self.bounds.size.width, self.bounds.size.height);
        _tagsLabel.textColor = [UIColor blackColor];
        _tagsLabel.font = [UIFont systemFontOfSize:14];
        _tagsLabel.backgroundColor = [UIColor whiteColor];
        _tagsLabel.textAlignment =NSTextAlignmentCenter;
        _tagsLabel.layer.cornerRadius = 4;
        _tagsLabel.layer.masksToBounds = YES;
        _tagsLabel.layer.borderWidth = 1;
        _tagsLabel.layer.borderColor = [UIColor colorWithWhite:0.93 alpha:1].CGColor;
    }
    return _tagsLabel;
}
@end
