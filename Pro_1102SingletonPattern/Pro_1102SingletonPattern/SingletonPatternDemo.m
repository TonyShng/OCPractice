//
//  SingletonPatternDemo.m
//  Pro_1102SingletonPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "SingletonPatternDemo.h"

@implementation SingletonPatternDemo

/* 单例类方法 */
+ (instancetype)shareInstance
{
    static SingletonPatternDemo *instanceSingle = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instanceSingle = [[super alloc] init];
    });
    
    return instanceSingle;
}

- (void)showMessage
{
    NSLog(@"Hello world!");
}


@end
