//
//  XWRightPicLayout.m
//  XWNews
//
//  Created by serein on 2018/2/27.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWRightPicLayout.h"

@implementation XWRightPicLayout

-(XWRightPicLayout *)creatRightPicLayout{
    
    XWRightPicLayout *rightPicLayout = [[XWRightPicLayout alloc] init];
    
    rightPicLayout.titleLayout = [XWTextLayout createWithText:@"心梗发生前，身体会向你发出5个警告信号，早早看懂能预防" fontSize:17 color:[UIColor blackColor] fitWithSize:CGSizeMake(kScreenWidth - kScreenWidth * 0.28 - 35, 42)];
    
    rightPicLayout.subTitleLayout = [XWTextLayout createWithText:@"寻医问药网 99评论 前天12:00" fontSize:13 color:[UIColor lightGrayColor] fitWithSize:CGSizeMake(kScreenWidth - kScreenWidth * 0.28 - 35 - 25, 15)];
    
    return rightPicLayout;
}

@end
