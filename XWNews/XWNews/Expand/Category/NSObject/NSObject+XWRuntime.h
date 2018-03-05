//
//  NSObject+XWRuntime.h
//  XWSuperWidgetDemo
//
//  Created by 王剑石 on 16/12/31.
//  Copyright © 2016年 王剑石. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XWRuntime)

+ (BOOL)xw_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;

+ (BOOL)xw_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel;

@end
