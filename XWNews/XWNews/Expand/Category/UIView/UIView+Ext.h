//
//  UIView+Ext.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/17.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Ext)


//获取view所属控制器
@property (nonatomic, strong) UIViewController *viewController;


// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen;

//截图
-(UIImage *)screenShot;

//ScrollView截图 contentOffset
- (UIImage*) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset;

//View按Rect截图
- (UIImage*) screenshotInFrame:(CGRect)frame;


//添加阴影效果
-(void)addShadowWithRadius:(CGFloat)radius opacity:(CGFloat)opacity;

-(void)addShadowWithRadius:(CGFloat)radius opacity:(CGFloat)opacity shadowColor:(UIColor *)shadowColor;

- (void)addShadowAroundWithCornerRadius:(float)cornerRadius;


//添加部分圆角
-(void)clipCorner:(UIRectCorner) corners radius:(CGFloat)radius;

/**
 设置圆角动画
 @param radius 圆角半径
 */
- (void)roundCornerstoRadius:(CGFloat)radius;

/**
 抖动动画
 */
-(void)jumpAnimation;

- (void)setAnchorPoint:(CGPoint)anchorPoint;

@end
