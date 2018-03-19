//
//  CGXSlideTitleView.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/19.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideTitleView.h"
#import "CGXSlideTitleItemCell.h"
#import "CGXSlideMenuMethod.h"

@interface CGXSlideTitleView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic , strong) UIView *shadow;
@property (nonatomic , assign) CGFloat progress;
@property (nonatomic, assign) NSInteger clickIndex;//防止多次点击
@property (nonatomic, assign) NSInteger selectedIndex;//选中的下标


@end

@implementation CGXSlideTitleView


- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager
{
    self = [super initWithFrame:frame];
    if (self) {

        self.manager = manager;
        
        self.selectedIndex = manager.selectedIndex;
     [self selectItemIndex:self.selectedIndex];
        [self.collectionView reloadData];
    }
    return self;
}

- (UIView *)shadow
{
    if (!_shadow) {
        _shadow = [[UIView alloc] init];
        //设置阴影
         [self.collectionView addSubview:_shadow];
        _shadow.backgroundColor = self.manager.itemSelectedColor;
        //UIToolbar
        if (self.manager.animationStyle == CGXSlideTitleManageAnimationIndicator) {
            // 圆角处理
            self.shadow.layer.cornerRadius = (self.bounds.size.height- self.manager.spaceSize)/2;
            self.shadow.backgroundColor = [self.manager.itemSelectedColor colorWithAlphaComponent:0.3];
            // 边框宽度及边框颜色
            self.shadow.layer.borderWidth = 1;
            self.shadow.layer.borderColor = [UIColor yellowColor].CGColor;
        }
    }
    return _shadow;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        self.collectionView.showsVerticalScrollIndicator=NO;
        self.collectionView.showsHorizontalScrollIndicator=NO;
        self.collectionView.backgroundColor = self.manager.collectionViewBGColor;
        //注册cell
        [self.collectionView registerClass:[CGXSlideTitleItemCell class] forCellWithReuseIdentifier:@"CGXSlideTitleItemCell"];
        [self addSubview:self.collectionView];
        self.collectionView.bounces = NO;
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
    //如果标题过少 自动居中
    [self.collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        if (self.collectionView.contentSize.width < self.collectionView.bounds.size.width) {
            CGFloat insetX = (self.collectionView.bounds.size.width - self.collectionView.contentSize.width)/2.0f;
            self.collectionView.contentInset = UIEdgeInsetsMake(0, insetX, 0, insetX);
        }
    }];
    //设置阴影
    if (self.manager.animationStyle == CGXSlideTitleManageAnimationBGColor || self.manager.animationStyle == CGXSlideTitleManageAnimationMaxScale) {
        self.shadow.hidden = YES;
    } else{
        if (self.manager.showStyle == CGXSlideTitleManageShowSegment || self.manager.showStyle == CGXSlideTitleManageShowNavSegment) {
             self.shadow.hidden = YES;
        } else{
             self.shadow.hidden = NO;
        }
    }
}

#pragma mark CollectionViewDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.manager.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.manager.minimumInteritemSpacing;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.manager.insets;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.manager.titlesAry.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat titleWith = 0;
    for (NSString *str in self.manager.titlesAry) {
        CGSize textSize = [CGXSlideMenuMethod itemTitleWidth:str FontOfSize:self.manager.itemFontSize];
        CGFloat width = textSize.width+self.manager.spaceSize;
        titleWith += width;
    }
    
    if (titleWith <= self.frame.size.width) {
         return CGSizeMake(self.frame.size.width/self.manager.titlesAry.count, self.collectionView.bounds.size.height);
    }
    CGFloat titleW = [self itemWidthOfIndexPath:indexPath TitleAry:self.manager.titlesAry];
    return CGSizeMake(titleW, self.collectionView.bounds.size.height);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGXSlideTitleItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CGXSlideTitleItemCell" forIndexPath:indexPath];
    cell.textLabel.text = self.manager.titlesAry[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:self.manager.itemFontSize];
    
    cell.textLabel.textColor = indexPath.row == _selectedIndex ? self.manager.itemSelectedColor : self.manager.itemNormalColor;
    
    switch (self.manager.animationStyle) {
            case CGXSlideTitleManageAnimationNode:
        {
            
        }
            break;
            case CGXSlideTitleManageAnimationMaxScale:
        {
            CGFloat scale = indexPath.row == _selectedIndex ? self.manager.itemMaxScale : 1;
            cell.textLabel.transform = CGAffineTransformMakeScale(scale, scale);
        }
            break;
        case CGXSlideTitleManageAnimationBGColor:
        {
            cell.textLabel.backgroundColor =indexPath.row == _selectedIndex ? self.manager.selectedBGColor:self.manager.normalBGColor;
        }
            break;
        case CGXSlideTitleManageAnimationIndicator:
        {
        }
            break;
        default:
            break;
    }
    
    if (self.selectedIndex == indexPath.row) {
          [self progressIndex:self.selectedIndex];
        [self shadowIndex:self.selectedIndex];
    }
    
    
    return cell;
}
//获取文字宽度
- (CGFloat)itemWidthOfIndexPath:(NSIndexPath*)indexPath TitleAry:(NSMutableArray *)titleArray
{
    NSString *title = titleArray[indexPath.row];
    CGSize textSize = [CGXSlideMenuMethod itemTitleWidth:title FontOfSize:self.manager.itemFontSize];
    return textSize.width+self.manager.spaceSize;
}

