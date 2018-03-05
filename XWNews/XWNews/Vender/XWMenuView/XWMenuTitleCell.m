//
//  XWMenuTitleCell.m
//  StealTime
//
//  Created by 王剑石 on 2017/7/17.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWMenuTitleCell.h"
#import "XWMenuTitleData.h"
#import "XWWidgetMacros.h"

@interface XWMenuTitleCell ()

@property (nonatomic, strong) UILabel *defaultLab;

@end

@implementation XWMenuTitleCell


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {


        [self addSubview:self.defaultLab];
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return  self;
    
}

-(void)reuseWithData:(NSObject *)data indexPath:(NSIndexPath *)indexPath{
    
    [super reuseWithData:data indexPath:indexPath];
    
    self.defaultLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    if ([data isKindOfClass:[XWMenuTitleData class]]) {
        
        XWMenuTitleData *titleData = (XWMenuTitleData *)data;
        
        self.defaultLab.text = titleData.title;
        
        self.defaultLab.font = [titleData titleFont];
        
        self.defaultLab.textColor = [titleData titleColor] ;
        
        self.defaultLab.backgroundColor = [titleData bgColor];
        
    }
}

-(void)updataView{
    
    XWMenuTitleData *titleData = (XWMenuTitleData *)self.xw_data;
    
    self.defaultLab.text = titleData.title;
    
    self.defaultLab.textColor = [titleData titleColor] ;
    
    self.defaultLab.backgroundColor = [titleData bgColor];
    
    [UIView animateWithDuration:0.001 animations:^{
        
       self.defaultLab.font = [titleData titleFont];
    }];
    
}


-(UILabel *)defaultLab{
    
    if (_defaultLab == nil) {
        
        _defaultLab =[[UILabel alloc] init];
        _defaultLab.textAlignment = NSTextAlignmentCenter;
    
    }
    
    return _defaultLab;
}

@end
