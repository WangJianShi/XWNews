//
//  XWNetWorkManager.h
//  YCSteel
//
//  Created by serein on 2017/12/18.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWNetWorkTask.h"
#import "XWRequestTool.h"

@interface XWNetWorkManager : NSObject

/**
 *  url 的 前缀  比如 服务器域名 本地就是http://localhost:8888/
 */

@property(nonatomic , copy) NSString * rootURL;

/**
 *  items
 */
@property(nonatomic,strong) NSMutableArray<XWNetWorkTask *> *items;

/**
 *  单例
 *
 *  @return 单例对象
 */
+ (XWNetWorkManager *)sharedInstance;

/**
 get/post整合请求
 
 @param url URL
 @param param param
 @param type 请求类型（get/post）
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @return 返回task任务
 */
-(XWNetWorkTask *)requstWithURL:(NSString*)url
                          param:(NSDictionary*)param
                     netWorkType:(XWNetWorkType)type
                    successBlock:(XWRequestSuccessBlock)successBlock
                    failureBlock:(XWRequestFailureBlock)failureBlock;


/**
 get请求
 
 @param url url
 @param param param
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @return 返回task任务
 */
-(XWNetWorkTask *)get:(NSString *)url
               param:(NSDictionary*)param
         successBlock:(XWRequestSuccessBlock)successBlock
         failureBlock:(XWRequestFailureBlock)failureBlock;


/**
 post请求
 
 @param url url
 @param param param
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @return 返回task任务
 */
-(XWNetWorkTask *)post:(NSString *)url
                param:(NSDictionary*)param
          successBlock:(XWRequestSuccessBlock)successBlock
          failureBlock:(XWRequestFailureBlock)failureBlock;


//------------------根据项目配置--------------------//
-(NSDictionary *) getResultWithResponseData:(id) data;

-(NSError * ) getErrorWithResponseData:(NSDictionary *) data;

-(NSError * ) getErrorWithRawError:(NSError *)error;



@end
