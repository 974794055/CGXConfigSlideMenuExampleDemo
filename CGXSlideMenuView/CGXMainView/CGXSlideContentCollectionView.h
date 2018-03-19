//
//  CGXSlideContentCollectionView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/21.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXSlideTitleManage.h"

//开始回答代理
@protocol CGXSlideContentCollectionViewDelegate;

@protocol CGXSlideContentCollectionViewDelegate <NSObject>
@optional
- (void)slideCGXSlideContentCollectionViewDidSelectedAtIndex:(NSInteger)index;

@end

@interface CGXSlideContentCollectionView : UIView

- (instancetype)initWithFrame:(CGRect)frame  WithManager:(CGXSlideTitleManage *)manager;

@property (nonatomic , strong) CGXSlideTitleManage *manager;//配置
/// collectionView
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id<CGXSlideContentCollectionViewDelegate>delegate;

/** 给外界提供的方法，获取 CGXSlideContentCollectionView 选中按钮的下标 */
- (void)selectCGXSlideContentCollectionViewPage:(NSInteger)index;
- (void)interCGXSlideTitleViewWithManager:(CGXSlideTitleManage *)manager;
- (void)delectCGXSlideTitleViewWithManager:(CGXSlideTitleManage *)manager;
@end
