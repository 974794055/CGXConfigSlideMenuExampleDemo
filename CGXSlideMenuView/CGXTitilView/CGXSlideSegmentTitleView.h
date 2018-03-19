//
//  CGXSegmentTitleView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/21.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXSlideTitleManage.h"

//开始回答代理
@protocol CGXSlideSegmentTitleViewDelegate;

@protocol CGXSlideSegmentTitleViewDelegate <NSObject>
@optional
- (void)slideCGXSegmentTitleViewDidSelectedAtIndex:(NSInteger)index;

@end


@interface CGXSlideSegmentTitleView : UIView

- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager;

@property (nonatomic , strong) CGXSlideTitleManage *manager;//配置

@property (nonatomic, weak) id<CGXSlideSegmentTitleViewDelegate>delegate;


//选中某个页面
- (void)selectCGXSegmentTitleViewPage:(NSInteger)index;

@end
