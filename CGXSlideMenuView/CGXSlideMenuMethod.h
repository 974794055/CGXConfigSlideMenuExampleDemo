//
//  CGXSlideMenuMethod.h
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/20.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CGXSlideMenuMethod : NSObject

#pragma mark -
#pragma mark 功能性方法
+ (UIColor *)transformFromColor:(UIColor*)fromColor toColor:(UIColor *)toColor progress:(CGFloat)progress;
// 文字宽度
+ (CGSize)itemTitleWidth:(NSString *)str FontOfSize:(CGFloat)fontSize;
@end
