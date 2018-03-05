//
//  XWNetWorkTask.m
//  YCSteel
//
//  Created by serein on 2017/12/18.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWNetWorkTask.h"

@interface XWNetWorkTask ()

//NSURLSessionDownloadTask NSURLSessionDataTask
@property(nonatomic , weak) id task;

@end

@implementation XWNetWorkTask


-(instancetype) initWithTask:(id) task{
    self = [super init];
    if (self) {
        self.task =  task;
    }
    return self;
}

// 取消取请求
- (void)cancel{
    if ([self.task isKindOfClass:[NSURLSessionDataTask class]]) {
        NSURLSessionDataTask * task = ( NSURLSessionDataTask *)self.task;
        [task cancel];
    }else  if([self.task isKindOfClass:[NSURLSessionDownloadTask class]]){
        NSURLSessionDownloadTask * task = ( NSURLSessionDownloadTask *)self.task;
        [task cancel];
    }
}
// 暂停请求
- (void)suspend{
    if ([self.task isKindOfClass:[NSURLSessionDataTask class]]) {
        NSURLSessionDataTask * task = ( NSURLSessionDataTask *)self.task;
        [task suspend];
    }else  if([self.task isKindOfClass:[NSURLSessionDownloadTask class]]){
        NSURLSessionDownloadTask * task = ( NSURLSessionDownloadTask *)self.task;
        [task suspend];
    }
}
// 恢复请求
- (void)resume{
    if ([self.task isKindOfClass:[NSURLSessionDataTask class]]) {
        NSURLSessionDataTask * task = ( NSURLSessionDataTask *)self.task;
        [task resume];
    }else  if([self.task isKindOfClass:[NSURLSessionDownloadTask class]]){
        NSURLSessionDownloadTask * task = ( NSURLSessionDownloadTask *)self.task;
        [task resume];
    }
}

-(BOOL) isRequesting{
    if ([self.task isKindOfClass:[NSURLSessionDataTask class]]) {
        NSURLSessionDataTask * task = ( NSURLSessionDataTask *)self.task;
        return task.state == NSURLSessionTaskStateRunning;
    }else  if([self.task isKindOfClass:[NSURLSessionDownloadTask class]]){
        NSURLSessionDownloadTask * task = ( NSURLSessionDownloadTask *)self.task;
        return task.state == NSURLSessionTaskStateRunning;
    }
    return false;
}


@end

