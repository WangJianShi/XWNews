//
//  XWNetWorkTask.h
//  YCSteel
//
//  Created by serein on 2017/12/18.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XWNetWorkTask : NSObject

-(instancetype) initWithTask:(id) task;

/**
 *  取消请求
 *  注意：取消后会马上调用response闭包 error.code == -999
 */
- (void)cancel;
// 暂停请求
- (void)suspend;
// 恢复请求
- (void)resume;
/**
 *  是否在请求中
 *
 *  @return 是 否
 */
-(BOOL) isRequesting;

@end
