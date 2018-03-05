//
//  XWMenuTitleData.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/17.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWMenuTitleData.h"

@interface XWMenuTitleData ()

@property (nonatomic, strong) UIColor *showColor;

@property (nonatomic, strong) UIFont *showFont;

@property (nonatomic, strong) UIColor *showBGColor;

@end

@implementation XWMenuTitleData

-(instancetype)initWithTitle:(NSString *)title {
    
    if (self = [super init]) {
        
        self.title = title;
        
        self.defaultFont = 14;
        
        self.selectFont = 16;

        self.defaultBgColor = [UIColor clearColor];
        
        self.selectBgColor = [UIColor clearColor];
        
        self.defaultColor = [UIColor lightGrayColor];
        
        self.selectColor = [UIColor redColor];
        
        self.showColor = self.defaultColor;
        
        self.showBGColor = self.defaultBgColor;
        
        self.showFont = [UIFont systemFontOfSize:self.defaultFont];
        
        self.xw_reuseIdentifier = @"XWMenuTitleCell";
        
        
    }
    
    return self;
}

-(void)setIsSelect:(BOOL)isSelect{
    
    _isSelect = isSelect;
    
    self.showColor = isSelect ? self.selectColor : self.defaultColor;
    
    self.showFont = [UIFont systemFontOfSize:isSelect ? self.selectFont  : self.defaultFont] ;
    
    self.showBGColor = isSelect ? self.selectBgColor : self.defaultBgColor;
}



-(CGFloat)titleWidth{
    
    if (_titleWidth == 0) {
        
         CGFloat font = self.defaultFont > self.selectFont ? self.defaultFont : self.selectFont;
        _titleWidth = [self.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 24) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil].size.width;
    }
    
    return _titleWidth;
}

-(void)updateTitleColorWithProgress:(CGFloat)progress{
    
    CGFloat normalRed  = 0.0;
    CGFloat normalGreen  = 0.0;
    CGFloat normalBlue  = 0.0;
    CGFloat normalAlpha  = 0.0;
    CGFloat selectedRed  = 0.0;
    CGFloat selectedGreen = 0.0;
    CGFloat selectedBlue  = 0.0;
    CGFloat selectedAlpha  = 0.0;
    
    [self.defaultColor getRed:&normalRed green:&normalGreen blue:&normalBlue alpha:&normalAlpha];
    [self.selectColor getRed:&selectedRed green:&selectedGreen blue:&selectedBlue alpha:&selectedAlpha];
    
    // 获取选中和未选中状态的颜色差值
    CGFloat redDiff = selectedRed - normalRed;
    CGFloat greenDiff = selectedGreen - normalGreen;
    CGFloat blueDiff = selectedBlue - normalBlue;
    CGFloat alphaDiff = selectedAlpha - normalAlpha;
    
    self.showColor = [[UIColor alloc] initWithRed:progress * redDiff + normalRed green:progress * greenDiff + normalGreen blue:progress * blueDiff + normalBlue alpha:progress * alphaDiff + normalAlpha];
    
    
    CGFloat progressFont = self.defaultFont + (self.selectFont - self.defaultFont) * progress ;
    
    self.showFont = [UIFont systemFontOfSize:progressFont];

}


-(UIFont *)titleFont {
    
    return  _showFont;
}

-(UIColor *)titleColor{
    
    return _showColor;
    
}

-(UIColor *)bgColor{
    
    return _showBGColor;
}

@end
