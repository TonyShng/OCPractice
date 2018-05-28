//
//  TSNSOperation.m
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/28.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSNSOperation.h"

@implementation TSNSOperation

/*
 NSOperation是苹果公司对GCD的封装,完全面向对象. NSOperation 对应GCD中的任务  NSOperationQueue对应GCD中的队列
 
 操作步骤:
    1.将要执行的任务封装到一个NSOperation对象中.
    2.将此任务添加到一个NSOperationQueue对象中
 
 
 */

- (instancetype)init
{
    if (self = [super init]) {
        [self test];
    }
    return self;
}

- (void)test
{
    
}

#pragma mark - 添加任务
- (void)addTask
{
    // NSOperation只是一个抽象类,不能封装任务. 但是它有两个子类可以进行封装任务.分别是NSInvocationOperation和NSBlockOperation.创建一个Operation后,需要调用start方法启动,它会默认在当前队列*同步执行*.如果中途取消一个任务,可以调用cancel方法进行取消.
    
    // NSInvocationOperation初始化
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationOperationTask:) object:@"invocationOperation"];
    [invocationOperation start];
    
    
    // NSBlockOperation初始化
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@ ---- ", [NSThread currentThread]);
    }];
    
    // addExecutionBlock: 方法可以给NSBlockOperation添加多个执行block,这样Operation中的任务会并发执行,他会在主线程和其他多个线程执行任务. 这个方法必须在start方法之前执行,不然会报错.
    for (int i = 0; i < 5; i++) {
        [blockOperation addExecutionBlock:^{
            NSLog(@"第%d次执行 -- %@", i, [NSThread currentThread]);
        }];
    }
    
    [blockOperation start];
}

- (void)invocationOperationTask:(NSObject *)object
{
    NSLog(@"%@ ---- %@", object, [NSThread currentThread]);
}


#pragma mark - 创建队列
/*
 调用一个NSOperation对象的start()方法来启动这个任务,但这样做它们默认是同步执行的.就算是addExecutionBlock方法,也会在当前线程和其他线程中执行,也就是说还是会占用当前线程.这就用到队列了,NSOperationQueue. 按类型来分有两种: 主队列和其他队列.
 只要添加到队列,会自动调用任务的start()方法
 */
- (void)createQueue
{
    // 主队列 主线程,特殊的线程,必须串行.所以添加到主队列中的任务会一个接着一个的排着队在主线程中执行.  **表示存疑 因为并非按照顺序执行. 但最大并发数为1 
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
    [otherQueue addOperation:blockOperation];
    
    // 如果需要设置串行并行 只需要设置队列的最大并发数即可  maxConcurrentOperationCount
    otherQueue.maxConcurrentOperationCount = 1;
    
    // 队列直接添加任务 不需要Operation封装
    [otherQueue addOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
}

// 但是为何还是需要NSOperation 因为NSOperation还有其他功能 例如添加依赖
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
    
    // 注意⚠️ 设置依赖不能互相依赖 否则会死锁 比如A依赖B B依赖A
    // 可以使用removeDependency: 来移除依赖
    // 可以在不同的队列之间依赖,反正就是这个依赖添加到任务上,而非队列上的.和队列没有关系.
    
    // 创建队列并加入任务
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
}

// 一些其他的方法
- (void)otherMethod
{
    // NSOperation
    NSOperation *operation = [NSOperation new];
    // 判断任务是否正在进行
//    operation.isExecuting;
    
    // 判断任务是否完成
//    operation.isFinished;
    
    // 用来设置完成之后的操作
    [operation setCompletionBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    // 取消任务
    [operation cancel];
    
    // 阻塞当前线程知道任务执行完毕
    [operation waitUntilFinished];
    
    // NSOperationQueue
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 获取队列的任务数
    [queue operationCount];
    
    //取消队列中所有任务
    [queue cancelAllOperations];
    
    // 阻塞当前线程知道此队列中所有任务执行完毕
    [queue waitUntilAllOperationsAreFinished];
    
    // 暂停queue
    [queue setSuspended:YES];
    
    // 继续queue
    [queue setSuspended:NO];
}




@end























