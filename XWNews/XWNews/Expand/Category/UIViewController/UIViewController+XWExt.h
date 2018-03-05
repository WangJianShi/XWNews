//
//  UIViewController+XWExt.h
//  YCSteel
//
//  Created by serein on 2017/12/7.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>



#pragma mark - UINavigationBar
@interface UINavigationBar (WRAddition) <UINavigationBarDelegate>



@end

@interface UIViewController (XWExt)

/** record current ViewController navigationBar backgroundImage */
/** warning: wr_setDefaultNavBarBackgroundImage is deprecated! place use WRCustomNavigationBar */
//- (void)wr_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)xw_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)xw_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)xw_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)xw_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)xw_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)xw_setNavBarTintColor:(UIColor *)color;
- (UIColor *)xw_navBarTintColor;

/** record current ViewController titleColor */
- (void)xw_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)xw_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)xw_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)xw_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)xw_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)xw_navBarShadowImageHidden;

/** record current ViewController navigationBar left/rightbaritem */
-(void)xw_setLeftBarButtonItems:(NSArray<NSString *> *)titles;
-(void)xw_setLeftBarButtonItems:(NSArray<NSString *> *)titles font:(UIFont *)font color:(UIColor *)titleColor;
-(void)xw_setLeftBarImageItems:(NSArray<NSString *> *)images;
-(void)xw_setLeftBarImageItems:(NSArray<NSString *> *)images size:(CGSize )size;
-(void)xw_setNavBarLeftView:(UIView *)view;
-(void)handleDidClickLeftBtn:(id)sender;

-(void)xw_setRightBarButtonItems:(NSArray<NSString *> *)titles;
-(void)xw_setRightBarButtonItems:(NSArray<NSString *> *)titles font:(UIFont *)font color:(UIColor *)titleColor;
-(void)xw_setRightBarImageItems:(NSArray<NSString *> *)images;
-(void)xw_setRightBarImageItems:(NSArray<NSString *> *)images size:(CGSize )size;
-(void)xw_setNavBarRightView:(UIView *)view;
-(void)handleDidClickRightBtn:(id)sender;


@end
