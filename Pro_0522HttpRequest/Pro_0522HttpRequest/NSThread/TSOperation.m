//
//  TSOperation.m
//  Pro_0522HttpRequest
//
//  Created by Tony on 2018/5/25.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "TSOperation.h"

@implementation TSOperation

- (void)main
{
    for (int i = 0; i < 3; i++) {
        NSLog(@"NSOperation的子类TSOperation===%@",[NSThread currentThread]);
    }
}

@end
