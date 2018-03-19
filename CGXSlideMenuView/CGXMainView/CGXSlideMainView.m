//
//  CGXSlideMainView.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/20.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideMainView.h"

@interface CGXSlideMainView ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property(nonatomic,strong) UIPageViewController *pageVC;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CGXSlideMainView

- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectedIndex = self.manager.selectedIndex;
        self.manager = manager;

    }
    return self;
}
- (void)setManager:(CGXSlideTitleManage *)manager
{
    _manager = manager;
    // 要显示的第几页
    NSArray *vcs = [NSArray arrayWithObject:manager.vcAry[self.selectedIndex]];
    // 如果要同时显示两页，options参数要设置为UIPageViewControllerSpineLocationMid
    //        NSArray *vcs = [NSArray arrayWithObjects:self.viewControllers[0], self.viewControllers[1], nil];

    [self.pageVC setViewControllers:vcs direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}
- (UIPageViewController *)pageVC
{
    if (!_pageVC) {
        /*
         UIPageViewControllerSpineLocationNone = 0, // 默认UIPageViewControllerSpineLocationMin
         UIPageViewControllerSpineLocationMin = 1,  // 书棱在左边
         UIPageViewControllerSpineLocationMid = 2,  // 书棱在中间，同时显示两页
         UIPageViewControllerSpineLocationMax = 3   // 书棱在右边
         */
        
        // 设置UIPageViewController的配置项
        NSDictionary *options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:UIPageViewControllerSpineLocationNone] forKey:UIPageViewControllerOptionSpineLocationKey];
        
        /*
         UIPageViewControllerNavigationOrientationHorizontal = 0, 水平翻页
         UIPageViewControllerNavigationOrientationVertical = 1    垂直翻页
         */
        /*
         UIPageViewControllerTransitionStylePageCurl = 0, // 书本效果
         UIPageViewControllerTransitionStyleScroll = 1 // Scroll效果
         */
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:options];
        
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        _pageVC.view.frame = self.bounds;
        
        [[self viewController:self] addChildViewController:self.pageVC];
        [self addSubview:self.pageVC.view];
    }
    return _pageVC;
}
// 根据数组元素，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewControlller {
    return [self.manager.vcAry indexOfObject:viewControlller];
}

#pragma mark - UIPageViewControllerDataSource
// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.manager.vcAry count]) {
        return nil;
    }
    return self.manager.vcAry[index];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    return self.manager.vcAry[index];
}

#pragma mark - UIPageViewControllerDelegate

// 开始翻页调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0) {
    NSLog(@"开始翻页");
}

// 翻页完成调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    _selectedIndex = [self.manager.vcAry indexOfObject:pageViewController.viewControllers.firstObject];
    NSLog(@"RselectedIndex  %ld",_selectedIndex);
    if ([_delegate respondsToSelector:@selector(slideCGXSlideMainViewDidSelectedAtIndex:)]) {
        [_delegate slideCGXSlideMainViewDidSelectedAtIndex:_selectedIndex];
    }
}
//选中某个页面
- (void)selectCGXSlideMainViewPage:(NSInteger)index
{
    [_pageVC setViewControllers:@[self.manager.vcAry[index]] direction:index<_selectedIndex animated:YES completion:^(BOOL finished) {
        _selectedIndex = index;
    }];
}



//- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation __TVOS_PROHIBITED {
//
//}

//- (UIInterfaceOrientationMask)pageViewControllerSupportedInterfaceOrientations:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
//    return UIInterfaceOrientationMaskPortraitUpsideDown;
//}

- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}


@end
