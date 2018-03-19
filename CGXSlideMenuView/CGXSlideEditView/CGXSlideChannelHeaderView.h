//
//  CGXSlideChannelHeaderView.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2018/3/16.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CGXSlideChannelHeaderViewEditBlock)(BOOL isChoose);
@interface CGXSlideChannelHeaderView : UICollectionReusableView


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
/** 编辑按钮 */
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic,copy) CGXSlideChannelHeaderViewEditBlock editBlock;
@end
