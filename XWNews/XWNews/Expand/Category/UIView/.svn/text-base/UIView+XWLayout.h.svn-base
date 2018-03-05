//
//  UIView+XWLayout.h
//  StealTime
//
//  Created by 王剑石 on 2017/7/28.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XWLayout)


//**frame accessors */
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y


-(void)layout_verticalCenter;         //相对于父视图垂直居中
-(void)layout_horizontalCenter;       //相对于父视图水平居中

//相对父视图的位置关系
-(void)margin_top:(float)toppix;                    //距离父视图的上边距
-(void)margin_left:(float)leftpix;                  //距离父视图的左边距
-(void)margin_bottom:(float)bottompix;              //距离父视图的下边距
-(void)margin_rigth:(float)rigthpix;                //距离父视图的右边距


//同级相对位置关系
-(void)toleftView:(UIView *)view ofPix:(float)sizepix;    //距离某视图的左部边缘距离
-(void)totopView:(UIView *)view ofPix:(float)sizepix;     //距离某视图的上部边缘距离
-(void)torigthView:(UIView *)view ofPix:(float)sizepix;   //距离某视图的右部边缘距离
-(void)tobottomView:(UIView *)view ofPix:(float)sizepix;  //距离某视图的下部边缘距离

//同级对齐方式
-(void)aligntopwithview:(UIView *)view;       //与某视图的上部边缘对齐
-(void)alignbottomwithview:(UIView *)view;    //与某视图的下部边缘对齐
-(void)alignleftwithview:(UIView *)view;      //与某视图的左部边缘对齐
-(void)alignrigthwithview:(UIView *)view;     //与某视图的右部边缘对齐

@end
