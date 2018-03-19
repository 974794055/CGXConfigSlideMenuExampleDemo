//
//  CGXSlideMenuView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/21.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXSlideTitleManage.h"

#import "CGXSlideMenuView.h"
#import "CGXSlideTitleView.h"
#import "CGXSlideTitleManage.h"
#import <objc/runtime.h>

#import "CGXSlideContentCollectionView.h"
#import "CGXSlideSegmentTitleView.h"
#import "CGXSlideShowView.h"

@protocol CGXSlideMenuViewDelegate;
@protocol CGXSlideMenuViewDelegate <NSObject>
@optional
//点击了那个cell
- (void)selectCGXSlideMenuViewShowViewInder:(NSInteger)inter;

@end

@interface CGXSlideMenuView : UIView<CGXSlideTitleViewDelegate,CGXSlideContentCollectionViewDelegate,CGXSlideSegmentTitleViewDelegate>

@property(nonatomic,weak)id <CGXSlideMenuViewDelegate>delegate;

@property (nonatomic , strong) CGXSlideTitleView *titleView;
@property (nonatomic , strong) CGXSlideContentCollectionView *menuView;
@property (nonatomic , strong) CGXSlideSegmentTitleView *segMentTitltView;

- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager;

@property (nonatomic , strong) CGXSlideTitleManage *manager;//配置

//选择的按钮
- (void)slideCGXSlideMenuViewDidSelectedAtIndex:(NSInteger)index;

//设置标签显示位置
- (void)showInViewController:(UIViewController *)viewController;

@end
