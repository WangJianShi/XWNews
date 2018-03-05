//
//  XWMacos.h
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <Foundation/Foundation.h>


//weak弱引用
#define KWeakSelf __weak typeof(&*self) weakSelf = self

//strong强引用
#define KStrongSelf __strong typeof(&*weakSelf) strongSelf = weakSelf

//屏幕宽度
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

//屏幕高度
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kAutoScreenValue(a) (a * kScreenWidth/320.f)

/****************************适配iPhonex********************************/
#define NaviBarHeight (kScreenHeight >= 812.0 ? 88 : 64)

#define TarBarHeight (kScreenHeight >= 812.0 ? 83 : 49)

#define StatusBarHeight (kScreenHeight >= 812.0 ? 44 : 20)

#define SafeAreaBottomHeight (kScreenHeight >= 812.0 ? 34 : 0)
/***********************************************************************/

#ifndef XWAlertShowMsg
#define XWAlertShowMsg(msg) {UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];[alertView show];}
#endif

#define XW_Objc_exchangeMethodAToB(originalSelector,swizzledSelector) { \
Method originalMethod = class_getInstanceMethod(self, originalSelector); \
Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector); \
if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) { \
class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod)); \
} else { \
method_exchangeImplementations(originalMethod, swizzledMethod); \
} \
}


//系统版本

#define isIOS7  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)?YES:NO)

#define isIOS8  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)?YES:NO)

#define isIOS9  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0)?YES:NO)

#define isIOS10  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 10.0)?YES:NO)

#define isIOS11  (([[[UIDevice currentDevice]systemVersion] floatValue] >= 11.0)?YES:NO)

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)



// 单例定义

#define singleInstanceDefine \
+(instancetype) getInstance;\
\
+(void) destoryInstance;


// 单例实现

#define singleInstanceImple \
static id instance;\
+(instancetype) getInstance{ \
\
@synchronized(self) {\
if (instance == nil) {  \
instance = [self new]; \
}\
}\
return instance;\
}\
\
+(void) destoryInstance{\
instance = nil;\
}

/**
 归档的实现
 */
#define MJEncodeDecodeImplementation \
- (id)initWithCoder:(NSCoder *)decoder \
{ \
if (self = [super init]) { \
[self decode:decoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)encoder \
{ \
[self encode:encoder]; \
}


#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)
