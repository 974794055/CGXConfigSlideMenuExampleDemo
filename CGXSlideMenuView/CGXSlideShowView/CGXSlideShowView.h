//
//  CGXSlideShowView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2018/3/14.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGXSlideShowViewDelegate;
@protocol CGXSlideShowViewDelegate <NSObject>
@optional
//点击了那个cell
- (void)selectCGXSlideShowViewItem:(NSInteger)inter;

@end

@interface CGXSlideShowView : UIView

@property(nonatomic,weak)id <CGXSlideShowViewDelegate>delegate;

@property (nonatomic , strong) UICollectionView *collectionView;

@property (nonatomic , assign) CGFloat collectTop;

@property (nonatomic , strong) NSMutableArray *dataArray;

/**
 *  当前选中的index。可以设置当前的index
 */
@property (nonatomic, assign) NSInteger currentIndex;

@end


