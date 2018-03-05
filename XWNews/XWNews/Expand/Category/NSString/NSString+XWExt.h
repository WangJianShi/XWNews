//
//  NSString+XWExt.h
//  StealTime
//
//  Created by 王剑石 on 2017/8/9.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (XWExt)

-(CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize;

-(CGFloat)heightWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize;

-(CGFloat)widthWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize;

-(CGFloat)heightWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize lineSpace:(CGFloat)lineSpace;

-(CGFloat)widthWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize lineSpace:(CGFloat)lineSpace;

-(CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize lineSpace:(CGFloat)lineSpace;

@end
