//
//  CGXSlideContentCollectionView.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/21.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideContentCollectionView.h"

@interface CGXSlideContentCollectionView () <UICollectionViewDataSource, UICollectionViewDelegate>
//选中的
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation CGXSlideContentCollectionView

- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.manager = manager;

   
        // 2、添加UICollectionView, 用于在Cell中存放控制器的View
        [self addSubview:self.collectionView];
        
        self.selectedIndex = self.manager.selectedIndex;

        [self.collectionView reloadData];
        

    }
    return self;
}

- (void)setManager:(CGXSlideTitleManage *)manager
{
    _manager = manager;
    
}
#pragma mark -
#pragma mark Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;

    //居中滚动标题
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:self.manager.isSlideAnimation];
    
    //执行代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideCGXSlideContentCollectionViewDidSelectedAtIndex:)]) {
        [self.delegate slideCGXSlideContentCollectionViewDidSelectedAtIndex:_selectedIndex];
    }
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.bounds.size;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}

#pragma mark CollectionViewDelegate

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.manager.vcAry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];

    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // 设置内容
    UIViewController *childVC = self.manager.vcAry[indexPath.row];
    childVC.view.frame = cell.contentView.frame;
    [cell.contentView addSubview:childVC.view];
    return cell;
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
         NSInteger currentIndex = scrollView.contentOffset.x / self.frame.size.width;
        if (self.delegate && [self.delegate respondsToSelector:@selector(slideCGXSlideContentCollectionViewDidSelectedAtIndex:)]) {
            [self.delegate slideCGXSlideContentCollectionViewDidSelectedAtIndex:currentIndex];
        }
    }
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger currentIndex = scrollView.contentOffset.x / self.frame.size.width;
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideCGXSlideContentCollectionViewDidSelectedAtIndex:)]) {
        [self.delegate slideCGXSlideContentCollectionViewDidSelectedAtIndex:currentIndex];
    }
}
- (void)selectCGXSlideContentCollectionViewPage:(NSInteger)index
{
        [self.collectionView scrollRectToVisible:CGRectMake(index *self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:self.manager.isSlideAnimation];
}
- (void)interCGXSlideTitleViewWithManager:(CGXSlideTitleManage *)manager
{
    self.manager = manager;
    [self.collectionView reloadData];
}
- (void)delectCGXSlideTitleViewWithManager:(CGXSlideTitleManage *)manager
{
    self.manager = manager;
    [self.collectionView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
