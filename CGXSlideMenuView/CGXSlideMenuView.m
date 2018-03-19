//
//  CGXSlideMenuView.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/21.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideMenuView.h"
#import "CGXSlideShowView.h"

#import "CGXSlideChannelModel.h"
#import "CGXSlideChannelControll.h"
#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTopHeight (kStatusBarHeight + kNavBarHeight)



@interface CGXSlideMenuView ()<UIGestureRecognizerDelegate,CGXSlideShowViewDelegate>
{
    UIView *sortAlphaView;
    CGXSlideShowView *showView;
    
   
}
@property (nonatomic , strong) UIButton *rightBtn;

@end
@implementation CGXSlideMenuView


- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager
{
    self = [super initWithFrame:frame];
    if (self) {
        self.manager = manager;
    }
    return self;
}
- (NSString *)imageFilePath:(NSString *)name
{
    NSString *bundlePath  =  [[NSBundle mainBundle] pathForResource:@"CGXConfigSlideMenuExample" ofType:@"bundle"];
    NSString *filePath = [[NSBundle bundleWithPath:bundlePath] pathForResource:@"CGXConfigSlideMenuArrowBottom" ofType:@"png"];
    return filePath;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.bounds.size.width-self.manager.itemHieght, 0, self.manager.itemHieght, self.manager.itemHieght);
        _rightBtn.selected = NO;
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.manager.itemHieght)];
        lineLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
        [_rightBtn addSubview:lineLabel];
        [_rightBtn addTarget:self action:@selector(slideMenuViewClickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_rightBtn];
    }
    return _rightBtn;
}
- (void)slideMenuViewClickBtn:(UIButton *)sender
{
    if (self.manager.dropDownStyle == CGXSlideTitleManageDropDownNode) {
    }else if (self.manager.dropDownStyle== CGXSlideTitleManageDropDownEdit){
      

        [[CGXSlideChannelControll shareControl] showInViewController:[self viewController:self] completion:^(NSArray *channels) {
            NSLog(@"频道管理结束：%@",channels);
            
//            for (CGXSlideChannelModel *title in channels) {
//                NSLog(@"全球 %@" , title.title);
//            }
        }];
        
    } else if (self.manager.dropDownStyle == CGXSlideTitleManageDropDownShow){


    
    showView = [[CGXSlideShowView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    showView.delegate = self;
    showView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    showView.dataArray = self.manager.titlesAry;
    showView.tag = 10001;
    showView.collectTop =self.manager.itemHieght+kTopHeight;
    
    
    showView.currentIndex = self.manager.selectedIndex;
//    [UIView animateWithDuration:0.5 animations:^{
//       showView.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:showView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromSuperviewListSortClicked)];
    tap.delegate = self;
    [showView addGestureRecognizer:tap];
    
    }

//    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view.tag == 10000 || touch.view.tag == 10001) {
        return YES;
    }else{
        return NO;
    }
}

- (void)removeFromSuperviewListSortClicked
{
    [showView removeFromSuperview];
}
- (void)selectCGXSlideShowViewItem:(NSInteger)inter
{
     [self slideCGXSlideMenuViewDidSelectedAtIndex:inter];
    
    [self removeFromSuperviewListSortClicked]; ;
}

- (CGXSlideTitleView *)titleView
{
    if (!_titleView) {
        
        CGFloat rightW =self.manager.itemHieght;;
        if (self.manager.dropDownStyle == CGXSlideTitleManageDropDownNode) {
            rightW = 0;
        }
        _titleView = [[CGXSlideTitleView alloc] initWithFrame:CGRectMake(self.manager.itemLevelSpace/2, 0, self.bounds.size.width-self.manager.itemLevelSpace-rightW,  self.manager.itemHieght) WithManager:self.manager];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.delegate = self;
    }
    return _titleView;
}
- (CGXSlideSegmentTitleView *)segMentTitltView
{
    if (!_segMentTitltView) {
        _segMentTitltView = [[CGXSlideSegmentTitleView alloc] initWithFrame:CGRectMake(self.manager.itemLevelSpace/2, self.manager.itemTopBottomSpace, self.bounds.size.width-self.manager.itemLevelSpace,  self.manager.itemHieght-self.manager.itemTopBottomSpace*2) WithManager:self.manager];
        _segMentTitltView.delegate = self;
    }
    return _segMentTitltView;
}
- (void)setManager:(CGXSlideTitleManage *)manager
{
    _manager = manager;
    [self.titleView.collectionView reloadData];
}
- (void)showInViewController:(UIViewController *)viewController {
    if (self.manager.dropDownStyle == CGXSlideTitleManageDropDownNode) {
    }else if (self.manager.dropDownStyle== CGXSlideTitleManageDropDownEdit){
        NSString *filePath = [self imageFilePath:@"CGXConfigSlideMenuEdit"];
        UIImage *imgM = [UIImage imageWithContentsOfFile:filePath];
        [self.rightBtn setImage:imgM forState:UIControlStateNormal];
    }
    else{
        NSString *filePath = [self imageFilePath:@"CGXConfigSlideMenuArrowBottom"];
        UIImage *imgM = [UIImage imageWithContentsOfFile:filePath];
        [self.rightBtn setImage:imgM forState:UIControlStateNormal];
        
    }
    CGFloat menuY = 0;
    switch (self.manager.showStyle) {
        case CGXSlideTitleManageShowNode:
        {
            [self addSubview:self.titleView];
            menuY = self.manager.itemHieght;
        }
            break;
        case CGXSlideTitleManageShowSegment:
        {

            [self addSubview:self.segMentTitltView];
            menuY = self.manager.itemHieght;
        }
            break;
        case CGXSlideTitleManageShowNavNode:
        {
                [viewController.navigationController.topViewController.view addSubview:self];
            viewController.navigationController.topViewController.navigationItem.titleView = self.titleView;
        }
            break;
            case CGXSlideTitleManageShowNavSegment:
        {
                [viewController.navigationController.topViewController.view addSubview:self];
             viewController.navigationController.topViewController.navigationItem.titleView = self.segMentTitltView;
        }
            break;
            
        default:
            break;
    }
    self.menuView = [[CGXSlideContentCollectionView alloc] initWithFrame:CGRectMake(0, menuY, self.bounds.size.width, self.bounds.size.height-menuY) WithManager:self.manager];
    self.menuView.delegate = self;
    [self addSubview:self.menuView];
}
- (void)slideCGXSlideTitleViewDidSelectedAtIndex:(NSInteger)index
{
    [self.menuView selectCGXSlideContentCollectionViewPage:index];
        self.manager.selectedIndex = index;
}
- (void)slideCGXSegmentTitleViewDidSelectedAtIndex:(NSInteger)index
{
    [self.menuView selectCGXSlideContentCollectionViewPage:index];
        self.manager.selectedIndex = index;
}
- (void)slideCGXSlideContentCollectionViewDidSelectedAtIndex:(NSInteger)index
{
    switch (self.manager.showStyle) {
        case CGXSlideTitleManageShowNode:
        {
            [self.titleView selectCGXSlideTitleViewPage:index];
        }
            break;
        case CGXSlideTitleManageShowSegment:
        {
            [self.segMentTitltView selectCGXSegmentTitleViewPage:index];
        }
            break;
            case CGXSlideTitleManageShowNavNode:
        {
             [self.titleView selectCGXSlideTitleViewPage:index];
        }
            break;
            case CGXSlideTitleManageShowNavSegment:
        {
            [self.segMentTitltView selectCGXSegmentTitleViewPage:index];
        }
            break;
        default:
            break;
    }
        self.manager.selectedIndex = index;
}
- (void)slideCGXSlideMenuViewDidSelectedAtIndex:(NSInteger)index
{
    [self slideCGXSegmentTitleViewDidSelectedAtIndex:index];
    [self slideCGXSlideContentCollectionViewDidSelectedAtIndex:index];
}
- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
