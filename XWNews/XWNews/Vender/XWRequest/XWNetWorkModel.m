//
//  XWNetWorkModel.m
//  YCSteel
//
//  Created by serein on 2017/12/20.
//  Copyright © 2017年 wangjianshi. All rights reserved.
//

#import "XWNetWorkModel.h"

@interface XWNetWorkModel ()

@property (nonatomic, strong)  XWNetWorkTask* requestOperation;

@property (nonatomic, copy) XWRequestSuccessBlock successBlock;

@property (nonatomic, copy) XWRequestFailureBlock failureBlock;


@end

@implementation XWNetWorkModel

-(NSString *)requestURL{
    
    if (_requestURL == nil) {
        
        _requestURL = @"";
    }
    
    return _requestURL;
}

-(NSDictionary *)param{
    
    if (_param == nil) {
        
        _param = @{};
    }
    
    return _param;
}


-(NSString *)requestType{
    
    if (_requestType == nil) {
        
        _requestType = @"POST";
    }
    
    return _requestType;
}

-(void)requestToLoadWithSuccess:(XWRequestSuccessBlock)successBlock failure:(XWRequestFailureBlock)failureBlock{
    
    self.successBlock = successBlock;
    self.failureBlock = failureBlock;
    [self requestToLoad];
    
}

-(void)requestToLoadWithParam:(id)param Success:(XWRequestSuccessBlock)successBlock failure:(XWRequestFailureBlock)failureBlock{

    if ([param isKindOfClass:[NSDictionary class]] || [param isKindOfClass:[NSMutableDictionary class]]){
        
        self.param= param;
    }

    [self requestToLoadWithSuccess:successBlock failure:failureBlock];
}

//加载
-(void) requestToLoad{
    
    if (self.isRequesting) {
        [self cancelRequest];
    }
    
    [self requestToServerWithParam:self.param];
    
}



//向服务器请求
-(void) requestToServerWithParam:(id) param{
    NSString * url = [self requestURL];
    NSString * requestType = [self requestType];
    if (url) {
        __weak typeof(&*self) weakSelf = self;
        self.isRequesting = true;
        self.requestOperation = [[self getHttpRequestManager]  requstWithURL:url param:param netWorkType:[requestType isEqualToString:@"POST"] ? XWNetWorkPOST : XWNetWorkGET successBlock:^(id result){
            
            weakSelf.isRequesting = NO;
            id returnData = [weakSelf modifyRequestFinishDataWithResult:result];
            weakSelf.successBlock ? weakSelf.successBlock(returnData) : nil;
            
            
        } failureBlock:^(NSError *error){
            
            weakSelf.isRequesting = NO;
            NSError *returnError = [weakSelf modifyRequestFinishDataWithError:error];
            weakSelf.failureBlock ? weakSelf.failureBlock(returnError) : nil;
        }];
 
    }
}

-(BOOL) checkParamWhenStartRequest{
    
    return YES;
}

-(id) modifyRequestFinishDataWithResult:(id)result{
    return result;   // 默认不修改
}

-(NSError *) modifyRequestFinishDataWithError:(NSError *)error{
    return error;   // 默认不修改
}

/**
 *  取消网络请求
 */
-(void) cancelRequest{
    [self.requestOperation cancel];
}
/**
 *  网络请求单例
 *  @return 返回单例对象
 */
-(XWNetWorkManager * ) getHttpRequestManager{
    return [XWNetWorkManager sharedInstance];
}

@end
