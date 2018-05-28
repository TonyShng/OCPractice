//
//  TSPthreads.m
//  Pro_0525Thread
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSPthreads.h"
#import <pthread.h>

@interface TSPthreads()

@end

@implementation TSPthreads

- (instancetype)init
{
    if (self = [super init]) {
        [self test];
    }
    return self;
}

/**
 POSIX线程（POSIX threads），简称Pthreads，是线程的POSIX标准。该标准定义了创建和操纵线程的一整套API。在类Unix操作系统（Unix、Linux、Mac OS X等）中，都使用Pthreads作为操作系统的线程。
 */
- (void)test
{
    pthread_t thread;
    // 创建一个线程,并执行任务.
    pthread_create(&thread, NULL, start, NULL);
    // 需要手动管理线程的生命周期 这个线程没有被销毁
}

void *start(void *data){
    NSLog(@"%@",[NSThread currentThread]);
    return NULL;
}

@end
