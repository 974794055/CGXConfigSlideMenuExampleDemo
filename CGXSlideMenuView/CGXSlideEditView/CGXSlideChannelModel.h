//
//  CGXScrollMenuChannerModel.h
//  CGXMenu
//
//  Created by 曹贵鑫 on 2017/6/23.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CGXSlideChannelModel : NSObject<NSCoding>

/**
 标题
 */
@property (strong,nonatomic) NSString *title;


@property (strong,nonatomic) NSDictionary *titleDic;
@property (assign,nonatomic) NSInteger tag;



@end
