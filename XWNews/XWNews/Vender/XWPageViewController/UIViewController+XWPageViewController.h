//
//  UIViewController+XWPageViewController.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/13.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    defaultStatus = 0,
    willAppearStatus,
    didAppearStatus,
    willDisappearStatus,
    didDisappearStatus,
} AppearanceStatus;

@interface UIViewController (XWPageViewController)

@property (nonatomic, assign) NSInteger pageIndex;

@property (nonatomic, assign) AppearanceStatus appearanceStatus;

-(void)notifyWillAppear:(BOOL)animated;

-(void)notifyDidAppear:(BOOL)animated;

-(void)notifyWillDisappear:(BOOL)animated;

-(void)notifyDidDisappear:(BOOL)animated;

@end
