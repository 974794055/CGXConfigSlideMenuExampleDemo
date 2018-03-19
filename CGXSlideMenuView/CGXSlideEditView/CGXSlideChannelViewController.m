//
//  CGXScrollMenuChannelChooseViewController.m
//  CGXAppStructure
//
//  Created by 曹贵鑫 on 2017/6/28.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideChannelViewController.h"

#import "UIView+CGXFrameAdjust.h"
#import "CGXSlideChannelCell.h"
#import "CGXSlideChannelModel.h"

#import "CGXSlideChannelHeaderView.h"

#define ScreenWidth                 [UIScreen mainScreen].bounds.size.width
#define ScreenHeight                [UIScreen mainScreen].bounds.size.height
#define ScaleHeight(A) A / (double)667 * ScreenHeight
#define ScaleWidth(W)  W / (double)375 * ScreenWidth

#define WeakSelf(self)   __weak typeof (self) weakSelf = self;

#define Font(x)  [UIFont   systemFontOfSize:x]


#define kScreenWidthRatio  (ScreenWidth / 375.0)
#define kScreenHeightRatio (ScreenHeight / 667.0)
#define AdaptedWidthValue(x)  (ceilf((x) * kScreenWidthRatio))
#define AdaptedHeightValue(x) (ceilf((x) * kScreenHeightRatio))

/**
 *  自定义文字大小
 */
//#define M                     screenHeight / 667
//#define N                     1
//#define SCALE(M,N)            M < N ? N : M
//#define Font(x)  [UIFont   systemFontOfSize:x - (SCALE(M,N))]


/**
 *  自动获取文字高度
 */
#define CGTitleSize(str,_rowlong_,font)     [str boundingRectWithSize:CGSizeMake(_rowlong_, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;



@interface CGXSlideChannelViewController ()
{
    VoidBlock _backBlock;
    
}

@property (nonatomic, assign) CGPoint lastPressPoint;
/**
 * scrollerTimer
 */
@property (nonatomic, strong) NSTimer *scrollerTimer;
@property (nonatomic, assign) CGFloat scrollerValue;
//@property (nonatomic, assign) BOOL isCanSort;//是否支持排序功能

//用于判断一、二分区是否有移动动画
@property (nonatomic, assign) BOOL isSorting;

@property (nonatomic, strong) CGXSlideChannelHeaderView *headerView;


@end

@implementation CGXSlideChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];

    _lastPressPoint = CGPointZero;
//    _isCanSort = YES;
    
    self.isChooseMenu = NO;
    [self reloadShowData];
    [self updateData];
    

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jian" style:UIBarButtonItemStylePlain target:self action:@selector(backMethod)];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
}

- (void)updateData
{
    [self.collectionView reloadData];
}

- (void)reloadShowData
{
    [self.dataCollectionArray removeAllObjects];
    self.inUseItems = [NSMutableArray arrayWithArray:[CGXSlideChannelControll shareControl].inUseItems];
    self.unUsesItems = [NSMutableArray arrayWithArray:[CGXSlideChannelControll shareControl].unUsesItems];
    
    [self.dataCollectionArray addObject:self.inUseItems];
    [self.dataCollectionArray addObject:self.unUsesItems];
}
- (NSMutableArray *)dataCollectionArray
{
    if (!_dataCollectionArray) {
        _dataCollectionArray = [NSMutableArray array];
    }
    return _dataCollectionArray;
}
- (NSMutableArray *)inUseItems
{
    if (!_inUseItems) {
        _inUseItems = [NSMutableArray array];
    }
    return _inUseItems;
}
- (NSMutableArray *)unUsesItems
{
    if (!_unUsesItems) {
        _unUsesItems = [NSMutableArray array];
    }
    return _unUsesItems;
}

