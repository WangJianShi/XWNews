//
//  XWMenuView.h
//  XWMenuView
//
//  Created by 王剑石 on 16/8/13.
//  Copyright © 2016年 Avatar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XWMenuTitleData.h"

typedef enum : NSUInteger {
    /**
     *  默认
     */
    XWMenuViewStyleDefault,
    /**
     *  line(下划线)
     */
    XWMenuViewStyleLine,
    /**
     *  Slide(滑块)
     */
    SegmentHeadStyleSlide
} XWMenuViewStyle;



@class XWMenuView;

@protocol XWMenuViewDelegate <NSObject>


@optional

-(void)menuView:(XWMenuView *)menuView didSelesctedIndex:(NSInteger)index;

@end


@interface XWPeogressMaker : NSObject

@property (nonatomic, strong) UIColor *progressColor;

@property (nonatomic, assign) CGFloat progressHeight;

@property (nonatomic,assign) CGFloat cornerRadius;



@end

@interface XWMenuView : UIView


@property(assign, nonatomic) id<XWMenuViewDelegate> delegate;

@property (nonatomic) NSInteger selectIndex;//初始选择下标

@property (nonatomic, strong) UIColor *bagColor;

@property (nonatomic, strong) NSArray<NSObject *> *dataList;

@property (nonatomic, assign) CGFloat leadingMargin;

@property (nonatomic, assign) CGFloat trailingMargin;

@property (nonatomic) CGFloat itemSpace;

@property (nonatomic, assign) BOOL scrollEnabled;

//style为default
-(instancetype)initWithFrame:(CGRect)frame delegate:(id<XWMenuViewDelegate>)delegate;

//style不为default时maker生效
-(instancetype)initWithFrame:(CGRect)frame style:(XWMenuViewStyle)style  delegate:(id<XWMenuViewDelegate>)delegate progressMaker:(void (^) (XWPeogressMaker *maker))makerBlock;


-(void)updateBottomLineFrameWithProgressValue:(CGFloat) progress andFromPage:(NSInteger)fromPage;



@end
