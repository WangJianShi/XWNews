//
//  XWLabel.h
//  XWNews
//
//  Created by serein on 2018/2/23.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "YYLabel.h"
#import "XWTextLayout.h"

@interface XWAsyncLabel : YYLabel

/**
 *  用create 来构造对象
 */

+(instancetype) create;


/**
  通过设置这个文本布局 显示内容

 @param textLayout XWTextLayout
 */
-(void)setTextWithTextLayout:(XWTextLayout *)textLayout;

@end
