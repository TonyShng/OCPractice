//
//  CalculatorMaker.m
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/8.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "CalculatorMaker.h"

@implementation CalculatorMaker

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.result = 0.0;
    }
    return self;
}

- (CalculatorMaker * _Nonnull (^)(double))add
{
    return ^CalculatorMaker *(double value){
        self.result += value;
        return self;
    };
}

- (CalculatorMaker * _Nonnull (^)(double))sub
{
    return ^CalculatorMaker *(double value) {
        self.result -= value;
        return self;
    };
}

- (CalculatorMaker * _Nonnull (^)(double))muilt
{
    return ^CalculatorMaker *(double value) {
        self.result *= value;
        return self;
    };
}

- (CalculatorMaker * _Nonnull (^)(double))divide
{
    return ^CalculatorMaker *(double value) {
        self.result /= value;
        return self;
    };
}

+ (double)makeCalculator:(void (^)(CalculatorMaker * _Nonnull))calculatorMaker
{
    CalculatorMaker *maker = [[CalculatorMaker alloc] init];
    calculatorMaker(maker);
    return maker.result;
}


@end
