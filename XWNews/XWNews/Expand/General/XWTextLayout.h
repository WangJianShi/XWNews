//
//  XWTextLayout.h
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <YYText/YYText.h>

@interface XWTextLayout : NSObject

@property(nonatomic , strong) YYTextLayout * textLayout;
@property(nonatomic , assign) CGSize size;
@property(nonatomic , strong)  NSAttributedString * attributedText;


+(instancetype) createWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color fitWithSize:(CGSize) size;

+(instancetype) createWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color fitWithSize:(CGSize) size;

+(instancetype) createWithText:(NSString *)text boldFontSize:(CGFloat)fontSize color:(UIColor *)color fitWithSize:(CGSize) size;

+(instancetype) createWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color fitWithHeight:(CGFloat) height;

+(instancetype) createWithTextAttributes:(NSAttributedString *)textAtt fitWithSize:(CGSize)size;

+(instancetype) createWithTextAttributes:(NSAttributedString *)textAtt fitWithSize:(CGSize)size contentInsets:(UIEdgeInsets)insets;

+(instancetype) createWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color fitWithSize:(CGSize) size lineHeight:(CGFloat)lineHeight;

@end
