//
//  CGXSegmentTitleView.m
//  CGXConfigSlideMenuExample
//
//  Created by 曹贵鑫 on 2017/12/21.
//  Copyright © 2017年 曹贵鑫. All rights reserved.
//

#import "CGXSlideSegmentTitleView.h"


@interface CGXSlideSegmentTitleView ()
{
    UISegmentedControl *segmentedControl;
}
@end

@implementation CGXSlideSegmentTitleView

- (instancetype)initWithFrame:(CGRect)frame WithManager:(CGXSlideTitleManage *)manager
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.manager = manager;
        
        //初始化UISegmentedControl
        segmentedControl = [[UISegmentedControl alloc]initWithItems:self.manager.titlesAry];
        segmentedControl.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        segmentedControl.backgroundColor = [UIColor whiteColor];
        // 设置默认选择项索引
        segmentedControl.selectedSegmentIndex = self.manager.selectedIndex;
        segmentedControl.tintColor = self.manager.tintColor;
        
        //设置普通状态下(未选中)状态下的文字颜色和字体
        [segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.manager.itemFontSize],NSForegroundColorAttributeName: self.manager.itemNormalColor} forState:UIControlStateNormal];
        //设置选中状态下的文字颜色和字体
        [segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.manager.itemFontSize],NSForegroundColorAttributeName: self.manager.itemSelectedColor} forState:UIControlStateSelected];
        [self addSubview:segmentedControl];
        //设置跳转的方法
        [segmentedControl addTarget:self action:@selector(didClicksegmentedControlAction:) forControlEvents:UIControlEventValueChanged];
        
        
        
        

    }
    return self;
}

-(void)didClicksegmentedControlAction:(UISegmentedControl *)Seg{
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideCGXSegmentTitleViewDidSelectedAtIndex:)]) {
        [self.delegate slideCGXSegmentTitleViewDidSelectedAtIndex:Seg.selectedSegmentIndex];
    }
}
- (void)selectCGXSegmentTitleViewPage:(NSInteger)index
{
     segmentedControl.selectedSegmentIndex = index;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
