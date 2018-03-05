//
//  XWNetWorkModel.h
//  YCSteel
//
//  Created by serein on 2017/12/20.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWNetWorkManager.h"

@interface XWNetWorkModel : NSObject

@property (nonatomic, strong) NSString *requestURL;    //请求链接(必须赋值或者重写get方法)

@property (nonatomic,strong) NSDictionary *param;       //参数

@property (nonatomic, strong) NSString *requestType;    //请求方式  "GET" 和 "POST" 两种(默认 "POST")

@property (nonatomic, assign) BOOL isRequesting;        // 是否在请求中


/**
 * 请求
 */
- (void)requestToLoadWithSuccess:(XWRequestSuccessBlock)successBlock
                         failure:(XWRequestFailureBlock)failureBlock;


/**
 * 请求
 */
- (void)requestToLoadWithParam:(id)param Success:(XWRequestSuccessBlock)successBlock
                       failure:(XWRequestFailureBlock)failureBlock;


/**
 *  网络请求单例
 *  @return 返回单例对象
 */
-(XWNetWorkManager * ) getHttpRequestManager;

/**
 请求前最后一次检查参数的机会

 @return 是否开始请求
 */
-(BOOL) checkParamWhenStartRequest;

/**
 * 可重写，对获取的数据最最后一次处理(result正常是字典格式)
 */
-(id) modifyRequestFinishDataWithResult:(id)result;

-(NSError *) modifyRequestFinishDataWithError:(NSError *)error;


@end
