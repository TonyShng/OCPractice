//
//  XXXObject+loadTest.m
//  Pro_1119Load
//
//  Created by Tony on 2018/11/19.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "XXXObject+loadTest.h"

@implementation XXXObject (loadTest)

+ (void)load
{
    NSLog(@"loadTest load");
}

- (void)didSomething
{
    NSLog(@"%d--%s---%@", __LINE__, __func__, [self class]);
}

@end
