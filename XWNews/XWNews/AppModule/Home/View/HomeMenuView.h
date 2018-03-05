//
//  HomeMenuView.h
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeMenuView : UIView<XWMenuViewDelegate>

@property (nonatomic,weak) id<XWMenuViewDelegate> delegate;

@property (nonatomic,strong) NSArray<NSString *> *titles;

-(void)updateProgressValue:(CGFloat) progress andFromPage:(NSInteger)fromPage;

-(void)updateSelectValue:(NSInteger) index ;

@end
