//
//  ShapeFactory.m
//  Pro_1101FactoryPattern
//
//  Created by Tony on 2018/11/1.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ShapeFactory.h"
#import "Rectangle.h"
#import "Square.h"
#import "Circle.h"

@implementation ShapeFactory

-(id<Shape>)getShapeWithType:(ShapeType)type
{
    if (type == ShapeTypeRectangle) {
        return [[Rectangle alloc] init];
    } else if (type == ShapeTypeSqura){
        return [[Square alloc] init];
    } else if (type == ShapeTypeCircle){
        return [[Circle alloc]init];
    }
    return nil;
}



@end
