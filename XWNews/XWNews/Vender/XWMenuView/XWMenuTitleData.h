//
//  XWMenuTitleData.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/17.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWWidgetMacros.h"

@interface XWMenuTitleData : NSObject

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) CGFloat titleWidth;

@property (nonatomic, strong) UIColor *defaultColor;

@property (nonatomic, strong) UIColor *selectColor;

@property (nonatomic, assign) CGFloat defaultFont;

@property (nonatomic, assign) CGFloat selectFont;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic, strong) UIColor *defaultBgColor;

@property (nonatomic, strong) UIColor *selectBgColor;



-(UIFont *)titleFont ;

-(UIColor *)titleColor;

-(UIColor *)bgColor;

-(instancetype)initWithTitle:(NSString *)title ;

-(void)updateTitleColorWithProgress:(CGFloat)progress;
@end
