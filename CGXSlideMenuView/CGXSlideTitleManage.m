//
//  CGXSlideTitleManage.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/20.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideTitleManage.h"

#define CGXSlideTitleManageWidth                 [UIScreen mainScreen].bounds.size.width
#define CGXSlideTitleManageHeight                [UIScreen mainScreen].bounds.size.height

#define CGXSlideTitleManageScaleHeight(A) A / (double)667 * CGXSlideTitleManageHeight
#define CGXSlideTitleManageScaleWidth(W)  W / (double)375 * CGXSlideTitleManageWidth


@implementation CGXSlideTitleManage

- (instancetype)initWithType:(CGXSlideTitleManageAnimationStyle)animationStyle
{
    if (self = [super init]) {
        self.animationStyle = animationStyle;

        
        _showStyle = CGXSlideTitleManageShowNode;
        _animationStyle = CGXSlideTitleManageAnimationNode;
        _dropDownStyle = CGXSlideTitleManageDropDownNode;
        
       _itemNormalColor = [UIColor blackColor];
       _itemSelectedColor = [UIColor redColor];
        _isSlideAnimation = NO;
        _islineWidthSame = YES;
        _collectionViewBGColor = [UIColor whiteColor];
        
        _showsVerticalScrollIndicator = NO;
        _showsHorizontalScrollIndicator = NO;
        _bottomLineHeight = 3;
        _minimumLineSpacing = 0;
        _minimumInteritemSpacing = 0;
        _insets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _itemFontSize = 16;
        _itemMaxScale = 1.3;
        _spaceSize = CGXSlideTitleManageScaleWidth(20);
        _itemHieght = CGXSlideTitleManageScaleHeight(40);
        _itemTopBottomSpace = CGXSlideTitleManageScaleHeight(5);
        _itemLevelSpace = 0;
        _selectedBGColor = [UIColor colorWithWhite:0.93 alpha:1];
        _normalBGColor = [UIColor whiteColor];
        
        _selectedIndex = 0;
        
        _tintColor = [UIColor colorWithRed:10/255.0 green:96/255.0 blue:254/255.0 alpha:1];
    }
    return self;
}



@end
