//
//  XWCollectionView.h
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    XWCollectionViewRefreshTypeNone,// 无刷新
    XWCollectionViewRefreshTypeHeaderFooter,// 头部和尾部都可刷新
    XWCollectionViewRefreshTypeHeader,//仅头部可刷新
    XWCollectionViewRefreshTypeFooter //仅尾部可刷新
} XWCollectionViewRefreshType; // 刷新类型

@interface XWCollectionView : UICollectionView

@property (nonatomic,assign) XWCollectionViewRefreshType refreshType;

-(void)beginRefreshing;

@end
