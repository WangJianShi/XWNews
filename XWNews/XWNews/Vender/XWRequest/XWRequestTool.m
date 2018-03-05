//
//  XWRequestTool.m
//  XWNews
//
//  Created by serein on 2018/2/8.
//  Copyright © 2018年 王剑石. All rights reserved.
//

#import "XWRequestTool.h"
#import "AFNetworking.h"

@implementation XWRequestTool

+(XWNetWorkTask *)requstWithURL:(NSString *)url
                        param:(NSDictionary*)param
                    netWorkType:(XWNetWorkType)type
                   successBlock:(XWRequestSuccessBlock)successBlock
                   failureBlock:(XWRequestFailureBlock)failureBlock{
    
    if (type == XWNetWorkGET) {
        
        return [self get:url param:param successBlock:successBlock failureBlock:failureBlock];
    }else{
        
        return [self post:url param:param successBlock:successBlock failureBlock:failureBlock];
    }
}

+(XWNetWorkTask *)post:(NSString *)url
               param:(NSDictionary*)param
          successBlock:(XWRequestSuccessBlock)successBlock
          failureBlock:(XWRequestFailureBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 20;
    //设置请求头
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
   
    NSURLSessionDataTask *xwTask = [manager POST:url parameters:param  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        successBlock ? successBlock(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock ? failureBlock(error) : nil;
    }];
    
    return [[XWNetWorkTask alloc] initWithTask:xwTask];
}

+(XWNetWorkTask *)get:(NSString *)url
              param:(NSDictionary*)param
         successBlock:(XWRequestSuccessBlock)successBlock
         failureBlock:(XWRequestFailureBlock)failureBlock{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 20;
    //设置请求头
    [manager.requestSerializer setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *xwTask = [manager GET:url parameters:param  progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        
        successBlock ? successBlock(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
    
    return [[XWNetWorkTask alloc] initWithTask:xwTask];
}


@end

