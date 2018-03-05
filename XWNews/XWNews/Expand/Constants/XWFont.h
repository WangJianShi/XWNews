//
//  XWFont.h
//  XWNews
//
//  Created by serein on 2018/2/24.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#ifndef XWFont_h
#define XWFont_h

// 字体
static NSString *const ping_fang_bold = @"PingFangSC-Semibold";

static NSString *const ping_fang_regular = @"PingFangSC-Regular";
/**系统粗体*/
static NSString *const SYSTEM_BOLD = @"Helvetica-Bold";

//字体
#define  kFont(size)    ([UIFont systemFontOfSize:(ceilf(size))])

//字体-粗体
#define  kBFont(size)   ([UIFont boldSystemFontOfSize:(ceilf(size))])


#endif /* XWFont_h */
