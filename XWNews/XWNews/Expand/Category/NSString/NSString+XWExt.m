//
//  NSString+XWExt.m
//  StealTime
//
//  Created by 王剑石 on 2017/8/9.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "NSString+XWExt.h"

@implementation NSString (XWExt)

-(CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    
    
    return [self sizeWithFont:font constraintSize:constraintSize lineSpace:0];
}

-(CGSize)sizeWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize lineSpace:(CGFloat)lineSpace
{
    
    if (self == nil || self.length == 0) {
        
        return CGSizeZero;
    }
    CGSize stringSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    NSInteger options = NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin;
    CGRect stringRect = [self boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    stringSize = stringRect.size;
    
    return stringSize;
}


-(CGFloat)heightWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize
{

    return [self sizeWithFont:font constraintSize:constraintSize lineSpace:0].height;
}

-(CGFloat)widthWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize
{
    
    return [self sizeWithFont:font constraintSize:constraintSize lineSpace:0].width;
}

-(CGFloat)heightWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize lineSpace:(CGFloat)lineSpace
{
    
    return [self sizeWithFont:font constraintSize:constraintSize lineSpace:lineSpace].height;
}

-(CGFloat)widthWithFont:(UIFont *)font constraintSize:(CGSize)constraintSize lineSpace:(CGFloat)lineSpace
{
    
    return [self sizeWithFont:font constraintSize:constraintSize lineSpace:lineSpace].width;
}


@end
