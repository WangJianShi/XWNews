//
//  UIView+Ext.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/17.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "UIView+Ext.h"
#import <objc/runtime.h>

@implementation UIView (Ext)

///** 获取当前View的控制器对象 */

//使用关联向分类中添加一个当前控制器的属性
-(void)setViewController:(UIViewController *)viewController{
    objc_setAssociatedObject(self, @selector(viewController),viewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIViewController *)viewController{
    id vc= objc_getAssociatedObject(self, _cmd);
    
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            vc= (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return vc;
}



// 判断View是否显示在屏幕上
- (BOOL)isDisplayedInScreen
{
    if (self == nil) {
        return FALSE;
    }
    
    CGRect screenRect = [UIScreen mainScreen].bounds;
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    // 若view 隐藏 ,若没有superview ,若size为CGrectZero
    if (self.hidden||self.superview == nil||CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return FALSE;
    }
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}


//截图
-(UIImage *)screenShot{
    
    
    UIGraphicsBeginImageContext(CGSizeMake(self.frame.size.width, self.frame.size.height));
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    return viewImage;
    //    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    //    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    //    {
    //        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    //    }
    //    else
    //    {
    //        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    }
    //
    //    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return screenshot;
    
}

- (UIImage *) screenshotForScrollViewWithContentOffset:(CGPoint)contentOffset {
    UIGraphicsBeginImageContext(self.bounds.size);
    //need to translate the context down to the current visible portion of the scrollview
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0f, -contentOffset.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.55);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

- (UIImage*) screenshotInFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), frame.origin.x, frame.origin.y);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // helps w/ our colors when blurring
    // feel free to adjust jpeg quality (lower = higher perf)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.75);
    image = [UIImage imageWithData:imageData];
    
    return image;
}

-(void)addShadowWithRadius:(CGFloat)radius opacity:(CGFloat)opacity{
    
    self.layer.masksToBounds = YES;
    
    self.layer.shadowColor = [UIColor colorWithWhite:0.961 alpha:1].CGColor;//设置阴影的颜色
    
    self.layer.shadowOpacity = opacity;//设置阴影的透明度
    
    self.layer.shadowOffset = CGSizeMake(1, 1);//设置阴影的偏移量
    
    self.layer.shadowRadius = radius;//设置阴影的圆角

//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius,radius)];
//    self.layer.shadowPath = maskPath.CGPath;
//    self.layer.shadowColor = shadow_Color.CGColor;
//    self.layer.shadowOffset = CGSizeZero;
//    self.layer.shadowRadius = 1;
//    self.layer.cornerRadius = radius;
//    self.layer.shadowOpacity = opacity;
    self.layer.shouldRasterize = YES;
    
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;

}

-(void)addShadowWithRadius:(CGFloat)radius opacity:(CGFloat)opacity shadowColor:(UIColor *)shadowColor{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius,radius)];
    self.layer.shadowPath = maskPath.CGPath;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 1;
    self.layer.cornerRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)addShadowAroundWithCornerRadius:(float)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.shadowColor = [UIColor colorWithWhite:0.3 alpha:0.3].CGColor;
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1.f;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

-(void)clipCorner:(UIRectCorner) corners radius:(CGFloat)radius{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/**
 设置圆角动画
 @param radius 圆角半径
 */
- (void)roundCornerstoRadius:(CGFloat)radius {
    if (@available(iOS 9.0, *)) {
        CASpringAnimation *radiusAnimation     = [CASpringAnimation animationWithKeyPath:@"cornerRadius"];
        radiusAnimation.fromValue             = @(self.layer.cornerRadius);
        radiusAnimation.toValue               = @(radius);
        radiusAnimation.duration              = radiusAnimation.settlingDuration;
        radiusAnimation.damping               = 17.;
        [self.layer addAnimation:radiusAnimation forKey:nil];
        self.layer.cornerRadius                    = radius;
    } else {
        
        self.layer.cornerRadius = radius;
    }
    
}

-(void)jumpAnimation{
    
    //创建动画
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-10 / 180.0 * M_PI),@(10 /180.0 * M_PI),@(-10/ 180.0 * M_PI)];//度数转弧度
    
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.3;
    keyAnimaion.repeatCount = MAXFLOAT;
    [self.layer addAnimation:keyAnimaion forKey:nil];

}

- (void)setAnchorPoint:(CGPoint)anchorPoint
{
    CGPoint oldOrigin = self.frame.origin;
    self.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = self.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    self.center = CGPointMake (self.center.x - transition.x, self.center.y - transition.y);
}

@end
