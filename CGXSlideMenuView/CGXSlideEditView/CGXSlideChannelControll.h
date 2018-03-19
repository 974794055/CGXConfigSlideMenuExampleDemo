//
//  CGXScrollMenuChannelControll.h
//  CGXMenu
//
//  Created by 曹贵鑫 on 2017/6/23.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef void(^ChannelBlock)(NSArray *channels);

typedef void(^VoidBlock)(void);

@interface CGXSlideChannelControll : NSObject


+(CGXSlideChannelControll *)shareControl;
/**
 正在使用的栏目
 */
@property (strong,nonatomic) NSMutableArray *inUseItems;

/**
 可选择的栏目
 */
@property (strong,nonatomic) NSMutableArray *unUsesItems;


/**
 正在使用的控制器
 */
@property (strong,nonatomic) NSMutableArray *inUseVcItems;

/**
 显示方法 结束时返回的是正在使用中的频道集合
 */
-(void)showInViewController:(UIViewController*)vc completion:(ChannelBlock)channels;

@end
