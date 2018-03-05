//
//  UITabBar+Badge.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/12.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)


#pragma mark  添加小红点
- (void)showBadgeOnIndex:(int)index{
    
    //移除之前的小红点
    [self removeBadgeOnIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / 4;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 8, 8);
    badgeView.layer.cornerRadius = badgeView.frame.size.width/2;
    
    [self addSubview:badgeView];
    
}
#pragma mark 移除小红点
- (void)hideBadgeOnIndex:(int)index{
    
    //移除小红点
    [self removeBadgeOnIndex:index];
    
}
#pragma mark   按照tag值进行移除
- (void)removeBadgeOnIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}


@end
