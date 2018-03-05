//
//  XWRequestTool.h
//  XWNews
//
//  Created by serein on 2018/2/8.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XWNetWorkDefine.h"
#import "XWNetWorkTask.h"

@interface XWRequestTool : NSObject

/**
 get/post整合请求
 
 @param url URL
 @param param param
 @param type 请求类型（get/post）
 @param successBlock 成功回调
 @param failureBlock 失败回调
 @return 返回task任务
 */
+ (XWNetWorkTask *)requstWithURL:(NSString*)url
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
+(XWNetWorkTask *)get:(NSString *)url
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
+(XWNetWorkTask *)post:(NSString *)url
               param:(NSDictionary*)param
          successBlock:(XWRequestSuccessBlock)successBlock
          failureBlock:(XWRequestFailureBlock)failureBlock;


@end