- (CGFloat)itemHeightOfIndexPath:(NSIndexPath*)indexPath TitleAry:(NSMutableArray *)titleArray
{
    NSString *title = titleArray[indexPath.row];
    CGSize textSize = [CGXSlideMenuMethod itemTitleWidth:title FontOfSize:self.manager.itemFontSize];
    return textSize.height+5;
}

- (CGRect)shadowRectOfIndex:(NSInteger)index {
    CGFloat hSize = self.manager.bottomLineHeight;
    CGFloat ySize = self.bounds.size.height - self.manager.bottomLineHeight;
    CGFloat xSize = self.progress;
    CGFloat wSize = 0;
    CGFloat spaceSize = self.manager.spaceSize;

     CGFloat titleW = [self itemWidthOfIndexPath:[NSIndexPath indexPathForRow:index inSection:0] TitleAry:self.manager.titlesAry];
    CGFloat titleH =[self itemHeightOfIndexPath:[NSIndexPath indexPathForRow:index inSection:0] TitleAry:self.manager.titlesAry];

    CGFloat titleWith = 0;
    for (NSString *str in self.manager.titlesAry) {
        CGSize textSize = [CGXSlideMenuMethod itemTitleWidth:str FontOfSize:self.manager.itemFontSize];
        CGFloat width = textSize.width+self.manager.spaceSize;
        titleWith += width;
    }

    if (self.manager.islineWidthSame) {
        if (titleWith <= self.bounds.size.width) {
            wSize= self.bounds.size.width/self.manager.titlesAry.count;
        } else{
            wSize =titleW;
        }
    } else{
         xSize = xSize+spaceSize/2;
        if (titleWith <= self.bounds.size.width) {
            wSize = self.bounds.size.width/self.manager.titlesAry.count-spaceSize;
        } else{
            wSize =titleW-spaceSize;
        }
    }
    if (self.manager.animationStyle == CGXSlideTitleManageAnimationIndicator) {
        ySize = (self.bounds.size.height-titleH)/2;
        hSize = titleH;
    }
     return CGRectMake(xSize, ySize, wSize, hSize);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //防止标签多次点击
    if (self.clickIndex == indexPath.row) {
        return;
    }
    [self selectCGXSlideTitleViewPage:indexPath.row];
}
#pragma mark -
- (void)setManager:(CGXSlideTitleManage *)manager
{
    _manager = manager;
}

- (void)selectItemIndex:(NSInteger)selectedIndex
{
    _clickIndex =selectedIndex;
    
   self.selectedIndex = selectedIndex;
    
    [self progressIndex:selectedIndex];
    
    [self shadowIndex:selectedIndex];
    //居中滚动标题
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    //执行代理方法
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideCGXSlideTitleViewDidSelectedAtIndex:)]) {
        [self.delegate slideCGXSlideTitleViewDidSelectedAtIndex:selectedIndex];
    }
}
- (void)progressIndex:(NSInteger)selectedIndex
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:selectedIndex inSection:0];
    CGXSlideTitleItemCell *cell = (CGXSlideTitleItemCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect rect = cell.frame;
    if (!cell) {
        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
        rect = attributes.frame;
    }
    self.progress = rect.origin.x;
}
- (void)shadowIndex:(NSInteger)selectedIndex
{
    CGRect rectShadow = [self shadowRectOfIndex:selectedIndex];
    //更新阴影位置（延迟是为了避免cell不在屏幕上显示时，造成的获取frame失败问题）
    CGFloat rectX = rectShadow.origin.x;
    if (rectX < 0) {
        //  --- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.25 * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
            [UIView animateWithDuration:0.3 animations:^{
                self.shadow.frame = rectShadow;
            }];
        });
    }else{
        //更新位置
        [UIView animateWithDuration:0.3 animations:^{
            self.shadow.frame = rectShadow;
        }];
    }
}

//选中某个页面
- (void)selectCGXSlideTitleViewPage:(NSInteger)index
{

//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:selectedIndex inSection:0];
//    CGXSlideTitleItemCell *cell = (CGXSlideTitleItemCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//    CGRect rect = cell.frame;
//    if (!cell) {
//        UICollectionViewLayoutAttributes *attributes = [self.collectionView layoutAttributesForItemAtIndexPath:indexPath];
//        rect = attributes.frame;
//    }
//    self.progress = rect.origin.x;

    
    [self selectItemIndex:index];
    [self.collectionView reloadData];

}
@end
