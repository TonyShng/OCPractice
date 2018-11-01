//
//  Shape.h
//  Pro_1101FactoryPattern
//
//  Created by Tony on 2018/11/1.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 抽象产品角色：通常是工厂产生具体类的父类(或者是具体类实现的接口)。

@protocol Shape <NSObject>

- (void)draw;


@end

NS_ASSUME_NONNULL_END
