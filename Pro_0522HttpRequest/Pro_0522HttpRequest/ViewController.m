//
//  ViewController.m
//  Pro_0522HttpRequest
//
//  Created by Tony on 2018/5/22.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ViewController.h"
#import "TSOperation.h"

@interface ViewController ()

@property (strong, nonatomic) NSTimer *time;
@property (strong, nonatomic) UIImageView *imageV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self syncSerial];
//    [self asyncSerial];
//    [self syncConcurrent];
//    [self asyncConcurrent];
//    [self syncMain];
//    [self asyncMain];
    
//    self.imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 100, 100)];
//    [self.view addSubview:self.imageV];
//    [self communicationBetweenThread];
    
//    [self barrierGCD];
//    [self delayGCD];
//    [self onceGCD];
//    [self applyGCD];
//    [self groupGCD];
    
//    [self createOperationByInvocation];
//    [self createOperationByBlock];
//    [self addExectutionBlockWithBlockOperation];
//    [self testTSOperation];
//    [self testOperationQueue];
//    [self testAddOperationWithBlock];
//    [self testMaxConcurrentOperationCount];
    [self testAddDependency];
}

#pragma mark - NSThread

/**
 线程
 */
- (void)Thread
{
    /// 同步锁(互斥锁) 保证里面代码在同一时刻只被一个线程执行
    @synchronized(self){
        
    }
    
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(doSomeThing1:) object:@"Thread1"];
    [thread1 start];
    
    
    [NSThread detachNewThreadSelector:@selector(doSomeThing2:) toTarget:self withObject:@"Thread2"];
    
    [self performSelectorInBackground:@selector(doSomeThing3:) withObject:@"Thread3"];
}

- (void)doSomeThing:(NSObject *)object
{
    NSLog(@"object \t %@", object);
    NSLog(@"currentThread \t %@", [NSThread currentThread]);
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


#pragma mark - GCD
/**
 队列
 */
- (void)queue
{
    // 串行队列
    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_SERIAL);
    // 并发队列
    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
    // 全局并发队列
    dispatch_queue_t queue3 = dispatch_get_global_queue(0, 0);
    // 主队列
    dispatch_queue_t queue4 = dispatch_get_main_queue();
    
    // 同步
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
    });
    
    // 异步
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
    });
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
 串行异步 开启新的线程,因为是串行,所以还是按照顺序执行
 */
- (void)asyncSerial
{
    NSLog(@"----- 串行异步 ------");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_SERIAL);
    // 异步执行
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
 并发同步 因为是同步,所以执行完一个任务再执行下一个任务,不会开启新的线程.
 */
- (void)syncConcurrent
{
    NSLog(@"----- 并发同步 -----");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    // 同步执行
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步并发1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步并发2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"同步并发3 %@", [NSThread currentThread]);
        }
    });
    
}

/**
 异步并发 任务交替执行,开启多线程
 */
- (void)asyncConcurrent
{
    NSLog(@"----- 异步并发 -----");
    NSLog(@"主线程 -- %@", [NSThread mainThread]);
    // 并发线程
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"异步并发1 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"异步并发2 %@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"异步并发3 %@", [NSThread currentThread]);
        }
    });
}


/**
 主队列同步 会造成死锁
 
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
 主队列异步 在主线程中按顺序执行
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
        NSLog(@"---%@", [NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageV.image = image;
        });
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.imageV.image = image;
//        });
    });
}

/**
 GCD栅栏
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
        NSLog(@"%@--%@", [NSThread currentThread], [NSThread mainThread]);
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

#pragma mark - NSOperation
/**
 NSInvocation子类创建Operation 在主线程中执行,没有开启子线程
 */
- (void)createOperationByInvocation
{
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(invocationDoSomething:) object:@"invocation"];
    [invocation start];
}

- (void)invocationDoSomething:(NSObject *)object
{
    NSLog(@"NSInvocationOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
}

/**
 使用block子类创建Operation 在主线程中执行,没有开启新线程
 */
- (void)createOperationByBlock
{
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    }];
    [blockOperation start];
}

// 使用AddExecutionBlock方法可以开启多线程
- (void)addExectutionBlockWithBlockOperation
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列========%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列1========%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列2========%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"NSBlockOperation包含的任务，没有加入队列3========%@", [NSThread currentThread]);
    }];
    
    [operation start];
}

/**
 继承自NSOperation的类,重写它的main方法
 */
- (void)testTSOperation
{
    TSOperation *operation = [[TSOperation alloc]init];
    [operation start];
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
//    queue.maxConcurrentOperationCount = 1;
    
    // 最大并发数为2 并行
    queue.maxConcurrentOperationCount = 2;
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
