//
//  Calculator.m
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/8.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result = 0.0;
    }
    return self;
}

- (Calculator *)calculator:(double (^)(double result))calculator
{
    Calculator *c = [[Calculator alloc] init];
    calculator(c.result);
    return c;
}

- (Calculator *)equle:(BOOL (^)(double result))operation
{
    Calculator *c = [[Calculator alloc] init];
    operation(c.result);
    return c;
}

@end
