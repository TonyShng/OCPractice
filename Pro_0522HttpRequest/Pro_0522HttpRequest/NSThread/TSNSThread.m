//
//  TSNSThread.m
//  Pro_0522HttpRequest
//
//  Created by Tony on 2018/5/23.
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


- (void)test
{
    /* --- NSThread创建线程 --- */
    // 1. init 需要start
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(doSomeThing1:) object:@"NSThread1"];
    // 线程加入线程池,等待CPU调度,时间很快,几乎是立即执行
    [thread1 start];
    
    // 2. 创建好后自动执行
    [NSThread detachNewThreadSelector:@selector(doSomeThing2:) toTarget:self withObject:@"NSThread2"];
    
    // 3. 隐式创建,直接启动
    [self performSelectorInBackground:@selector(doSomeThing3:) withObject:@"NSThread3"];
    
    
    /* --- 类方法 --- */
    // 返回当前线程
    [NSThread currentThread];
    
    // 堵塞休眠
    // 休眠多久
    [NSThread sleepForTimeInterval:2];
    // 休眠到指定日期
    [NSThread sleepUntilDate:[NSDate date]];
    
    /// 补充
    // 退出线程
    [NSThread exit];
    // 判断当前线程是否是主线程
    [NSThread isMainThread];
    // 判断当前线程是否是多线程
    [NSThread isMultiThreaded];
    // 主线程对象
    NSThread *thread = [NSThread mainThread];
    
    /// NSthread的一些属性
    // 线程是否在执行
    BOOL isExecuting = thread.isExecuting;
    // 线程是否被取消
    BOOL isCancelled = thread.isCancelled;
    // 线程是否完成
    BOOL isFinishied = thread.isFinished;
    // 是否是主线程
    BOOL isMainThread = thread.isMainThread;
    // 线程的优先级 取值范围0.0到1.0 默认为0.5  1.0表示最高优先级,优先级高,CPU调度的频率高
    double priority = thread.threadPriority;
    NSLog(@"%d%d%d%d%.1f", isExecuting, isCancelled, isFinishied, isMainThread, priority);

}

- (void)doSomeThing1:(NSObject *)object
{
    NSLog(@"object1 \t %@", object);
    NSLog(@"currentThread1 \t %@", [NSThread currentThread]);
}


- (void)doSomeThing2:(NSObject *)object
{
    NSLog(@"object2 \t %@", object);
    NSLog(@"currentThread2 \t %@", [NSThread currentThread]);
}

- (void)doSomeThing3:(NSObject *)object
{
    NSLog(@"object3 \t %@", object);
    NSLog(@"currentThread3 \t %@", [NSThread currentThread]);
}


@end
