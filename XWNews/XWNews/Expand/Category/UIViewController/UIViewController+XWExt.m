//
//  UIViewController+XWExt.m
//  YCSteel
//
//  Created by serein on 2017/12/7.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "UIViewController+XWExt.h"
#import <objc/runtime.h>

//==========================================================================
#pragma mark - UINavigationBar
//==========================================================================
@implementation UINavigationBar (XWAddition)

static char kXWBackgroundViewKey;
static char kXWBackgroundImageViewKey;
static char kXWBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kXWBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &kXWBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kXWBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kXWBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kXWBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kXWBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)xw_setBackgroundImage:(UIImage *)image
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0)
        {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
            
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)xw_setBackgroundColor:(UIColor *)color
{
    
//    self.barTintColor = color;
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [UIScreen mainScreen].bounds.size.height >= 812.0 ? 88 : 64)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
        
//        [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make){
//            
//            make.left.right.top.mas_equalTo(0);
//            make.height.mas_equalTo(64);
//        }];
    }
    self.backgroundView.backgroundColor = color;
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)xw_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

-(void)xw_setTitleColor:(UIColor *)titleColor{
    
    NSDictionary *titleTextAttributes = [self titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.titleTextAttributes = newTitleTextAttributes;
}

-(void)xw_setShadowImageHiden:(BOOL)hidden{
    
    self.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}

-(void)xw_setTintColor:(UIColor *)color{
    
    self.tintColor = color;
}
@end

@implementation UIViewController (XWExt)

static char kXWNavBarBackgroundImageKey;
static char kXWNavBarBarTintColorKey;
static char kXWNavBarBackgroundAlphaKey;
static char kXWNavBarTintColorKey;
static char kXWNavBarTitleColorKey;
static char kXWStatusBarStyleKey;
static char kXWNavBarShadowImageHiddenKey;


// navigationBar backgroundImage
- (UIImage *)xw_navBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kXWNavBarBackgroundImageKey);
    image =  image;
    return image;
}
- (void)xw_setNavBarBackgroundImage:(UIImage *)image
{

    objc_setAssociatedObject(self, &kXWNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar xw_setBackgroundImage:image];
}

// navigationBar barTintColor
- (UIColor *)xw_navBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kXWNavBarBarTintColorKey);
    return  barTintColor ;
}
- (void)xw_setNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kXWNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar xw_setBackgroundColor:color];
}

// navigationBar _UIBarBackground alpha
- (CGFloat)xw_navBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kXWNavBarBackgroundAlphaKey);
    return  [barBackgroundAlpha floatValue];
    
}
- (void)xw_setNavBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kXWNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar xw_setBackgroundAlpha:alpha];

}

// navigationBar tintColor
- (UIColor *)xw_navBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kXWNavBarTintColorKey);
    return  tintColor ;
}
- (void)xw_setNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kXWNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar xw_setTintColor:color];
}

// navigationBartitleColor
- (UIColor *)xw_navBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kXWNavBarTitleColorKey);
    return titleColor ;
}
- (void)xw_setNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kXWNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController.navigationBar xw_setTitleColor:color];
}

// statusBarStyle
- (UIStatusBarStyle)xw_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kXWStatusBarStyleKey);
    return  [style integerValue];
}
- (void)xw_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kXWStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)xw_setNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kXWNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self.navigationController.navigationBar xw_setShadowImageHiden:hidden];
    
}
- (BOOL)xw_navBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kXWNavBarShadowImageHiddenKey);
    return  [hidden boolValue] ;
}

//navigationBar leftBarbtn
-(void)xw_setNavBarLeftView:(UIView *)view{
    
    UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer. width = -6 ;
    
    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects :negativeSpacer, leftNavButton, nil ] animated:NO];
}

-(void)xw_setLeftBarButtonItems:(NSArray<NSString *> *)titles{
    
    [self xw_setLeftBarButtonItems:titles font:[UIFont systemFontOfSize:16] color:[UIColor whiteColor]];
}