#pragma mark - 创建
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) collectionViewLayout:flowLayout];
        _collectionView.allowsMultipleSelection = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        //注册cell
        [_collectionView registerClass:[CGXSlideChannelCell class] forCellWithReuseIdentifier:@"cell"];
        //给collectionView注册头分区的Id
        [_collectionView registerClass:[CGXSlideChannelHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
        //给collection注册脚分区的id
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

#pragma mark - 显示cell的分区方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CGXSlideChannelHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        if(view == nil){
            view = [[CGXSlideChannelHeaderView alloc] init];
        }
        if (indexPath.section == 0) {
             view.editBtn.hidden = NO;
            view.titleLabel.text = @"已选频道";
            view.detailLabel.text = @"按住拖动调整排序";
            view.editBtn.selected = NO;
            __weak typeof(self) weakSelf = self;
            view.editBlock = ^(BOOL isChoose) {
                

                    if (isChoose) {
                        weakSelf.isChooseMenu = YES;
                    } else{
                        weakSelf.isChooseMenu = NO;
                    }
                
                for (NSInteger inter = 0; inter<[self.dataCollectionArray[indexPath.section] count]; inter++) {
                    NSIndexPath *indexPathAA = [NSIndexPath indexPathForItem:inter inSection:0];
                    [self.collectionView reloadItemsAtIndexPaths:@[indexPathAA]];
                }
            };

        } else {
            view.editBtn.hidden = YES;
            view.titleLabel.text = @"频道推荐";
            view.detailLabel.text = @"点击添加频道";
        }
        self.headerView = view;
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
}
#pragma mark - 返回分区的行数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataCollectionArray.count;
}
#pragma mark - 返回每个分区的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataCollectionArray[section] count];
}
#pragma mark UICollectionView Delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.view.width, 40);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(self.view.width, 0);
}
#pragma mark - 定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((ScreenWidth - 13 * 5) / 4, 40);
}
#pragma mark - 定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(13, 12, 13, 12);
}

#pragma mark - cell的显示处理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGXSlideChannelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableArray *arr = self.dataCollectionArray[indexPath.section];
    CGXSlideChannelModel *model = arr[indexPath.row];

    NSString *titleStr = model.title;
    
    cell.titleLabel.text = titleStr;
    
    switch (indexPath.section) {
        case 1:
        {
            cell.titleLabel.backgroundColor = [UIColor whiteColor];
            cell.cancelImageview.hidden = YES;
        }
            break;
        case 0:
        {
            
            if (self.isChooseMenu) {
                cell.cancelImageview.hidden = NO;
            }else{
                cell.cancelImageview.hidden  =YES;
            }
            
            if (self.inUseItems.count < 3) {
                cell.titleLabel.backgroundColor = [UIColor lightGrayColor];
            }else{
                cell.titleLabel.backgroundColor = [UIColor whiteColor];
            }
        }
            break;

        default:
            break;
    }


    
    for (UIGestureRecognizer *gesture in cell.gestureRecognizers) {
        if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [cell removeGestureRecognizer:gesture];
        }
    }
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGesture:)];
    [cell addGestureRecognizer:longPress];
    
    return cell;
}

#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击第-%d-分区第-%d-个cell",indexPath.section,indexPath.row);
//        CGXScrollMenuChannelChooseViewCell *cell = (CGXScrollMenuChannelChooseViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    NSMutableArray *arr = self.dataCollectionArray[indexPath.section];
    CGXSlideChannelModel *model = arr[indexPath.row];
    
    
     if (self.isChooseMenu) {
         switch (indexPath.section) {
             case 0:
             {
                 if (self.inUseItems.count < 2) {
                     NSLog(@"保留一个");
                     return;
                 }
                 [self.inUseItems removeObject:model];
                 [self.unUsesItems insertObject:model atIndex:0];
             }
                 break;
             case 1:
             {
                 [self.inUseItems addObject:model];
                 [self.unUsesItems removeObject:model];
             }
                 break;
             default:
                 break;
         }
         [self updateData];
         [self saveData];
         /** 点击 cell 后取消选中 */
         [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
     } else{
         
     }

}

