//
//  UITabBar+Badge.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/12.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

#pragma mark  添加小红点
- (void)showBadgeOnIndex:(int)index;
#pragma mark 移除小红点
- (void)hideBadgeOnIndex:(int)index;
#pragma mark   按照tag值进行移除
- (void)removeBadgeOnIndex:(int)index;

@end
