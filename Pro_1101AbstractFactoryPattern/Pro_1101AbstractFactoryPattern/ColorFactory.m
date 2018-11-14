//
//  ColorFactory.m
//  Pro_1101AbstractFactoryPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ColorFactory.h"
#import "Red.h"
#import "Green.h"
#import "Blue.h"

@implementation ColorFactory

- (id<Color>)getColorWithColorType:(ColorType)type
{
    if (type == ColorTypeRed) {
        return [[Red alloc]init];
    }else if (type == ColorTypeGreen){
        return [[Green alloc]init];
    }else if (type == ColorTypeBlue){
        return [[Blue alloc]init];
    }
    return nil;
}

@end
