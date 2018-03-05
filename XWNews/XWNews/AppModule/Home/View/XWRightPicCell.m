//
//  XWRightPicCell.m
//  XWNews
//
//  Created by serein on 2018/2/27.
//  Copyright © 2018年 王剑石. All rights reserved.
//


#import "XWRightPicCell.h"

@interface XWRightPicCell ()

@property (nonatomic,strong) XWAsyncLabel *titleLab;

@property (nonatomic,strong) XWAsyncLabel *subTitleLab;

@property (nonatomic,strong) XWAsyncImageView *rightImgView;

@property (nonatomic,strong) UIButton *deleteBtn;

@end

@implementation XWRightPicCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLab];
        [self addSubview:self.subTitleLab];
        [self addSubview:self.rightImgView];
    }
    return self;
}


-(XWAsyncLabel *)titleLab{
    
    if (_titleLab == nil) {
        
        _titleLab = [XWAsyncLabel create];
        _titleLab.frame = CGRectMake(15, 15, self.width - self.rightImgView.left - 20, 42);
    }
    return _titleLab;
}

-(XWAsyncImageView *)rightImgView{
    
    if (_rightImgView == nil) {
        
        _rightImgView = [[XWAsyncImageView alloc] initWithFrame:CGRectMake(self.width - 15 - self.width * 0.28, 10, self.width*0.28, self.height - 20)];
        _rightImgView.backgroundColor = line_Color;
    }
    return _rightImgView;
}

-(UIButton *)deleteBtn{
    
    if (_deleteBtn == nil) {
        
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.rightImgView.left - 5 - 17, self.rightImgView.bottom - 5 - 15, 17, 15)];
        [_deleteBtn setImage:[UIImage imageNamed:@"add_textpage_17x12_"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

-(XWAsyncLabel *)subTitleLab{
    
    if (_subTitleLab == nil) {
        
        _subTitleLab = [XWAsyncLabel create];
        _subTitleLab.frame = CGRectMake(self.titleLab.left, self.deleteBtn.top, self.width - self.deleteBtn.left - 15, 15);
    }
    return _subTitleLab;
}

@end
