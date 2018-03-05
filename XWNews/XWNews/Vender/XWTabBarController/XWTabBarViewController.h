//
//  XWTabBarViewController.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/12.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWTabBarViewController : UITabBarController

/**
 *  设置选中bar的背景图片
 *
 *  @param image image
 */
- (void)setSelectedBackgroundImage:(UIImage *)image;


/**
 *  tabbar controller 添加子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片名
 *  @param selectedImageName 选中的图片名
 */
- (void)addChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName;


@end
