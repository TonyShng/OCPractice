//
//  ShapeFactory.h
//  Pro_1101FactoryPattern
//
//  Created by Tony on 2018/11/1.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ShapeType) {
    ShapeTypeRectangle,
    ShapeTypeSquare,
    ShapeTypeCircle,
};

/// 工厂类角色：简单工厂模式的核心，负责根据传入的参数来实例化具体的产品实例。
@interface ShapeFactory : NSObject

- (id<Shape>)getShapeWithType:(ShapeType)type;


@end

NS_ASSUME_NONNULL_END
