//
//  XWMainViewController.m
//  XWNews
//
//  Created by serein on 2018/2/27.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWMainViewController.h"
#import "XWTabBarViewController.h"
#import "JTNavigationController.h"
#import "HomeViewController.h"

@implementation XWMainViewController

+(UIViewController *)mainViewController{
    
    NSArray *sources = @[
                         @{
                             @"viewController":[[HomeViewController alloc]init],
                             @"title":@"首页",
                             @"defaultImg":@"home_tabbar.png",
                             @"selectImg":@"home_tabbar_press.png"
                             },
                         @{
                             @"viewController":[[HomeViewController alloc]init],
                             @"title":@"西瓜视频",
                             @"defaultImg":@"video_tabbar.png",
                             @"selectImg":@"video_tabbar_press.png"
                             },
                         @{
                             @"viewController":[[HomeViewController alloc]init],
                             @"title":@"微头条",
                             @"defaultImg":@"weitoutiao_tabbar.png",
                             @"selectImg":@"weitoutiao_tabbar_press.png"
                             },
                         @{
                             @"viewController":[[HomeViewController alloc]init],
                             @"title":@"小视频",
                             @"defaultImg":@"huoshan_tabbar.png",
                             @"selectImg":@"huoshan_tabbar_press.png"
                             },
                         ];
    
    return  [self initTabBarControllerWithSource:sources];
}

+(UIViewController *)initTabBarControllerWithSource:(NSArray<NSDictionary *> *)sources{
    
    
    XWTabBarViewController *tabBarController = [[XWTabBarViewController alloc] init];
    
    for (NSDictionary *dic in sources) {
        
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:dic[@"viewController"]];
        navi.navigationBar.translucent = NO;
        [tabBarController addChlildVc:navi title:dic[@"title"] imageName:dic[@"defaultImg"] selectedImageName:dic[@"selectImg"]];
    }
    
    return tabBarController;
}


@end
