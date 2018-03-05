//
//  XWCollectionView.m
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWCollectionView.h"
#import "MJDrawRefreshHeader.h"
#import "MJDrawRefreshFooter.h"

@implementation XWCollectionView

-(instancetype)init{
    
    if (self = [super init]) {
        
#ifdef __IPHONE_11_0
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
#ifdef __IPHONE_11_0
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
#ifdef __IPHONE_11_0
        if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            if (@available(iOS 11.0, *)) {
                self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        }
#endif
    }
    
    return self;
}

-(void)xw_endRefreshingWithWidgetState:(XWWidgetState)state{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (state == XWWidgetStateRequestNoMoreData) {
            
            if (self.mj_footer != nil) {
                
                [self.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            if (self.mj_header != nil) {
                
                [self.mj_header endRefreshing];
            }
        }else {
            
            if (self.mj_footer != nil) {
                
                [self.mj_footer endRefreshing];
                
            }
            
            if (self.mj_header != nil) {
                
                [self.mj_header endRefreshing];
            }
        }
        [self xw_reloadWidgets];
    
    });
    
}

-(void)setRefreshType:(XWCollectionViewRefreshType)refreshType{
    
    _refreshType = refreshType;
    
    switch (refreshType) {
       
        case XWCollectionViewRefreshTypeHeader:
        {
            self.mj_header = [self headerRefresh];
            self.mj_footer = nil;
        }
            break;
        case XWCollectionViewRefreshTypeHeaderFooter:
        {
            self.mj_header = [self headerRefresh];
            self.mj_footer = [self footerRefresh];
        }
            break;
        case XWCollectionViewRefreshTypeFooter:
        {
            self.mj_header = nil;
            self.mj_footer = [self footerRefresh];
        }
            break;
            
        default:{
            self.mj_header = nil;
            self.mj_footer = nil;
        }
            break;
    }
}

-(void)beginRefreshing{

    [self.mj_header beginRefreshing];
    
}

-(MJRefreshGifHeader *)headerRefresh{
    
        KWeakSelf;
        MJDrawRefreshHeader  *gifHeader = [MJDrawRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf xw_collectionViewHeaderRefresh];
            dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
            dispatch_after(timer, dispatch_get_main_queue(), ^{
                [weakSelf.mj_header endRefreshing];
            });
        }];
        NSMutableArray *headerImages = [NSMutableArray array];
        for (int i = 1; i < 16; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%d",i]];
            [headerImages addObject:image];
        }
        [gifHeader setTitle:@"下拉推荐" forState:MJRefreshStateIdle];
        [gifHeader setTitle:@"松开推荐" forState:MJRefreshStatePulling];
        [gifHeader setTitle:@"推荐中" forState:MJRefreshStateRefreshing];
        gifHeader.lastUpdatedTimeLabel.hidden = YES;
        gifHeader.automaticallyChangeAlpha = YES;
        [gifHeader setImages:headerImages forState:MJRefreshStateIdle];
        [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    
    return gifHeader;
    
}

-(MJRefreshAutoGifFooter *)footerRefresh{
    
    KWeakSelf;
    MJDrawRefreshFooter *mjFooter = [MJDrawRefreshFooter footerWithRefreshingBlock:^{
        
        [weakSelf xw_collectionViewFooterRefresh];
        dispatch_time_t timer = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
        dispatch_after(timer, dispatch_get_main_queue(), ^{
            
            [weakSelf.mj_footer endRefreshing];
            weakSelf.mj_footer.pullingPercent = 0.0;
        });
    }];
    
    NSMutableArray *footerImages = [NSMutableArray array];
    for (int i = 1; i < 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"sendloading_18x18_%d",i]];
        [footerImages addObject:image];
    }
    [mjFooter setTitle:@"上拉加载数据" forState:MJRefreshStateIdle];
    [mjFooter setTitle:@"正在努力加载" forState:MJRefreshStatePulling];
    [mjFooter setTitle:@"正在努力加载" forState:MJRefreshStateRefreshing];
    [mjFooter setTitle:@"没有更多数据啦" forState:MJRefreshStateNoMoreData];
    [mjFooter setImages:footerImages forState:MJRefreshStateIdle];
    [mjFooter setImages:footerImages forState:MJRefreshStateRefreshing];
    mjFooter.automaticallyChangeAlpha = YES;
    
    return mjFooter;
}


@end
