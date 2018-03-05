//
//  XWTextLayout.m
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWTextLayout.h"


@implementation XWTextLayout

+(instancetype) createWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color fitWithSize:(CGSize) size lineHeight:(CGFloat)lineHeight{
    if (text == nil) {
        text = @" ";
    }
    if (size.height < font.pointSize + 3) {
        size.height = font.pointSize + 3;
    }
    
    XWTextLayout *  textLayout = [XWTextLayout new];
    NSMutableAttributedString * atts = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color , NSFontAttributeName : font}];
    textLayout.attributedText = atts;
    atts.yy_lineSpacing = lineHeight;
    YYTextContainer *container = [YYTextContainer containerWithSize:size];
    container.truncationType = YYTextTruncationTypeEnd;
    YYTextLayout * yyTextLayout = [YYTextLayout layoutWithContainer:container text:atts];
    textLayout.textLayout = yyTextLayout;
    textLayout.size = yyTextLayout.textBoundingSize;
    
    if (CGSizeEqualToSize(CGSizeZero, textLayout.size)) {
        textLayout.size = [atts boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil].size;
    }
    
    return textLayout;
}

+(instancetype) createWithText:(NSString *)text font:(UIFont *)font textColor:(UIColor *)color fitWithSize:(CGSize) size{
    if (text == nil) {
        text = @" ";
    }
    if (size.height < font.pointSize + 3) {
        size.height = font.pointSize + 3;
    }
    XWTextLayout *  textLayout = [XWTextLayout new];
    NSMutableAttributedString * atts = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color , NSFontAttributeName : font}];
    textLayout.attributedText = atts;
    
    YYTextContainer *container = [YYTextContainer containerWithSize:size];
    container.truncationType = YYTextTruncationTypeEnd;
    YYTextLayout * yyTextLayout = [YYTextLayout layoutWithContainer:container text:atts];
    textLayout.textLayout = yyTextLayout;
    textLayout.size = yyTextLayout.textBoundingSize;
    if (CGSizeEqualToSize(CGSizeZero, textLayout.size)) {
        textLayout.size = [atts boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil].size;
    }
    return textLayout;
}

+(instancetype) createWithTextAttributes:(NSAttributedString *)textAtt fitWithSize:(CGSize)size contentInsets:(UIEdgeInsets)insets{
    
    XWTextLayout *  textLayout = [XWTextLayout new];
    
    YYTextContainer *container = [YYTextContainer containerWithSize:size];
    container.insets = insets;
    container.truncationType = YYTextTruncationTypeEnd;
    YYTextLayout * yyTextLayout = [YYTextLayout layoutWithContainer:container text:textAtt];
    textLayout.textLayout = yyTextLayout;
    textLayout.attributedText = textAtt;
    textLayout.size = yyTextLayout.textBoundingSize;
    if (CGSizeEqualToSize(CGSizeZero, textLayout.size)) {
        textLayout.size = [textAtt boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil].size;
    }
    

    
    return textLayout;
}


+(instancetype) createWithTextAttributes:(NSAttributedString *)textAtt fitWithSize:(CGSize)size{
    return [self createWithTextAttributes:textAtt fitWithSize:size contentInsets:UIEdgeInsetsZero];
}

+ (instancetype)createWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color fitWithSize:(CGSize)size {
    return [self createWithText:text font:[UIFont systemFontOfSize:fontSize] textColor:color fitWithSize:size];
}

+(instancetype) createWithText:(NSString *)text boldFontSize:(CGFloat)fontSize color:(UIColor *)color fitWithSize:(CGSize) size{
    return [self createWithText:text font:[UIFont boldSystemFontOfSize:fontSize] textColor:color fitWithSize:size];
}

+(instancetype)createWithText:(NSString *)text fontSize:(CGFloat)fontSize color:(UIColor *)color fitWithHeight:(CGFloat)height {
    return [self createWithText:text font:[UIFont systemFontOfSize:fontSize] textColor:color fitWithSize:CGSizeMake(INTMAX_MAX, height)];
    
}


@end
