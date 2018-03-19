//
//  CGXSlideTitleManage.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/20.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 文字动画效果
 **/
typedef NS_ENUM(NSInteger, CGXSlideTitleManageAnimationStyle) {
    CGXSlideTitleManageAnimationNode,  //默认没有效果  有下划线
    CGXSlideTitleManageAnimationMaxScale,  //放大效果
    CGXSlideTitleManageAnimationBGColor,//选择有背景色
    CGXSlideTitleManageAnimationIndicator,//选择指示器  有圆角
};

/**
 展示效果  默认展示在view上  默认展示在view上
 **/
typedef NS_ENUM(NSInteger, CGXSlideTitleManageShowStyle) {
    CGXSlideTitleManageShowNode,  //   UICollectionView标签。      在view上
    CGXSlideTitleManageShowSegment,  //    UISegmentedControl标签    在view上
    CGXSlideTitleManageShowNavNode,  //   UICollectionView标签。      在导航条上
    CGXSlideTitleManageShowNavSegment,  //    UISegmentedControl标签   在导航条上
};

/**
 UICollectionView标签时。  右侧按钮点击下拉展示或者防头条编辑下拉界面
 **/
typedef NS_ENUM(NSInteger, CGXSlideTitleManageDropDownStyle) {
    CGXSlideTitleManageDropDownNode,  //   默认没有下拉按钮
    CGXSlideTitleManageDropDownShow,  //    下拉展示按钮
    CGXSlideTitleManageDropDownEdit,  //   下拉编辑按钮按钮
};

@interface CGXSlideTitleManage : NSObject

/**
   初始化选择类型
 */
- (instancetype)initWithType:(CGXSlideTitleManageAnimationStyle)animationStyle;

/**
 展示方向
 **/
@property (nonatomic ,assign) CGXSlideTitleManageAnimationStyle animationStyle;
/**
 展示位置
 **/
@property (nonatomic ,assign) CGXSlideTitleManageShowStyle showStyle;
/**
 右侧下拉属性      代优化。   暂时不可使用
 **/
@property (nonatomic ,assign) CGXSlideTitleManageDropDownStyle dropDownStyle;

//标题数组
@property (nonatomic , strong) NSMutableArray *titlesAry;
//控制器数组
@property (nonatomic , strong) NSMutableArray *vcAry;
//默认颜色
@property (nonatomic, strong) UIColor *itemNormalColor;
//选中颜色
@property (nonatomic, strong) UIColor *itemSelectedColor;
//选中颜色
@property (nonatomic, strong) UIColor *normalBGColor;
//选中颜色
@property (nonatomic, strong) UIColor *selectedBGColor;
//标题大小
@property (nonatomic, assign) CGFloat itemFontSize;
//最大放大倍数
@property (nonatomic, assign) CGFloat itemMaxScale;
//标签间距
@property (nonatomic, assign) CGFloat spaceSize;
//标签左右间距  距离屏幕边缘
@property (nonatomic, assign) CGFloat itemLevelSpace;
//标签上下间距
@property (nonatomic, assign) CGFloat itemTopBottomSpace;
//标签间距
@property (nonatomic, assign) CGFloat bottomLineHeight;
//标签高度
@property (nonatomic, assign) CGFloat itemHieght;
//默认下划线的宽度和标签一致
@property (nonatomic, assign) BOOL islineWidthSame;
//默认显示有滑动动画
@property (nonatomic, assign) BOOL isSlideAnimation;
//默认选择的下表
@property (nonatomic, assign) NSInteger selectedIndex;

//默认颜色  UISegmentedControl  菜单栏参数设置
@property (nonatomic, strong) UIColor *tintColor;

@property (nonatomic , strong) UIColor *collectionViewBGColor;//collectionview背景颜色
@property (nonatomic , assign) BOOL showsVerticalScrollIndicator;//暂时水平 默认NO
@property (nonatomic , assign) BOOL showsHorizontalScrollIndicator;//暂时垂直 默认NO

@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic , assign) UIEdgeInsets insets;//默认是10

@end
