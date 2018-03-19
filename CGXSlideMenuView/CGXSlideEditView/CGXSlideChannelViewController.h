//
//  CGXScrollMenuChannelChooseViewController.h
//  CGXAppStructure
//
//  Created by 曹贵鑫 on 2017/6/28.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXSlideChannelControll.h"
@interface CGXSlideChannelViewController : UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

//UICollectionView
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic , strong) NSMutableArray *dataCollectionArray;

@property (nonatomic , strong) NSMutableArray *inUseItems;//正在使用
@property (nonatomic , strong) NSMutableArray *unUsesItems;//未使用


@property (nonatomic, strong) NSMutableArray *cellAttributesArray;//存放拖拽排放的数字


@property (nonatomic , assign) BOOL isChooseMenu;

-(void)addBackBlock:(VoidBlock)block;
-(void)backMethod;
@end
