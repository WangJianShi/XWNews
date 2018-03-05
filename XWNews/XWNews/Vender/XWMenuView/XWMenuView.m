//
//  XWMenuView.m
//  XWMenuView
//
//  Created by 王剑石 on 16/8/13.
//  Copyright © 2016年 Avatar. All rights reserved.
//

#import "XWMenuView.h"


@implementation XWPeogressMaker

@end

@interface XWMenuView ()<XWCollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *myCollectionView;

@property (nonatomic, strong) UIView *bottomLine;

@property (strong, nonatomic) NSArray *rectList;

@property (nonatomic, strong) NSArray<NSObject *> *menuList;

@property (nonatomic,assign) XWMenuViewStyle style;

@property (nonatomic,strong) XWPeogressMaker *maker;


@end

@implementation XWMenuView


-(instancetype)initWithFrame:(CGRect)frame delegate:(id<XWMenuViewDelegate>)delegate{
    
    if (self = [super initWithFrame:frame]) {
        
        self.itemSpace = 0;
        self.leadingMargin = 0;
        self.trailingMargin = 0;
        self.style = XWMenuViewStyleDefault;
        self.delegate = delegate;
        self.dataList = [ NSMutableArray<NSObject *> array];
//        [self addSubview:self.myCollectionView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(XWMenuViewStyle)style delegate:(id<XWMenuViewDelegate>)delegate progressMaker:(void (^)(XWPeogressMaker *))makerBlock{
    
    if (self = [super initWithFrame:frame]) {
        
        self.itemSpace = 0;
        self.leadingMargin = 0;
        self.trailingMargin = 0;
        self.style = style;
        self.delegate = delegate;
        makerBlock ? makerBlock(self.maker) : nil;
        self.dataList = [ NSMutableArray<NSObject *> array];
        [self addSubview:self.bottomLine];
        [self bringSubviewToFront:self.bottomLine];
        
        
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.itemSpace = 0;
        self.leadingMargin = 0;
        self.trailingMargin = 0;
        self.style = XWMenuViewStyleDefault;
        self.dataList = [ NSMutableArray<NSObject *> array];
    }
    return self;
}


-(void)updateBottomLineFrameWithProgressValue:(CGFloat) progress andFromPage:(NSInteger)fromPage{
    
    CGRect curRect = [self.rectList[fromPage] CGRectValue];
    
    CGFloat x = curRect.origin.x;
    
    CGFloat width = curRect.size.width;
    
    NSInteger nextIndex = fromPage;
    
    if (progress > 0 && fromPage < self.menuList.count - 1) {
        
        nextIndex = fromPage + 1;
        
        CGRect nextRect = [self.rectList[fromPage + 1] CGRectValue];
        
        width = width + (nextRect.size.width - curRect.size.width) * fabs(progress);
        
        x = x + (nextRect.origin.x - curRect.origin.x) * fabs(progress);
    }else if (progress < 0 && (fromPage - 1) >= 0 ){
        
        nextIndex = fromPage - 1;
        
        CGRect nextRect = [self.rectList[fromPage - 1] CGRectValue];
        
        width = width + (nextRect.size.width - curRect.size.width) * fabs(progress);
        
        x = x + (nextRect.origin.x - curRect.origin.x) * fabs(progress);
    }else if (progress == 0) {
        
        width = curRect.size.width;
    }
    
    for (int i = 0; i < self.menuList.count; i++) {
        
        if ([self.menuList[i] isKindOfClass:[XWMenuTitleData class]]) {
            
            XWMenuTitleData *titleData = (XWMenuTitleData *)self.menuList[i];
            
            [titleData updateTitleColorWithProgress:i == fromPage ? (1- fabs(progress)) : (i == nextIndex ? fabs(progress) : 0)];
        }
    }
    
    [self.myCollectionView reloadData];
    
    if (self.style != XWMenuViewStyleDefault) {
        
        [UIView animateWithDuration:0.32 animations:^{
            
            self.bottomLine.frame = CGRectMake(x, self.frame.size.height - self.maker.progressHeight, width, self.maker.progressHeight);
        }];
    }

    
}

#pragma mark ---- datasource/delegate

-(NSMutableArray *)headerDataListWithCollectionView:(UICollectionView *)collectionView{
    
    
    NSObject *header = [[NSObject alloc] init];
    header.xw_reuseIdentifier = @"UICollectionReusableView";
    header.xw_width = 0.001;
    header.xw_height = 0.001;
    header.cell_secionInset = UIEdgeInsetsMake(0, self.leadingMargin, 0, self.trailingMargin);
    header.cell_minimumLineSpacing = self.itemSpace;
    header.cell_minimumInteritemSpacing = self.itemSpace;
    
    return [[NSMutableArray alloc] initWithObjects:header, nil];
}

-(NSMutableArray *)cellDataListWithCollectionView:(UICollectionView *)collectionView{
    
    return [[NSMutableArray alloc] initWithObjects:self.menuList, nil];
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == self.selectIndex) {
        
        return;
    }
    
    {//代理回调
        if ([self.delegate respondsToSelector:@selector(menuView:didSelesctedIndex:)]) {
            
            [self.delegate menuView:self didSelesctedIndex:indexPath.row];
        }
    }
    
    self.selectIndex = indexPath.row;
   
    
}

