//
//  CGXScrollMenuChannelChooseViewCell.m
//  CGXAppStructure
//
//  Created by 曹贵鑫 on 2017/6/27.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideChannelCell.h"

@implementation CGXSlideChannelCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        
        

    }
    return self;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,  self.bounds.size.height)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _titleLabel.layer.borderWidth = 1;
        _titleLabel.layer.cornerRadius = 4;
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (UIImageView *)cancelImageview
{
    if (!_cancelImageview) {
        _cancelImageview = [UIImageView new];
        _cancelImageview.image =  [UIImage imageNamed:[self imageFilePath:@"CGXConfigSlideMenuDelect"]];
        [self.contentView addSubview:_cancelImageview];
        [self.contentView bringSubviewToFront:_cancelImageview];
        _cancelImageview.frame = CGRectMake(self.bounds.size.width-20, 0, 20, 20);
    }
    return _cancelImageview;
}
- (NSString *)imageFilePath:(NSString *)name
{
    NSString *strResourcesBundle = [[NSBundle mainBundle] pathForResource:@"CGXConfigSlideMenuExample" ofType:@"bundle"];
    NSString *filePath = [[NSBundle bundleWithPath:strResourcesBundle]
                          pathForResource:name ofType:@"png"];
    
    return filePath;
}

//- (void)setCellType:(CGXScrollMenuChannelChooseViewCellStyle)cellType
//{
//    _cellType = cellType;
//    switch (_cellType) {
//        case CGXScrollMenuChannelChooseViewCellNode:
//        {
//            self.cancelImageview.hidden = YES;
//        }
//        case CGXScrollMenuChannelChooseViewCellCancel:
//        {
//            self.cancelImageview.hidden = NO;
//        }
//        default:
//            break;
//    }
//}

@end
