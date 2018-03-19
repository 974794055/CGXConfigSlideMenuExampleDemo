//
//  CGXSlideMainView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/20.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXSlideTitleManage.h"

//开始回答代理
@protocol CGXSlideMainViewDelegate;

@protocol CGXSlideMainViewDelegate <NSObject>
@optional
- (void)slideCGXSlideMainViewDidSelectedAtIndex:(NSInteger)index;

@end


@interface CGXSlideMainView : UIView


- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager;

@property (nonatomic , strong) CGXSlideTitleManage *manager;//配置

@property (nonatomic, weak) id<CGXSlideMainViewDelegate>delegate;

//选中某个页面
- (void)selectCGXSlideMainViewPage:(NSInteger)index;
@end
