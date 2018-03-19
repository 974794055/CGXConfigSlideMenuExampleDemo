//
//  ViewController.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/19.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "ViewController.h"


#import "CGXSlideTitleManage.h"


#import "CGXMyMenuViewController.h"

#import "CGXSlideChannelModel.h"
#import "CGXSlideChannelControll.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource> {
    UITableView *_tableView;
}

@property (nonatomic , strong) CGXSlideTitleManage *titleManage;

@property (nonatomic , strong) NSMutableArray *dataArray;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets =NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    
    
//    NSMutableArray *arr1 = [[NSMutableArray alloc] initWithObjects:@"要闻",@"河北",@"财经",@"娱乐",@"体育",@"社会",@"NBA",@"视频",@"汽车",@"图片",@"科技",@"军事",@"国际",@"数码",@"星座",@"电影",@"时尚",@"文化",@"游戏",@"教育",@"动漫",@"政务",@"纪录片",@"房产",@"佛学",@"股票",@"理财", nil];
//    NSMutableArray *itemArr1 = [NSMutableArray new];
//    for (NSString *str in arr1) {
//        CGXSlideChannelModel *item = [CGXSlideChannelModel new];
//        item.title = str;
//        [itemArr1 addObject:item];
//    }
//
//    NSMutableArray *arr2 = [[NSMutableArray alloc] initWithObjects:@"有声",@"家居",@"电竞",@"美容",@"电视剧",@"搏击",@"健康",@"摄影",@"生活",@"旅游",@"韩流",@"探索",@"综艺",@"美食",@"育儿", nil];
//    NSMutableArray *itemArr2 = [NSMutableArray new];
//    for (NSString *str in arr2) {
//        CGXSlideChannelModel *item = [CGXSlideChannelModel new];
//        item.title = str;
//        [itemArr2 addObject:item];
//    }
//    [CGXSlideChannelControll shareControl].inUseItems = itemArr1;
//    [CGXSlideChannelControll shareControl].unUsesItems = itemArr2;
    
    
}

#pragma mark -
#pragma mark TableViewDelegate&DataSource

- (NSArray *)titles {
    return @[@"Segment标签，在导航条上",@"Segment标签，在view上",@"collectionView标签，下划线,在导航条上",@"collectionView标签，下划线,在view 上",@"collectionView标签，指示器,在导航条上",@"collectionView标签，指示器,,在view 上",@"collectionView标签，放大效果,在导航条上",@"collectionView标签，放大效果,在导航条上",@"collectionView标签，背景颜色,在导航条上",@"collectionView标签，背景颜色,在导航条上",@"CGXMyMenuViewController"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* cellIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.detailTextLabel.textColor = self.navigationController.navigationBar.tintColor;
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSMutableArray *titleAry =[ NSMutableArray array];
    //要显示的标题
    if (indexPath.row<4) {
        titleAry = @[@"今天",@"好子",@"心想"];
    } else if (indexPath.row==10){
        for (CGXSlideChannelModel *model in [CGXSlideChannelControll shareControl].inUseItems) {
            [titleAry addObject:model.title];
        }

    }
    else{
        titleAry = [NSMutableArray arrayWithObjects:@"推荐",@"热点",@"科技",@"体育",@"视频",@"要闻",@"时政",@"美女",@"搞笑",@"娱乐", nil];
    }

    if (indexPath.row==0) {
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationNode];
                    _titleManage.showStyle = CGXSlideTitleManageShowNavSegment;
        _titleManage.itemLevelSpace = 230;
    }else if (indexPath.row ==1){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationNode];
        _titleManage.showStyle = CGXSlideTitleManageShowSegment;
        _titleManage.itemLevelSpace = 100;
    }else if (indexPath.row ==2){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationNode];
        _titleManage.showStyle = CGXSlideTitleManageShowNavNode;
        _titleManage.itemLevelSpace = 200;
    }else if (indexPath.row ==3){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationNode];
        _titleManage.showStyle = CGXSlideTitleManageShowNode;
    }else if (indexPath.row ==4){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationIndicator];
        _titleManage.showStyle = CGXSlideTitleManageShowNavNode;
        _titleManage.itemLevelSpace = 200;
    }else if (indexPath.row ==5){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationIndicator];
        _titleManage.showStyle = CGXSlideTitleManageShowNode;
    }else if (indexPath.row ==6){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationMaxScale];
        _titleManage.showStyle = CGXSlideTitleManageShowNavNode;
        _titleManage.itemLevelSpace = 200;
    }else if (indexPath.row ==7){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationMaxScale];
        _titleManage.showStyle = CGXSlideTitleManageShowNode;
    }else if (indexPath.row ==8){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationBGColor];
        _titleManage.showStyle = CGXSlideTitleManageShowNavNode;
        _titleManage.itemLevelSpace = 200;
    }else if (indexPath.row ==9){
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationBGColor];
        _titleManage.showStyle = CGXSlideTitleManageShowNode;
    }else{
        _titleManage = [[CGXSlideTitleManage alloc] initWithType:CGXSlideTitleManageAnimationNode];
        _titleManage.islineWidthSame = NO;
//        _titleManage.dropDownStyle = CGXSlideTitleManageDropDownEdit;
        
    }
    
    _titleManage.titlesAry = titleAry;
    //        _titleManage.isSlideAnimation = NO;
    NSMutableArray *vcAry = [NSMutableArray array];
    for (int i = 0; i<titleAry.count; i++) {
        UIViewController *VC = [UIViewController new];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
        label.center = self.view.center;
        label.text = [NSString stringWithFormat:@"%d",i];
        [VC.view addSubview:label];
        VC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1];
        [vcAry addObject:VC];
    }
    _titleManage.vcAry = [NSMutableArray arrayWithArray:vcAry];
    
            CGXMyMenuViewController *vc = [CGXMyMenuViewController new];
            vc.titleManage = self.titleManage;
            [self.navigationController pushViewController:vc animated:true];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
