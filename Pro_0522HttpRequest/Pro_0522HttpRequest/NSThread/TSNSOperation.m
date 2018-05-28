//
//  TSNSOperation.m
//  Pro_0522HttpRequest
//
//  Created by Tony on 2018/5/24.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSNSOperation.h"
#import "TSOperation.h"

@implementation TSNSOperation

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self test];
    }
    return self;
}

- (void)test
{
    /*
        NSOperation是基于GCD之上的更高一层的封装.NSOperation需要配合NSOperationQueue来实现多线程.
     
     步骤如下:
        1.创建任务:先将需要执行的操作封装到NSOperation对象中.
        2.创建队列:创建NSOperationQueue
        3.将任务添加到队列中:将NSOperation添加到NSOperationQueue中.
     
     NSOperation是一个抽象类,实际运用中需要使用它的子类,有三种方式
        1.使用子类NSInvocationOperation
        2.使用子类NSBlockOperation
        3.定义继承自NSOperation的子类,通过实现内部相应方法来封装任务.
     */
}

/// 创建NSOperation
// 1.使用子类NSInvocationOperation
- (void)createNSOperationByInvocation
{
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doSomeThing:) object:@"Invocation"];
    [invocation start];
}

// 程序在主线程执行,没有开启新的线程. 这是因为NSOperation需要配合NSOperationQueue使用
- (void)doSomeThing:(NSObject *)object
{
    NSLog(@"NSInvocationOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
}

/**
 使用block子类创建Operation  任务也是在主线程中执行,没有开启新的线程,需要配合OperationQueue使用
 */
- (void)createOperationByBlock
{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    }];
    [blockOperation start];
}

// NSBlockOperation有一个方法addExecutionBlock 可以让NSBlockOperation实现多线程 这里的每个任务都有可能会在主线程上执行,并不是只有初始化的那个会固定在主线程执行.这个是随机的
- (void)add
{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation运用addExecution主任务========%@", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"NSBlockOperation运用addExecution主任务1========%@", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"NSBlockOperation运用addExecution主任务2========%@", [NSThread currentThread]);
    }];
    
    [blockOperation addExecutionBlock:^{
        NSLog(@"NSBlockOperation运用addExecution主任务3========%@", [NSThread currentThread]);
    }];
    
    [blockOperation start];
}

/**
 继承自NSOperation的类,重写它的main方法 运行结果都是在主线程中执行的,想要多线程 需要配合NSOperationQueue
 */
- (void)testTSOperation
{
    TSOperation *operation = [[TSOperation alloc]init];
    [operation start];
}


//** -- NSOperationQueue -- **//
/*
 NSOperationQueue 包括两种队列:主队列和其他队列 其他队列包含串行和并发
 
 1.非主队列可以实现串行或并发
 2.队列NSOperationQueue有一个参数叫最大并发数maxConcurrentOperationCount;
 3.maxConcurrentOperationCount默认为-1,直接并发执行,所以加入到非主队列中的任务默认就是并发,开启多线程
 4.当maxConcurrentOperationCount为1时,则表示不开线程,也就是串行.
 5.当maxConcurrentOperationCount大于1时,进行并发执行.
 6.系统对最大并发数maxConcurrentOperationCount有限制,所以程序员把maxConcurrentOperationCount设置的很大,系统也会自动调整.所以把maxConcurrentOperationCount设置很大没有意义的.
 
 */

- (void)mainQueue
{
    // 主队列 主队列上的任务是在主线程中执行的
    NSOperationQueue *queue = [NSOperationQueue mainQueue];
}

- (void)otherQueue
{
    // 其他队列 其他队列默认是并发的 所以默认开启多线程 其他队列上的任务在自线程中执行
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
}

//** -- NSOperation + NSOperationQueue -- **//

// 把任务加入队列,才是NSOperation的常规使用

// addOperation 添加任务到队列中
-(void)testOperationQueue
{
    // 创建队列 默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // 创建操作 NSInvocationOperation
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(doSomeThing:) object:@"invocation"];
    
    // 创建操作 NSBlockOperation
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    }];
    
    // 创建操作 自定义继承NSOperation的类
    TSOperation *operaion = [[TSOperation alloc]init];
    
    [queue addOperation:invocationOperation];
    [queue addOperation:blockOperation];
    [queue addOperation:operaion];
    
    // 运行结果显示 任务都是在子线程中执行的,开启了新线程
}

// 另一种方式 把任务添加到队列中 非常方便 不需要创建Operation 任务都是在子线程中执行的
- (void)testAddOperationWithBlock
{
    // 创建队列 默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 添加操作到队列
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationBlock已经把操作添加到队列中 ===== %@",[NSThread currentThread]);
        }
    }];
    
}


/// 最大并发数的实现
- (void)testMaxConcurrentOperationCount
{
    // 创建队列 默认并发
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // 最大并发数为1 串行
    queue.maxConcurrentOperationCount = 1;
    
    // 最大并发数为2 并行
//    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationBlock已经把操作添加到队列中1 ===== %@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationBlock已经把操作添加到队列中2 ===== %@",[NSThread currentThread]);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"addOperationBlock已经把操作添加到队列中3 ===== %@",[NSThread currentThread]);
        }
    }];
    
    // 虽然开启了线程,但是因为是串行, 所以任务是按顺行执行的
    
}


//** -- NSOperation的其他操作 -- **//

/*
 取消NSOperaionQueue的所有操作,NSOperationQueue对象方法
 - (void)cancelAllOperations
 
 取消NSOperation的某个操作,NSOperation对象方法
 - (void)cancel
 
 使队列暂停或继续
 [queue setSuspended:YES] // 暂停
 
 判断队列是否暂停
 - (void)isSuspended
 
 注: 暂停和取消不是立刻取消当前操作,而是等当前操作执行之后不再进行新的操作.
 
 */

//** -- NSOperation的操作依赖 -- **//
/*
 NSOperation有一个非常好用的方法,就是操作依赖.理解:某一个操作(operation2)依赖于另一个操作(operation1),只有operation1执行完毕才能执行operation2,这时就需要操作依赖.
 */

/**
 添加依赖
 */
- (void)testAddDependency
{
    // 并发队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    
    // 操作1
    NSBlockOperation *blockOperation1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"operation1======%@", [NSThread  currentThread]);
    }];
    
    // 操作2
    NSBlockOperation *blockOperation2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"****operation2依赖于operation1，只有当operation1执行完毕，operation2才会执行****");
        for (int i = 0; i < 3; i++) {
            NSLog(@"operation2======%@", [NSThread  currentThread]);
        }
    }];
    
    // 使blockoperation2 依赖于 blockOperation1
    [blockOperation2 addDependency:blockOperation1];
    
    [queue addOperation:blockOperation1];
    [queue addOperation:blockOperation2];
}





@end