#pragma mark ---- set/get

-(void)setDataList:(NSArray<NSObject *> *)dataList{
    
    _dataList = dataList;
    
    NSMutableArray<NSObject *> *list = [ NSMutableArray<NSObject *> array];
    NSMutableArray *rects = [ NSMutableArray array];
    
    CGFloat preX = self.leadingMargin;
    
    for (int i = 0; i < _dataList.count; i ++ ) {
        
        
        NSObject *obj = _dataList[i];
        if ([obj isKindOfClass:[XWMenuTitleData class]]) {
            
            XWMenuTitleData *titleData = (XWMenuTitleData *)obj;
            if (titleData.xw_height == 0) {
                
                titleData.xw_height = self.frame.size.height;
            }
            if (titleData.xw_width <= titleData.titleWidth) {
                
                titleData.xw_width = titleData.titleWidth;
            }
            

            titleData.isSelect = i == self.selectIndex;
            
            CGFloat margin = titleData.xw_width > titleData.titleWidth ? titleData.xw_width - titleData.titleWidth : 0;
            
            [rects addObject:[NSValue valueWithCGRect:CGRectMake(preX + margin / 2.0, self.frame.size.height, titleData.titleWidth,0)]];
            
            preX = preX + titleData.xw_width + self.itemSpace;
            
            
        }else{
            
            [rects addObject:[NSValue valueWithCGRect:CGRectMake(preX, self.frame.size.height, obj.xw_width,0)]];
            
            preX = preX + obj.xw_width + self.itemSpace;
        }
        
        [list addObject:obj];
    }
    
    
    self.rectList = rects;
    
    self.menuList = list;
    
    if (self.selectIndex < self.rectList.count && self.style != XWMenuViewStyleDefault) {
        
        CGRect rect = [self.rectList[self.selectIndex] CGRectValue];
        self.bottomLine.frame = CGRectMake(rect.origin.x, self.frame.size.height - self.maker.progressHeight, rect.size.width, self.maker.progressHeight);
        
    }
    
    [self.myCollectionView reloadData];
    
    
    
}

-(void)setSelectIndex:(NSInteger)selectIndex{
    
    _selectIndex = selectIndex;
    
    for (int i = 0; i < self.menuList.count; i ++ ) {
    
        NSObject *obj = _dataList[i];
        if ([obj isKindOfClass:[XWMenuTitleData class]]) {
            XWMenuTitleData *titleData = (XWMenuTitleData *)obj;
            
            titleData.isSelect = i == _selectIndex;

        }
    }
    
    if (_selectIndex < self.rectList.count && self.style != XWMenuViewStyleDefault) {
        
        CGRect rect = [self.rectList[self.selectIndex] CGRectValue];
        [UIView animateWithDuration:0.35 animations:^{
        
            self.bottomLine.frame = CGRectMake(rect.origin.x, self.frame.size.height - self.maker.progressHeight, rect.size.width, self.maker.progressHeight);
        }];
    }

    [self.myCollectionView reloadData];
    [self.myCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

    
}

-(void)setScrollEnabled:(BOOL)scrollEnabled{
    
    _scrollEnabled = scrollEnabled;
    
    self.myCollectionView.scrollEnabled = scrollEnabled;
}

/**
 *  初始化集合视图
 *
 *  @return   _myCollectionView
 */
-(UICollectionView *)myCollectionView{
    
    if (_myCollectionView) {
        return _myCollectionView;
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _myCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
    _myCollectionView.showsHorizontalScrollIndicator=NO;
    _myCollectionView.showsVerticalScrollIndicator=NO;
    
    _myCollectionView.xw_delegate = self;
    _myCollectionView.xw_dataSource = self;
    _myCollectionView.backgroundColor=[UIColor clearColor];
    [self addSubview:_myCollectionView];
    [self sendSubviewToBack:_myCollectionView];
    return _myCollectionView;
    
}

-(UIView *)bottomLine{
    
    if (_bottomLine == nil) {
        
        _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(self.itemSpace, self.frame.size.height - self.maker.progressHeight, 0, self.maker.progressHeight)];
        
        _bottomLine.backgroundColor = self.maker.progressColor;
        
        _bottomLine.layer.masksToBounds = YES;
        
        _bottomLine.layer.cornerRadius = self.maker.cornerRadius;
        
    }
    
    return _bottomLine;
}


-(void)setBagColor:(UIColor *)bagColor{
    
    _bagColor = bagColor;
    
    self.backgroundColor = bagColor;
    
    self.myCollectionView.backgroundColor = bagColor;
}


@end
