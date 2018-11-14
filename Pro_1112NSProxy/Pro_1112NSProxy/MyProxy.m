//
//  MyProxy.m
//  Pro_1112NSProxy
//
//  Created by Tony on 2018/11/12.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "MyProxy.h"

@implementation MyProxy

+ (id)proxyForObject:(id)obj
{
    MyProxy *instance = [MyProxy alloc];
    instance->_object = obj;
    return instance;
}

/// 这个方法需要获取一个方法签名,用来生成NSInvocation,我们直接将这个调用转发到被代理对象中.
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_object methodSignatureForSelector:sel];
}

/// 将NSInvocation用被代理对象调用
- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([_object respondsToSelector:invocation.selector]) {
        NSString *selectorName = NSStringFromSelector(invocation.selector);
        
        NSLog(@"Before calling \"%@\".", selectorName);
        [invocation invokeWithTarget:_object];
        NSLog(@"After calling \"%@\".", selectorName);
    }
}


@end
