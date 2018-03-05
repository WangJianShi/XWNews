//
//  HomeMenuView.m
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "HomeMenuView.h"


@interface HomeMenuView ()

@property (nonatomic,strong) XWMenuView *menuView;

@property (nonatomic,strong) UIButton *selectBtn;

@property (nonatomic,strong) UIView *line;

@property (nonatomic,strong) NSMutableArray<XWMenuTitleData *> *titleDatas;

@end

@implementation HomeMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleDatas = [NSMutableArray<XWMenuTitleData *> array];
        [self addSubview:self.menuView];
        [self addSubview:self.selectBtn];
        [self addSubview:self.line];
    }
    
    return self;
}

-(void)updateProgressValue:(CGFloat)progress andFromPage:(NSInteger)fromPage{
    
    [self.menuView updateBottomLineFrameWithProgressValue:progress andFromPage:fromPage];
}

-(void)updateSelectValue:(NSInteger)index{
    
    self.menuView.selectIndex = index;
}


-(void)setDelegate:(id<XWMenuViewDelegate>)delegate{
    
    _delegate = delegate;
    
    self.menuView.delegate = delegate;
}

-(XWMenuView *)menuView{
    
    if (_menuView == nil) {
        
        _menuView = [[XWMenuView alloc] initWithFrame:self.bounds delegate:self];
        _menuView.leadingMargin = 10;
        _menuView.trailingMargin = 40 + 10;
        _menuView.itemSpace = 15;
    }
    return _menuView;
}

-(UIButton *)selectBtn{
    
    if (_selectBtn == nil) {
        
        _selectBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.width-self.height, 0, 40, self.height)];
        [_selectBtn setImage:[UIImage imageNamed:@"add_channel_titlbar_follow"] forState:UIControlStateNormal];
        _selectBtn.backgroundColor = white_Color;
        UIImageView *shadow = [[UIImageView alloc] initWithFrame:CGRectMake(-10, 0, 10, _selectBtn.height)];
        shadow.image = [UIImage imageNamed:@"shadow"];
        shadow.alpha = 0.8;
        [_selectBtn addSubview:shadow];
        
    }
    return _selectBtn;
}

-(UIView *)line{
    
    if (_line == nil) {
        
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        _line.backgroundColor = line_Color;
    }
    return _line;
}

-(void)setTitles:(NSArray<NSString *> *)titles{
    
    _titles = titles;
    [self.titleDatas removeAllObjects];
    for (NSString *title in titles) {
        
        XWMenuTitleData *titleData = [[XWMenuTitleData alloc] initWithTitle:title];
        titleData.defaultFont = 16;
        titleData.selectFont = 18;
        titleData.defaultColor = MainFontColor;
        titleData.selectColor = MainSelectColor;

        [self.titleDatas addObject:titleData];
        
    }
    
    self.menuView.dataList = self.titleDatas;
    
}

@end
