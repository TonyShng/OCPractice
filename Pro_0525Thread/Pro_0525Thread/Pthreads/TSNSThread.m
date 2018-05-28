//
//  TSNSThread.m
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSNSThread.h"

@implementation TSNSThread

- (instancetype)init
{
    if (self = [super init]) {
        [self test];
    }
    return self;
}

/**
 NSThread是苹果封装后,完全面向对象的.可以直接操控线程对象. 但是生命周期还是需要手动管理.所以也只是偶尔用用.
 */
- (void)test
{
    // 创建一个线程
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(doSomeThing:) object:@"NSThread1"];
    
    // 线程启动
    [thread start];
    
    // 创建并自动启动
    [NSThread detachNewThreadSelector:@selector(doSomeThing:) toTarget:self withObject:@"NSThread2"];
    
    // NSObject的方法创建并自动启动一个线程
    [NSObject performSelectorInBackground:@selector(doSomeThing:) withObject:@"NSThread3"];
    
    // 取消线程
    [thread cancel];
    
    // 判断线程是否在执行
//    thread.executing;
    
    // 判断线程是否执行完成
//    thread.isFinished;
    
    // 判断线程是否取消
//    thread.isCancelled;
    
    // 设置线程名字
//    thread.name = @""; [thread setName:@""];
    
    // 查看线程名字
//    thread.name;
    
    // 获取当前线程信息
//    [NSThread currentThread];
    
    // 获取主线程信息
//    [NSThread mainThread];
    
    // 使当前线程暂停一段时间 或 到某个时刻
//    [NSThread sleepForTimeInterval:0.5];
    
//    [NSThread sleepUntilDate:[NSData data]];
    
    
}

- (void)doSomeThing:(NSObject *)object
{
    NSLog(@"currentThread == %@ --- %@",[NSThread currentThread], object);
}


@end
