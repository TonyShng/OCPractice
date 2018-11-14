//
//  FactoryProducer.m
//  Pro_1101AbstractFactoryPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "FactoryProducer.h"
#import "ShapeFactory.h"
#import "ColorFactory.h"


@implementation FactoryProducer

- (id<AbstractFactory>)getFactoryWithType:(FactoryType)type
{
    if (type == FactoryTypeShape) {
        return [[ShapeFactory alloc]init];
    } else if (type == FactoryTypeColor){
        return [[ColorFactory alloc]init];
    }
    return nil;
}

@end
