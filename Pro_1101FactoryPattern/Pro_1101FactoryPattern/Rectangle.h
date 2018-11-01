//
//  Rectangle.h
//  Pro_1101FactoryPattern
//
//  Created by Tony on 2018/11/1.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"

NS_ASSUME_NONNULL_BEGIN

// 具体产品角色：简单工厂模式所创建的任何对象都是这个角色的实例。

@interface Rectangle : NSObject<Shape>

- (void)draw;

@end

NS_ASSUME_NONNULL_END
