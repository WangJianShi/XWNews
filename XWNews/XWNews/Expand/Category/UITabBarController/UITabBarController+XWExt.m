//
//  UITabBarController+XWExt.m
//  YCSteel
//
//  Created by serein on 2018/1/16.
//  Copyright © 2018年 wangjianshi. All rights reserved.
//

// 判断是否是iPhone X
#define KIS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// tabBar高度
#define KTabBarHeight (KIS_IPHONE_X ? (49.f+34.f) : 49.f)

#import "UITabBarController+XWExt.h"

@implementation UITabBarController (XWExt)

#pragma mark 是否隐藏tabBar
- (void)hideTabBar:(BOOL)hide animated:(BOOL)animated{
    
    if (hide == YES)
    {
        if (self.tabBar.frame.origin.y == self.view.frame.size.height) return;
    }
    else
    {
        if (self.tabBar.frame.origin.y == self.view.frame.size.height - KTabBarHeight) return;
    }
    if (animated == YES)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (hide == YES)
        {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha =0.0;
        }
        else
        {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
            self.tabBar.alpha =1.0;
        }
        [UIView commitAnimations];
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3f];
        if (hide == YES)
        {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y + KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        }
        else
        {
            self.tabBar.frame = CGRectMake(self.tabBar.frame.origin.x, self.tabBar.frame.origin.y - KTabBarHeight, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
        }
        [UIView commitAnimations];
    }
}

@end
