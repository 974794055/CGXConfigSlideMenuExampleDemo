//
//  CGXMyMenuViewController.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2018/3/14.
//  Copyright © 2018年 曹贵鑫. All rights reserved.
//

#import "CGXMyMenuViewController.h"
#import "CGXSlideMenuView.h"
#import "CGXSlideTitleView.h"

#import <objc/runtime.h>

#import "CGXSlideContentCollectionView.h"
@interface CGXMyMenuViewController ()<CGXSlideTitleViewDelegate,CGXSlideContentCollectionViewDelegate,CGXSlideMenuViewDelegate>
{
    CGXSlideTitleView *titleView;
    CGXSlideContentCollectionView *menuView;
    
    CGXSlideMenuView *myMenuView;
     NSInteger inter;
}

@end

@implementation CGXMyMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    myMenuView = [[CGXSlideMenuView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-49) WithManager:self.titleManage];
    myMenuView.delegate = self;
    [myMenuView showInViewController:self];
    [self.view addSubview:myMenuView];
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain target:self action:@selector(onClickedOKbtn)];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
}
- (void)onClickedOKbtn
{
    [myMenuView slideCGXSlideMenuViewDidSelectedAtIndex:3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
