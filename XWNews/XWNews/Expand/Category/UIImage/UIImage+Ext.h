//
//  UIImage+Ext.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/12.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)handleImageWithSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

-(UIImage*)imageWithCornerRadius:(CGFloat)radius;

@end
