//
//  TSOtherMethod.m
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/28.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSOtherMethod.h"

@implementation TSOtherMethod

- (instancetype)init
{
    if (self = [super init]) {
        [self test];
    }
    return self;
}

/// 线程同步  所谓线程同步即为了防止多个线程抢夺同一资源造成的数据安全问题,所采取的一种措施.
- (void)test
{
    // 1.互斥锁 给需要同步的代码添加一个互斥锁,就可以保证每次只有一个线程访问此代码块.
    @synchronized(self){
        // 需要执行的代码块
    }
    
    // 2. 同步执行
    //GCD 需要一个全局变量的queue 要让所有线程的这个操作都添加到这一个queue中.
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    //NSOperation&NSOperationQueue
    // 重点: 1.全局的NSOperationQueue,所有的操作都添加到一个Queue中.
    // 2.设置queue.maxConcurrentOperationCount 为1
    // 3.如果后续操作需要block中的结果,就需要调用waitUntilFinished,阻塞当前线程.一直等到当前操作完成,才允许执行后面的.waitUntilFinished需要添加到队列之后!
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    [queue addOperation:blockOperation];
    [blockOperation waitUntilFinished];
}

/// 延迟执行  所谓延迟执行就是等待一段时间在执行某段代码.
- (void)delayDone
{
    // perform
    [self performSelector:@selector(run:) withObject:@"abc" afterDelay:3];
    
    // GCD
    // 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 设置延迟 单位为秒
    double delay = 3;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    // NSTime iOS中的一个计时器类
    [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        NSLog(@"%@", [NSThread currentThread]);
    }];
}

- (void)run:(NSObject *)object
{
    
}


// 单例模式
static id _instance;
+ (instancetype)sharedTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TSOtherMethod alloc] init];
    });
    
    return _instance;
}

// 从其他线程回到主线程
- (void)returnMainThread
{
    // NSThread
    [self performSelectorOnMainThread:@selector(run:) withObject:@"def" waitUntilDone:NO];
    
    // GCD
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    // NSOperationQueue
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    }];
    
}




@end











