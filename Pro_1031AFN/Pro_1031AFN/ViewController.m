//
//  ViewController.m
//  Pro_1031AFN
//
//  Created by Tony on 2018/10/31.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 使用NSURLSession发送请求最简单的一段代码
    [self useSessionRequest];
    
    // 使用AFN发送请求
    [self useAFNRequest];
    
    
}

- (void)useSessionRequest
{
    /*
     使用NSURLSession进行HTTP请求并获得数据
     
     1.实例化一个NSURLRequest/NSMutableURLRequest,设置URL
     2.通过 -sharedSession 方法获取NSURLSession
     3.在session上调用 -dataTaskWithRequest:completionHandle:方法 返回一个NSURLSessionDataTask
     4.向data task 发送消息 -resume, 开始执行这个任务
     5.在completionHandle中将数据编码,返回字符串
     */
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[[NSURL alloc] initWithString:@"https://github.com"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *dataStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", dataStr);
    }];
    
    [task resume];
}

- (void)useAFNRequest
{
    /*
     使用AFNetworking 发送HTTP请求,有两个步骤
     1. 以服务器的主机地址或者域名生成一个AFHTTPSessionManager的实例
     2. 调用 -GET: parameters:progress:success:failure: 方法
     
     */
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[[NSURL alloc]initWithString:@"hostname"]];
    [manager GET:@"relative_url" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    /*
     - [AFHTTPSessionManager initWithBaseURL:]
        - [AFHTTPSessionManager initWithBaseURL:sessionConfiguration:]
            - [AFURLSessionManager initWithSessionConfiguration:]
            - [NSURLSession sessionWithConfiguration:delegate:delegateQueue:]
            - [AFJSONResponseSerializer serializer] // 负责序列化响应
            - [AFSecurityPolicy defaultPolicy] // 负责身份认证
            - [AFNetworkReachabilityManager sharedManager] // 查看网络连接情况
        - [AFHTTPRequestSerializer serializer] // 负责序列化请求
        - [AFJSONResponseSerializer serializer] // 负责序列化响应
     
     ·AFURLSessionManager 是AFHTTPSessionManager的父类
     ·AFURLSessionManager 负责生产NSURLSession的实例,管理AFSecurityPolicy和AFNetworkingReachabilityManager,来保证请求的安全和查看网络连接情况,它有一个AFJSONResponseSerializer的实例来序列化HTTP响应
     ·AFHTTPSessionManager有着自己的AFHTTPRequestSerializer和AFJOSNResponseSerializer来管理请求和响应的序列化,同时以来父类的借口保证安全、监控网络状态,实现发出HTTP请求这一核心功能
     */
    
    
    /*
     - [AFHTTPSessionManager GET:parameters:process:success:failure:]
        - [AFHTTPSessionManager dataTaskWithHTTPMethod:parameters:uploadProgress:downloadProgress:success:failure:] // 返回 NSURLSessionDataTask #1
            - [AFHTTPRequestSerializer requestWithMethod:URLString:parameters:error:] // 返回 NSMutableURLRequest
            - [AFURLSessionManager dataTaskWithRequest:uploadProgress:downloadProgress:completionHandler:] // 返回 NSURLSessionDataTask #2
                - [NSURLSession dataTaskWithRequest:] // 返回 NSURLSessionDataTask #3
                - [AFURLSessionManager addDelegateForDataTask:uploadProgress:downloadProgress:completionHandler:]
                    - [AFURLSessionManagerTaskDelegate init]
                    - [AFURLSessionManager setDelegate:forTask:]
     - [NSURLSessionDataTask resume]
     */
    
    
}


@end
