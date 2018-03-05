//
//  UIViewController+XWPageViewController.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/13.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "UIViewController+XWPageViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (XWPageViewController)


-(void)setPageIndex:(NSInteger)pageIndex{
    
     objc_setAssociatedObject(self, @selector(pageIndex), @(pageIndex), OBJC_ASSOCIATION_ASSIGN);
}

-(NSInteger)pageIndex{
    
     return  [objc_getAssociatedObject(self, @selector(pageIndex)) integerValue];
}

-(void)setAppearanceStatus:(AppearanceStatus)appearanceStatus{
    
     objc_setAssociatedObject(self, @selector(appearanceStatus), @(appearanceStatus), OBJC_ASSOCIATION_ASSIGN);
}

-(AppearanceStatus)appearanceStatus{
    
    return  [objc_getAssociatedObject(self, @selector(appearanceStatus)) integerValue];

}

-(void)notifyWillAppear:(BOOL)animated{
    
    self.appearanceStatus = willAppearStatus;
    
    [self beginAppearanceTransition:true animated:animated];
}

-(void)notifyDidAppear:(BOOL)animated{
    
    self.appearanceStatus = didAppearStatus;
    
    [self endAppearanceTransition];
    
}

-(void)notifyWillDisappear:(BOOL)animated{
    
    self.appearanceStatus = didDisappearStatus;
    
    [self beginAppearanceTransition:false animated:animated];
}

-(void)notifyDidDisappear:(BOOL)animated{
    
    self.appearanceStatus = didDisappearStatus;
    
    [self endAppearanceTransition];
}

@end
