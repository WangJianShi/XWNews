//
//  XWNetWorkDefine.h
//  YCSteel
//
//  Created by serein on 2017/12/18.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#ifndef XWNetWorkDefine_h
#define XWNetWorkDefine_h

/**
 *  请求类型
 */
typedef enum {
    XWNetWorkGET = 1,   /**< GET请求 */
    XWNetWorkPOST       /**< POST请求 */
} XWNetWorkType;

/**
 *  网络请求超时的时间
 */
#define XWNETWORK_TIME_OUT 20


#if NS_BLOCKS_AVAILABLE


/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^XWRequestSuccessBlock)(id returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^XWRequestFailureBlock)(NSError *error);

#endif


#endif /* XWNetWorkDefine_h */
