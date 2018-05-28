//
//  ViewController.m
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test];
//    [self queueGroup];
//    [self addTask];
//    [self createQueue];
    [self addDependency];
}

- (void)test
{
    // 主队列同步 死锁现象
//    NSLog(@"之前 - %@", [NSThread currentThread]);
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"sync - %@", [NSThread currentThread]);
//    });
//    NSLog(@"之后 - %@", [NSThread currentThread]);
    
    
    //这是一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 异步操作
    dispatch_async(queue, ^{
        NSLog(@"sync之前 - %@", [NSThread currentThread]); // 第一个执行  非主线程
        // 同步操作 将block中的任务立刻加入到队列中执行.但是因为目前是串行队列,且上面的异步操作中的任务还没执行完成,又将同步操作的任务加入到其中,故而会引起死锁现象.
        dispatch_sync(queue, ^{
            NSLog(@"sync - %@", [NSThread currentThread]);  // 第二个执行 非主线程
        });
        NSLog(@"sync之后 - %@", [NSThread currentThread]);  // 第三个执行 非主线程
    });
    
    
}

- (void)queueGroup
{
    // 队列组可以将很多队列添加到一个组里,这样做的好处是,当这个组里所有队列都执行完了,队列组会通过一个方法通知我们.
    
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    // 创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 多次使用队列组的方法执行任务,只有异步方法
    
    // 3.1执行3次循环
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"group01 - %@", [NSThread currentThread]);
        }
    });
    
    // 3.2执行8次循环
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 8; i++) {
            NSLog(@"group02 - %@", [NSThread currentThread]);
        }
    });
    
    // 3.3执行5次循环
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"group03 - %@", [NSThread currentThread]);
        }
    });
    
    //
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成");
    });
    
}

- (void)addTask
{
    // NSOperation只是一个抽象类,不能封装任务. 但是它有两个子类可以进行封装任务.分别是NSInvocationOperation和NSBlockOperation.创建一个Operation后,需要调用start方法启动,它会默认在当前队列*同步执行*.如果中途取消一个任务,可以调用cancel方法进行取消.
    
    // NSInvocationOperation初始化
//    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperationTask:) object:@"invocationOperation"];
//    [invocationOperation start];
    
    
    // NSBlockOperation初始化
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@ ---- ", [NSThread currentThread]);
    }];
    
    // addExecutionBlock: 方法可以给NSBlockOperation添加多个执行block,这样Operation中的任务会并发执行,他会在主线程和其他多个线程执行任务.
    for (int i = 0; i < 5; i++) {
        [blockOperation addExecutionBlock:^{
            NSLog(@"第%d次执行 -- %@", i, [NSThread currentThread]);
        }];
    }
    
    [blockOperation start];
}

- (void)createQueue
{
    // 主队列 主线程,特殊的线程,必须串行.所以添加到主队列中的任务会一个接着一个的排着队在主线程中执行.
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    
    // 其他队列 其他队列中的任务会在其他线程中并行的执行.
    NSOperationQueue *otherQueue = [[NSOperationQueue alloc]init];
    
    // 创建NSBlockOperation对象
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    // 添加多个block
    for (int i = 0; i < 3; i++) {
        [blockOperation addExecutionBlock:^{
            NSLog(@"第%d次 --- %@", i, [NSThread currentThread]);
        }];
    }
    
    // 队列添加任务
    otherQueue.maxConcurrentOperationCount = 1;
    [otherQueue addOperation:blockOperation];
    
//    [mainQueue addOperation:blockOperation];
}

- (void)addDependency
{
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"下载图片 -- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"添加水印 -- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    }];
    
    NSBlockOperation *operation3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"上传图片 -- %@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
    }];
    
    // 设置依赖
    [operation2 addDependency:operation1];
    [operation3 addDependency:operation2];
    
    // 创建队列并加入任务
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
