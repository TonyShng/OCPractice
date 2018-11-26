//
//  XXXObject.m
//  Pro_1119Load
//
//  Created by Tony on 2018/11/19.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "XXXObject.h"

@implementation XXXObject

+ (void)load
{
    NSLog(@"XXXObject load");
}


- (void)didSomething
{
    NSLog(@"%d--%s---%@", __LINE__, __func__, [self class]);
}


@end
