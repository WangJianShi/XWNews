//
//  XWPageViewController.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/13.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XWPageViewController;
//-----------------------------------数据源-------------------------------------//

@protocol XWPageViewControllerDataSource <NSObject>

-(NSInteger)numberOfControllersInPageViewController:(XWPageViewController *)pageViewController;

-(UIViewController *) pageViewControllerForIndex:(XWPageViewController *)pageViewController andIndex:(NSInteger)index;


@end

//------------------------------------代理----------------------------------------//

@protocol XWPageViewControllerDelegate <NSObject>

-(void)pageViewControllerScrollProgress:(XWPageViewController *)pageViewController andProgress:(CGFloat)progress andFromPage:(NSInteger)fromPage;

-(void)pageViewControllerPageChange:(XWPageViewController *)pageViewController  andPageChange:(NSInteger)pageChange;

@end

@interface XWPageViewController : UIViewController

@property(nonatomic, weak) id<XWPageViewControllerDataSource> dataSource;

@property(nonatomic, weak) id<XWPageViewControllerDelegate> delegate;

@property(nonatomic, assign) BOOL hasProcessForwardAppearance;

-(void)gotoPageWithIndex:(NSInteger)index animated: (BOOL)animated;

@end
