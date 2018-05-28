//
//  TSGCD.m
//  Pro_0522HttpRequest
//
//  Created by Tony on 2018/5/23.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSGCD.h"
#import <UIKit/UIKit.h>

@implementation TSGCD

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
    // 队列的创建 队列:装载线程任务的队形结构.(系统以先进先出的方式调度队列中的任务执行) 包含线程,但是不会创建线程(线程的创建由同步/异步来决定)
    // 第一个参数表示队列标识符 第二个参数表示串行队列(DISPATCH_QUEUE_SERIAL) 或并发队列(DISPATCH_QUEUE_CONCURRENT)
    // 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("test1", DISPATCH_QUEUE_SERIAL);
    // 并发队列
    dispatch_queue_t queue2 = dispatch_queue_create("test2", DISPATCH_QUEUE_CONCURRENT);
    
    // 主队列
    // 主队列负责在主线程上调度任务,如果主线程上已经有任务在执行,主队列会等主线程空闲的时候再调度任务.通常是返回主线程更新UI的时候使用
    // 这里并不是让主线程等待,因为是异步执行,所以主线程也在执行任务.当子线程完成耗时操作后,会通过主队列回归到主线程,让主线程根据数据进行操作
    // dispatch_get_mian_queue()
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作
        dispatch_async(dispatch_get_main_queue(), ^{
            // 回归主线程
        });
    });
    // 全局并发队列
    /*
        全局并发队列的优先级
        DISPATCH_QUEUE_PRIORITY_LOW -2 低
        DISPATCH_QUEUE_PRIORITY_DEFAULT 0 默认
        DISPATCH_QUEUE_PRIORITY_HIGH 2 高
        DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN 后台优先级
     */
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // iOS8开始使用服务质量,现在使用全局并发队列时,可以直接传0
    dispatch_get_global_queue(0, 0);
    
    // 同步执行任务 不会开启线程
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    });
    
    // 异步执行任务 会开启线程
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    });
}

- (void)test2
{
    /// 串行同步
    // 执行完一个任务再执行下一个任务,不会开启新的线程
    [self syncSerial];
}

/**
 串行同步 执行完一个任务再执行下一个任务,不开启新的线程
 */
- (void)syncSerial
{
    NSLog(@"------- 串行同步 --------");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行同步1 -- %@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行同步2 -- %@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行同步3 -- %@", [NSThread currentThread]);
        }
    });
}

/**
 异步串行 开启新的线程,因为是串行,所以还是按照顺序执行 在子线程中一个一个执行任务,这时候主线程可以进行操作,不会阻塞主线程
 */
- (void)asyncSerial
{
    NSLog(@"----- 串行异步 ------");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"串行异步3 %@", [NSThread currentThread]);
        }
    });
    
}

/**
 并发同步 因为是同步,所以执行完一个任务再执行下一个任务,不会开启新的线程. 因为只有一个线程,且为主线程,所以一个执行完后才会执行下一个
 */
- (void)syncConcurrent
{
    NSLog(@"----- 并发同步-----");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发同步3 %@", [NSThread currentThread]);
        }
    });
    
}

/**
 并发异步 任务交替执行,开启多线程 这时候队列中的任务可以同时执行,因为是异步的,所以也会开启多个线程,所以任务会交替执行.
 */
- (void)asyncConcurrent
{
    NSLog(@"----- 并发异步 -----");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 并发线程
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"并发异步3 %@", [NSThread currentThread]);
        }
    });
}

/**
 主队列同步 会造成死锁 在主队列中添加任务,因为队列是先进后出的,且在同步的状态下任务是一个接着一个执行
 
 解析:如果在主线程中运用主队列同步,也就把任务放到了主线程的队列中.
 而同步对于任务是立刻执行的,那么把第一个任务放到主队列,它就回立马执行任务.
 但目前主线程正在处理syncMain方法,任务需要等syncMain方法执行完才能执行.
 syncMain执行到第一个任务的时候,又要等第一个任务执行完才能继续往下执行第二个和第三个.
 这样syncMain方法与第一个任务相互等待,形成了死锁.
 
 */
- (void)syncMain
{
    NSLog(@"----- 主队列同步 -----");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步1 %@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步2 %@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列同步3 %@", [NSThread currentThread]);
        }
    });
}

/**
 主队列异步 在主线程中按顺序执行 虽然是异步,但是因为是主队列,只能有一个主线程,所以会在主线程主按顺序一个一个执行
 */
- (void)asyncMain
{
    NSLog(@"----- 主队列异步 -----");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    // 异步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列异步1 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列异步2 %@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"主队列异步3 %@", [NSThread currentThread]);
        }
    });
}

/**
 GCD线程之间的通讯 开发中需要在主线程中进行UI相关的操作,通常把一些耗时的放在其他线程上.
 当完成耗时操作之后,需要回到主线程进行UI的处理,这时候就需要线程之间的通讯.
 */
- (void)communicationBetweenThread
{
    // 异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 耗时操作放这里,如下载图片
        [NSThread sleepForTimeInterval:2]; // 睡眠2秒
        NSString *imgUrl = @"http://pic35.photophoto.cn/20150409/0005018337384017_b.jpg";
        NSURL *picUrl = [NSURL URLWithString:imgUrl];
        NSData *data = [NSData dataWithContentsOfURL:picUrl];
        UIImage *image = [UIImage imageWithData:data];
        
        // 下载完成之后回归主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //self.imageV.image = image;
        });
        
    });
}

/**
 GCD栅栏 当任务需要异步执行,但这些任务需要分配成两组来执行,第一组完成之后才能进行第二组的操作.这时候就用到了CGD的栅栏方法dispatch_barrier_async.
 */
- (void)barrierGCD
{
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    // 异步执行
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步1   %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步2   %@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----- barrier ----- %@", [NSThread currentThread]);
        NSLog(@"并发异步执行, 但是34一定在12后面");
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步3   %@",[NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"栅栏：并发异步4   %@",[NSThread currentThread]);
        }
    });
}

/**
 GCD的延时执行
 */
- (void)delayGCD
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"我已经等待了五秒");
    });
}

/**
 GCD实现代码只执行一次
 */
- (void)onceGCD
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只运行一次,多用在单例");
    });
}

/**
 GCD的快速迭代
 */
- (void)applyGCD
{
    // 并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // dispatch_apply 几乎同时遍历多个数字
    dispatch_apply(7, queue, ^(size_t index) {
        NSLog(@"dispatch_apply: %zd=====%@", index, [NSThread currentThread]);
    });
}

/**
 GCD队列组 异步执行几个耗时操作,当这几个耗时操作都完成之后再回到主线程进行操作,就可以用到队列组了
 
 所有任务会并发的执行(不按顺序)
 所有的异步函数都添加到队列中,然后再纳入队列组的监听范围.
 使用dipatch_group_notify这个函数来监听上面的函数是否完成,如果完成,就回调用这个方法.
 
 */
- (void)groupGCD
{
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组,有一个耗时操作完成!");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"队列组,有一个耗时操作完成!");
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"队列组:前面的耗时操作都完成了,回到主线程进行相关操作");
    });
    
}


@end
