//
//  TSURLSessionManager.m
//  Pro_1031AFN
//
//  Created by Tony on 2018/10/31.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSURLSessionManager.h"
#import <AFNetworking.h>

/*
 AFNetworking核心AFURLSessionManager
 
 1.负责创建和管理NSURLSession
 2.管理NSURLSessionTask
 3.实现NSURLSessionDelegate等协议中的代理方法
 4.使用AFURLSessionManagerTaskDelegate 管理进度
 5.使用_AFURLSessionTaskSwizzling d调剂方法
 6.引入AFSecurityPolicy 保证请求的安全
 7.引入AFNetworkReachabilityManager监控网络状态
 */

@implementation TSURLSessionManager


#pragma mark - 创建和管理NSURLSession
/*
- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    if (!configuration) {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    }
    
    self.sessionConfiguration = configuration;
    
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    self.session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration delegate:self delegateQueue:self.operationQueue];
    
    /// TS:负责序列化响应
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    /// TS:负责身份认证
    self.securityPolicy = [AFSecurityPolicy defaultPolicy];
    
#if !TARGET_OS_WATCH
    /// TS:查看网络链接情况
    self.reachabilityManager = [AFNetworkReachabilityManager sharedManager];
#endif
    
    self.mutableTaskDelegatesKeyedByTaskIdentifier = [[NSMutableDictionary alloc] init];
    
    self.lock = [[NSLock alloc] init];
    self.lock.name = AFURLSessionManagerLockName;
    
    [self.session getTasksWithCompletionHandler:^(NSArray *dataTasks, NSArray *uploadTasks, NSArray *downloadTasks) {
        for (NSURLSessionDataTask *task in dataTasks) {
            [self addDelegateForDataTask:task uploadProgress:nil downloadProgress:nil completionHandler:nil];
        }
        
        for (NSURLSessionUploadTask *uploadTask in uploadTasks) {
            [self addDelegateForUploadTask:uploadTask progress:nil completionHandler:nil];
        }
        
        for (NSURLSessionDownloadTask *downloadTask in downloadTasks) {
            [self addDelegateForDownloadTask:downloadTask progress:nil destination:nil completionHandler:nil];
        }
    }];
    
    return self;
}
 */

/*
 1. 初始化 会话配置(NSURLSessionConfiguration), 默认为 defaultSessionConfiguration
 2. 初始化会话 (session), 并设置会话的代理以及代理队列
 3. 初始化管理响应序列化(AFJSONResponseSerializer) , 安全认证 (AFSecurityPolicy) 以及监控网络状态(AFNetworkReachabilityManager)的实例
 4. 初始化保存data task 的字典 (mutableTaskDelegatesKeyedByTaskIdentifier)
 */





@end
