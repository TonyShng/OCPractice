//
//  TSGCD.m
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSGCD.h"


@implementation TSGCD

/*
 GCD:grand center dispatch  宏大的派发中心 - - 是苹果为多核并行提出的解决方案,所以会自动合理的利用更多CPU内核(比如双核 四核).最重要的是它会自动管理线程的生命周期(创建线程/调度任务/销毁线程) 完全不需要我们管理,我们只需要告诉干什么就行.同时它使用的也是C语言,不过由于使用了block ,使得使用起来更加方便,而且灵活.
 
 任务:即操作.说白了就是一段代码,在GCD中就是一个block. 任务执行有两种方式 同步执行和异步执行 之间的区别是会不会阻塞当前的线程,知道block中的任务执行完毕.
    同步操作:会阻塞当前线程并等待block中的任务执行完毕然后当前线程才会继续往下运行. 同步执行会马上加入到线程中执行
    异步操作:当前线程会直接往下执行,它不会阻塞当前线程. 会等待调度,不会马上执行.
 队列:用于存放任务. 一共有两种队列:串行队列和并行队列.
    串行队列:放到串行队列的任务,GCD会FIFO(先进先出)地取出一个,执行一个,然后取下一个,这样一个一个执行.
 并行队列:放到并行队列的任务,GCD也会FIFO的取出来,但不同的是,它取出来一个就回放到别的线程,然后又取出来一个放到另一个线程.这样由于取的动作很快,忽略不计,看起来,所有任务都是一起执行的.不过需要注意:GCD会根据系统资源控制并行的数量,所以如果任务很多,它并不会让所有任务同时执行.
 
        ------------------------------------------------------------------------------
        |               |           同步执行           |            异步执行            |
        ------------------------------------------------------------------------------
        |    串行队列     |  当前线程,一个一个执行         |  其他线程,一个一个执行           |
        ------------------------------------------------------------------------------
        |    并行队列     |  当前线程,一个一个执行         |  开多个线程,一起执行             |
        ------------------------------------------------------------------------------
 
 
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

#pragma mark - 创建队列
- (void)createQueue
{
    /// 主队列:这是一个特殊的串行队列,
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    
    // 自己创建队列 第一个参数是标识符,用于debug模式下标识唯一的队列 第二个参数传入 DISPATCH_QUEUE_SERIAL 或NULL都表示串行队列 传入DISPATCH_QUEUE_CONCURRENT 表示并行队列.
    
    //串行队列
    dispatch_queue_t nullQueue = dispatch_queue_create("nullQueue", NULL);
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", DISPATCH_QUEUE_SERIAL);
    // 并行队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    // 全局并行队列  第一个参数表示优先级 第二个参数则是flag,保留以供将来使用。传递除0之外的任何值都可能导致NULL返回值。目前只能传0
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSLog(@"%@%@%@%@%@", mainQueue, nullQueue, serialQueue, concurrentQueue, globalQueue);
    
}

#pragma mark - 创建任务
- (void)createTask
{
    // 同步任务 立刻执行 会阻塞当前线程
//    dispatch_sync(<# queue #>, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    
    // 异步任务 不会阻塞当前线程
//    dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, ^{
//        NSLog(@"%@", [NSThread currentThread]);
//    });
    
    // 两个🌰
    // 主队列同步 死锁现象
    NSLog(@"之前 - %@", [NSThread currentThread]);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"sync - %@", [NSThread currentThread]);
    });
    NSLog(@"之后 - %@", [NSThread currentThread]);
    
    
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

#pragma mark - 队列组
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

#pragma mark - barrier
// 栅栏
- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
    
    // 这个方法会阻塞队列,等待队列中这之前的任务执行完成之后,取消阻塞,执行队列中后面的任务
    dispatch_barrier_async(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    // 这个方法不仅会阻塞队列,还会阻塞当前线程
    dispatch_barrier_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
}



@end
