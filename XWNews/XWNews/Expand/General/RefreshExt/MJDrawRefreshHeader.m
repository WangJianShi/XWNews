//
//  MJDrawRefreshHeader.m
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "MJDrawRefreshHeader.h"

@interface MJDrawRefreshHeader ()

//记录header的高度
@property (nonatomic, assign) CGSize imageSize;

@end


@implementation MJDrawRefreshHeader

#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.frame = CGRectMake(0, 4, self.frame.size.width, 25);
    self.gifView.contentMode = UIViewContentModeCenter;
    self.stateLabel.font = [UIFont systemFontOfSize:12];
    self.stateLabel.frame = CGRectMake(0, 35, self.frame.size.width, 14);
    self.stateLabel.textAlignment = NSTextAlignmentCenter;

}


- (void)prepare
{
    [super prepare];
    
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.gifView.contentMode = UIViewContentModeCenter;
}

//- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state
//{
//    [super setImages:images duration:duration forState:state]; //调用一下父类方法
//    
//    //取出第一张照片,求高度
//    UIImage *image = images.firstObject;
//    //记录照片size
//    self.imageSize = image.size;
//    self.mj_h = image.size.height - 10 ;
//    
//}
//
//- (void)setImages:(NSArray *)images forState:(MJRefreshState)state
//{
//    [self setImages:images duration:images.count * 0.1 forState:state];
//}

@end

