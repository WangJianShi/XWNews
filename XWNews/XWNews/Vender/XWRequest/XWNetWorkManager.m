//
//  XWNetWorkManager.m
//  YCSteel
//
//  Created by serein on 2017/12/18.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWNetWorkManager.h"


@implementation XWNetWorkManager

+ (XWNetWorkManager *)sharedInstance
{
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - 发送 GET 请求的方法


-(XWNetWorkTask *)get:(NSString *)url
              param:(NSDictionary*)param
         successBlock:(XWRequestSuccessBlock)successBlock
         failureBlock:(XWRequestFailureBlock)failureBlock{
    
    return [self requstWithURL:url param:param netWorkType:XWNetWorkGET successBlock:successBlock failureBlock:failureBlock];
}

#pragma mark - 发送 POST 请求的方法

-(XWNetWorkTask *)post:(NSString *)url
               param:(NSDictionary*)param
          successBlock:(XWRequestSuccessBlock)successBlock
          failureBlock:(XWRequestFailureBlock)failureBlock{
    
    return [self requstWithURL:url param:param netWorkType:XWNetWorkPOST successBlock:successBlock failureBlock:failureBlock];
}

#pragma mark -
#pragma mark   request

-(XWNetWorkTask *)requstWithURL:(NSString *)url
                          param:(NSDictionary*)param
                    netWorkType:(XWNetWorkType)type
                   successBlock:(XWRequestSuccessBlock)successBlock
                   failureBlock:(XWRequestFailureBlock)failureBlock{
    

    __weak typeof(&*self) weakSelf = self;
    NSString *absoluteUrl = [self getAbsoluteUrlWithUrl:url];
    XWNetWorkTask *task = [XWRequestTool requstWithURL:absoluteUrl param:param netWorkType:type successBlock:^(id jsonDic){
        
        NSDictionary *resultDic = [weakSelf getResultWithResponseData:jsonDic];
        
        if (resultDic) {
            
            NSError *error = [self getErrorWithResponseData:resultDic];
            if (error) {
                 failureBlock ? failureBlock(error) : nil;
            }else{
                 successBlock ? successBlock(resultDic) : nil ;
            }
        }else{
      
            failureBlock ? failureBlock([NSError errorWithDomain:@"数据解析错误" code:-1 userInfo:nil]) : nil;
        }
        
        
    } failureBlock:^(NSError *error){
        
        NSError *resultError = [weakSelf getErrorWithRawError:error];
        
        failureBlock ? failureBlock(resultError) : nil;
    }];
    
    [self.items addObject:task];
    
    return task;
}

#pragma mark --  可重写（根据自己的需求配置）

-(NSString *) getAbsoluteUrlWithUrl:(NSString *)url{
    if (![url hasPrefix:@"http"] && self.rootURL) {
        return [[self.rootURL stringByAppendingString:url] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    }
    return [url stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}

-(NSDictionary *) getResultWithResponseData:(id) data {
    
    return data;
}

-(NSError * ) getErrorWithResponseData:(NSDictionary *) data{
    return nil;
}


-(NSError * ) getErrorWithRawError:(NSError *)error{
    return error;
}


/**
 *   取消所有正在执行的网络请求项
 */
- (void)cancelAllNetItems
{
    for (XWNetWorkTask *task in self.items) {
        
        if (task.isRequesting) {
            
            [task cancel];
        }
    }
    
}

- (void)netWorkWillDealloc:(XWNetWorkTask *)itme
{
    
    if (![self.items containsObject:itme] || itme.isRequesting) {
        
        return;
    }
    [self.items removeObject:itme];
    
}


@end
