//
//  Calculator.h
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/8.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 函数式编程

@interface Calculator : NSObject

@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) double result;

- (Calculator *)calculator:(double (^)(double result))calculator;

- (Calculator *)equle:(BOOL (^)(double result))operation;

@end

NS_ASSUME_NONNULL_END
