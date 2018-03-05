//
//  XWRightPicLayout.h
//  XWNews
//
//  Created by serein on 2018/2/27.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWRightPicLayout : NSObject

@property (nonatomic,strong) XWTextLayout *titleLayout;

@property (nonatomic,strong) XWTextLayout *subTitleLayout;

-(XWRightPicLayout *)creatRightPicLayout;

@end
