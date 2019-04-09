//
//  CalculatorMaker.h
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/8.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 链式编程

@interface CalculatorMaker : NSObject

@property (nonatomic, assign) double result;

- (CalculatorMaker *(^)(double))add;

- (CalculatorMaker *(^)(double))sub;

- (CalculatorMaker *(^)(double))muilt;

- (CalculatorMaker *(^)(double))divide;

+ (double)makeCalculator:(void (^)(CalculatorMaker *maker))calculatorMaker;

@end

NS_ASSUME_NONNULL_END
