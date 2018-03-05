//
//  NSObject+XWRuntime.m
//  XWSuperWidgetDemo
//
//  Created by 王剑石 on 16/12/31.
//  Copyright © 2016年 王剑石. All rights reserved.
//

#import "NSObject+XWRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (XWRuntime)

+ (BOOL)xw_swizzleMethod:(SEL)origSel withMethod:(SEL)altSel {
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) {
        return NO;
    }
    class_addMethod(self,
                    origSel,
                    class_getMethodImplementation(self, origSel),
                    method_getTypeEncoding(origMethod));
    class_addMethod(self,
                    altSel,
                    class_getMethodImplementation(self, altSel),
                    method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel),
                                   class_getInstanceMethod(self, altSel));
    return YES;
}

+ (BOOL)xw_swizzleClassMethod:(SEL)origSel withMethod:(SEL)altSel {
    return [object_getClass((id)self) xw_swizzleMethod:origSel withMethod:altSel];
}

@end
