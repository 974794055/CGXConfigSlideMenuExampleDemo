//
//  CGXSlideTitleView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/19.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXSlideTitleManage.h"

@protocol CGXSlideTitleViewDelegate;

@protocol CGXSlideTitleViewDelegate <NSObject>
@optional
- (void)slideCGXSlideTitleViewDidSelectedAtIndex:(NSInteger)index;

@end

@interface CGXSlideTitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager;

@property (nonatomic , strong) CGXSlideTitleManage *manager;//配置

@property (nonatomic , strong)  UICollectionView *collectionView;

@property (nonatomic, weak) id<CGXSlideTitleViewDelegate>delegate;

//选中某个页面
- (void)selectCGXSlideTitleViewPage:(NSInteger)index;


@end