-(void)xw_setLeftBarButtonItems:(NSArray<NSString *> *)titles font:(UIFont *)font color:(UIColor *)titleColor{
    
    
    NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray<UIBarButtonItem *> array];
    for (int i = 0; i < titles.count; i++) {
        
        CGSize size = [titles[i] sizeWithAttributes:@{NSFontAttributeName:font}];
        size.width += 10;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i + 1;
        btn.frame = CGRectMake(0, 0, size.width, self.navigationItem.titleView.frame.size.height);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = font;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleDidClickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        UIBarButtonItem *spacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                  target : nil action : nil ];
        spacer. width = 4 ;
        
        [items addObject:leftNavButton];
        
        [items addObject:spacer];
        
        
    }
    
    [self.navigationItem setLeftBarButtonItems:items];
    
}

-(void)xw_setLeftBarImageItems:(NSArray<NSString *> *)images{
    
    [self xw_setLeftBarImageItems:images size:CGSizeMake(29, 30)];
}

-(void)xw_setLeftBarImageItems:(NSArray<NSString *> *)images size:(CGSize )size{
    
    
    NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray<UIBarButtonItem *> array];
    for (int i = 0; i < images.count; i++) {
        
        //建立一个自己的返回视图。。
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, size.width, size.height);
        btn.contentMode = UIViewContentModeLeft;
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateHighlighted];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [btn addTarget:self action:@selector(handleDidClickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        UIBarButtonItem *spacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                  target : nil action : nil ];
        spacer. width = 4 ;
        
        [items addObject:leftNavButton];
        
        [items addObject:spacer];
        
        
    }
    
    [self.navigationItem setLeftBarButtonItems:items];
    
}

-(void)handleDidClickLeftBtn:(id)sender{
    
    
}

//navigationBar rightBarbtn
-(void)xw_setNavBarRightView:(UIView *)view{
    
    UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    UIBarButtonItem *negativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                      target : nil action : nil ];
    negativeSpacer. width = -6 ;
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects :negativeSpacer, leftNavButton, nil ] animated:NO];
}

-(void)xw_setRightBarButtonItems:(NSArray<NSString *> *)titles{
    
    [self xw_setRightBarButtonItems:titles font:[UIFont systemFontOfSize:16] color:[UIColor whiteColor]];
}

-(void)xw_setRightBarButtonItems:(NSArray<NSString *> *)titles font:(UIFont *)font color:(UIColor *)titleColor{
    
    
    NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray<UIBarButtonItem *> array];
    for (int i = 0; i < titles.count; i++) {
        
        CGSize size = [titles[titles.count - 1 - i] sizeWithAttributes:@{NSFontAttributeName:font}];
        size.width += 10;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = titles.count - i;
        btn.frame = CGRectMake(0, 0, size.width, self.navigationItem.titleView.frame.size.height);
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = font;
        [btn setTitleColor:titleColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(handleDidClickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        UIBarButtonItem *spacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                  target : nil action : nil ];
        spacer. width = 4 ;
        
        [items addObject:leftNavButton];
        
        [items addObject:spacer];
        
        
    }
    
    [self.navigationItem setRightBarButtonItems:items];
    
}

-(void)xw_setRightBarImageItems:(NSArray<NSString *> *)images{
    
    [self xw_setRightBarImageItems:images size:CGSizeMake(29, 30)];
}

-(void)xw_setRightBarImageItems:(NSArray<NSString *> *)images size:(CGSize )size{
    
    
    NSMutableArray<UIBarButtonItem *> *items = [NSMutableArray<UIBarButtonItem *> array];
    for (int i = 0; i < images.count; i++) {
        
        //建立一个自己的返回视图。。
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, size.width, size.height);
        btn.tag = images.count - i;
        btn.contentMode = UIViewContentModeRight;
        [btn setImage:[UIImage imageNamed:images[images.count - 1 - i]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[images.count - 1 - i]] forState:UIControlStateHighlighted];
        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [btn addTarget:self action:@selector(handleDidClickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *leftNavButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        UIBarButtonItem *spacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                  target : nil action : nil ];
        spacer. width = 4 ;
        
        [items addObject:leftNavButton];
        
        [items addObject:spacer];
        
        
    }
    
    [self.navigationItem setRightBarButtonItems:items];
    
}

-(void)handleDidClickRightBtn:(id)sender{
    
    
}


@end
