//
//  MJDrawRefreshFooter.m
//  XWNews
//
//  Created by serein on 2018/2/27.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "MJDrawRefreshFooter.h"

@interface MJDrawRefreshFooter ()

//记录header的高度
@property (nonatomic, assign) CGSize imageSize;

@end

@implementation MJDrawRefreshFooter

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.gifView.constraints.count) return;
    
    self.gifView.x = 135 ;
        
    self.gifView.centerY = self.stateLabel.centerY;

}


- (void)prepare
{
    [super prepare];

    self.mj_h = 50;
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
