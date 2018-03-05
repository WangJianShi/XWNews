//
//  XWLabel.m
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWAsyncLabel.h"

@interface XWAsyncLabel()

@property(nonatomic , weak)  XWTextLayout * xwTextLayout;

@end

@implementation XWAsyncLabel

-(instancetype)init{
    
    if (self = [super init]) {

         [self initCommon];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        
         [self initCommon];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self initCommon];
    }
    return self;
}

-(void)initCommon{
    
    self.displaysAsynchronously = YES;
    self.fadeOnAsynchronouslyDisplay = NO;
    self.ignoreCommonProperties = YES;
}

+(instancetype) create{
    XWAsyncLabel * label = [self new];
    return label;
}

-(void)setTextWithTextLayout:(XWTextLayout *)textLayout{
    if (self.xwTextLayout != textLayout ) {
        self.xwTextLayout = textLayout;
        self.ignoreCommonProperties = textLayout.textLayout.textBoundingSize.width > 0;
        if (self.ignoreCommonProperties) {
            [self setTextLayout:textLayout.textLayout];
        }else {
            [self setAttributedText:textLayout.attributedText];
        }
        
        CGRect rect = self.frame;
        rect.size = textLayout.size;
        self.frame = rect;
    }
}

@end
