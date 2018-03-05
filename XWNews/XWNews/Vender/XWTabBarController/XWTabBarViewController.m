//
//  XWTabBarViewController.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/12.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//



#import "XWTabBarViewController.h"
#import "UITabBar+Badge.h"

@interface XWTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation XWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = [UIColor whiteColor];
    //删除tabbar的分割线
//     [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
     self.delegate = self;

    // Do any additional setup after loading the view.
}

/**
 *  tabbar controller 添加子控制器
 *
 *  @param childVc           子控制器
 *  @param title             标题
 *  @param imageName         图片名
 *  @param selectedImageName 选中的图片名
 */
- (void)addChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    // 设置标题

    UITabBarItem * item = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:imageName] selectedImage:[UIImage imageNamed:selectedImageName]];
    childVc.tabBarItem = item;
    childVc.title = title;
    
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0);
    [childVc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = TabarColor;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = MainColor;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    // 声明这张图片用原图(别渲染)
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    NSMutableArray *preVviewControllers = [NSMutableArray arrayWithArray: self.viewControllers];
    
    [preVviewControllers addObject:childVc];
    
    self.viewControllers = preVviewControllers;
}


/**
 *  设置选中背景图片
 *
 *  @param image 图片
 */
- (void)setSelectedBackgroundImage:(UIImage *)image {
    self.tabBar.selectionIndicatorImage = image;
}

#pragma mark - <UITabBarControllerDelegate>

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    //点击tabBarItem动画
    [self tabBarButtonClick:[self getTabBarButton]];
    
}
- (UIControl *)getTabBarButton{
    NSMutableArray *tabBarButtons = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]){
            [tabBarButtons addObject:tabBarButton];
        }
    }
    UIControl *tabBarButton = [tabBarButtons objectAtIndex:self.selectedIndex];
    
    return tabBarButton;
}
#pragma mark - 点击动画
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    for (UIView *imageView in tabBarButton.subviews) {
        if ([imageView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
            //需要实现的帧动画,这里根据自己需求改动
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
            animation.keyPath = @"transform.scale";
            animation.values = @[@1.0,@1.15,@0.85,@1.0];
            animation.duration = 0.3;
            animation.calculationMode = kCAAnimationCubic;
            //添加动画
            [imageView.layer addAnimation:animation forKey:nil];
        }
    }
}


#pragma mark - 禁止屏幕旋转
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;//只支持这一个方向(正常的方向)
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