- (NSMutableArray *)cellAttributesArray{
    if (!_cellAttributesArray) {
        self.cellAttributesArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _cellAttributesArray;
}
//长按拖动排序
- (void)longPressGesture:(UILongPressGestureRecognizer *)sender{
//    if (!_isCanSort) {
//        return;
//    }
    CGXSlideChannelCell *cell = (CGXSlideChannelCell *)sender.view;
    [self.collectionView bringSubviewToFront:cell];
    NSIndexPath *cellIndexPath = [self.collectionView indexPathForCell:cell];
    [self.collectionView bringSubviewToFront:cell];
    BOOL isChanged = NO;
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.lastPressPoint = [sender locationInView:self.collectionView];
    }else if (sender.state == UIGestureRecognizerStateChanged){
        [self.cellAttributesArray removeAllObjects];
        for (int i = 0;i < self.inUseItems.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
        }
        for (int i = 0;i < self.unUsesItems.count; i++) {
            [self.cellAttributesArray addObject:[self.collectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:1]]];
        }
        
        [self scrollerCollectionView:[sender locationInView:self.view]];
        cell.center = [sender locationInView:self.collectionView];
        
        for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
            if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexPath != attributes.indexPath) {
                isChanged = YES;
                //对数组中存放的元素重新排序
                if (cellIndexPath.section == attributes.indexPath.section) {
                    if (cellIndexPath.section == 0) {
                        NSString *imageStr = self.inUseItems[cellIndexPath.row];
                        [self.inUseItems removeObjectAtIndex:cellIndexPath.row];
                        [self.inUseItems insertObject:imageStr atIndex:attributes.indexPath.row];
                        
                    }else{
                        NSString *imageStr = self.unUsesItems[cellIndexPath.row];
                        [self.unUsesItems removeObjectAtIndex:cellIndexPath.row];
                        [self.unUsesItems insertObject:imageStr atIndex:attributes.indexPath.row];
                    }
                    [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
                }else{
                    if (cellIndexPath.section == 0) {//一区移动到二区
                        NSString *imageStr = self.inUseItems[cellIndexPath.row];
                        [self.inUseItems removeObjectAtIndex:cellIndexPath.row];
                        [self.unUsesItems insertObject:imageStr atIndex:attributes.indexPath.row];
                        
                    }else{//二区移动到一区
                        NSString *imageStr = self.unUsesItems[cellIndexPath.row];
                        [self.unUsesItems removeObjectAtIndex:cellIndexPath.row];
                        [self.inUseItems insertObject:imageStr atIndex:attributes.indexPath.row];
                        
                    }
                    [self.collectionView moveItemAtIndexPath:cellIndexPath toIndexPath:attributes.indexPath];
                    
                }
                
                
            }
        }
        
    }else if (sender.state == UIGestureRecognizerStateEnded) {
        if (!isChanged) {
            cell.center = [self.collectionView layoutAttributesForItemAtIndexPath:cellIndexPath].center;
        }
        NSLog(@"排序后---%lu--%lu",(unsigned long)self.inUseItems.count,(unsigned long)self.unUsesItems.count);
    }
    
    
    [self saveData];

}


//自动滑动collectionView
- (void)scrollerCollectionView:(CGPoint)point{
    if (point.y <= 10 + 64.0) {
        _scrollerValue = -1.0;
    }else if (point.y >= ([UIScreen mainScreen].bounds.size.height) - 20.0){
        _scrollerValue = 1.0;
    }else{
        if (_scrollerTimer) {
            [_scrollerTimer invalidate];
            _scrollerTimer = nil;
        }
        return;
    }
    if (!_scrollerTimer) {
        _scrollerTimer = [NSTimer scheduledTimerWithTimeInterval:0.007 target:self selector:@selector(startScrollerCollectionView) userInfo:nil repeats:YES];
        [_scrollerTimer setFireDate:[NSDate distantPast]];
    }
    
}

- (void)startScrollerCollectionView{
    CGPoint point = self.collectionView.contentOffset;
    if (point.y + _scrollerValue <= 0 || point.y + _scrollerValue + self.collectionView.bounds.size.height >= self.collectionView.contentSize.height) {
        [_scrollerTimer invalidate];
        _scrollerTimer = nil;
        return;
    }
    point = CGPointMake(point.x, point.y + _scrollerValue);
    self.collectionView.contentOffset = point;
}


/**
 保存本地数据
 */
-(void)saveData
{
    NSMutableArray *itemArr1 = [NSMutableArray new];
    for (int i = 0 ; i<self.inUseItems.count; i++) {
        CGXSlideChannelModel *model = self.inUseItems[i];
        [itemArr1 addObject:model];
    }
    
    NSMutableArray *itemArr2 = [NSMutableArray new];
    for (int i = 0 ; i<self.unUsesItems.count; i++) {
        CGXSlideChannelModel *model = self.unUsesItems[i];
        [itemArr2 addObject:model];
    }
    
    [CGXSlideChannelControll shareControl].inUseItems = itemArr1;
    [CGXSlideChannelControll shareControl].unUsesItems = itemArr2;
}

-(void)backMethod
{
    //回调返回block
    if (_backBlock) {_backBlock();}
    //返回
    [self dismissViewControllerAnimated:true completion:nil];
    
}

-(void)addBackBlock:(VoidBlock)block
{
    _backBlock = block;
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
