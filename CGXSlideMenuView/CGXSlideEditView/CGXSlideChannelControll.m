//
//  CGXScrollMenuChannelControll.m
//  CGXMenu
//
//  Created by 曹贵鑫 on 2017/6/23.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideChannelControll.h"

#define MenuItemsDic [NSString pathWithComponents:@[NSHomeDirectory(), @"/Documents/MenuItems"]]
#define InUseItemsPath [NSString pathWithComponents:@[NSHomeDirectory(), @"/Documents/MenuItems/InUsesItems.plist"]]
#define UnUseItemsPath [NSString pathWithComponents:@[NSHomeDirectory(), @"/Documents/MenuItems/UnUsesItems.plist"]]


#import "CGXSlideChannelViewController.h"

@implementation CGXSlideChannelControll

+(CGXSlideChannelControll *)shareControl
{
    static CGXSlideChannelControll *control = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        control = [CGXSlideChannelControll new];
    });
    return control;
}

-(instancetype)init
{
    if (self = [super init]) {
        [self initSavePath];
    }
    return self;
}

-(void)initSavePath
{
    //初始化本文件夹
    if (![[NSFileManager defaultManager] fileExistsAtPath:InUseItemsPath]){
        [[NSFileManager defaultManager] createDirectoryAtPath:MenuItemsDic withIntermediateDirectories:true attributes:nil error:nil];
        NSData* data1 = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]];
        NSData* data2 = [NSKeyedArchiver archivedDataWithRootObject:[NSMutableArray new]];
        [data1 writeToFile:InUseItemsPath atomically:YES];
        [data2 writeToFile:UnUseItemsPath atomically:YES];
    }
//    NSLog(@"本地菜单地址是：%@",InUseItemsPath);
}
#pragma mark -
#pragma mark set/get 方法

-(void)setInUseItems:(NSMutableArray *)inUseItems
{
    [[NSKeyedArchiver archivedDataWithRootObject:inUseItems] writeToFile:InUseItemsPath atomically:YES];
}
-(void)setUnUseItems:(NSMutableArray *)unUseItems
{
    [[NSKeyedArchiver archivedDataWithRootObject:unUseItems] writeToFile:UnUseItemsPath atomically:YES];
}

-(NSMutableArray *)inUseItems
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:InUseItemsPath];
}
-(NSMutableArray *)unUseItems
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:UnUseItemsPath];
}

#pragma mark -
#pragma mark 显示方法

-(void)showInViewController:(UIViewController*)vc completion:(ChannelBlock)channels
{
    CGXSlideChannelViewController *channelVC = [CGXSlideChannelViewController new];
    [channelVC addBackBlock:^{
        if (channels){
            channels([CGXSlideChannelControll shareControl].inUseItems);
        }
    }];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:channelVC];
    [vc presentViewController:nav animated:true completion:nil];
}


@end
