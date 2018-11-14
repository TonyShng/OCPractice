//
//  AbstractFactory.h
//  Pro_1101AbstractFactoryPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Color.h"
#import "Shape.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ColorType) {
    ColorTypeRed,
    ColorTypeGreen,
    ColorTypeBlue,
};

typedef NS_ENUM(NSUInteger, ShapeType) {
    ShapeTypeRectangle,
    ShapeTypeSquare,
    ShapeTypeCircle,
};

@protocol AbstractFactory <NSObject>

@optional
-(id<Color>)getColorWithColorType:(ColorType)type;
- (id<Shape>)getShapeWithType:(ShapeType)type;

@end

NS_ASSUME_NONNULL_END
