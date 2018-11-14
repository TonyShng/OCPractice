//
//  MealBuilder.m
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "MealBuilder.h"
#import "VegBurger.h"
#import "Coke.h"
#import "ChickenBurger.h"
#import "Pepsi.h"

@implementation MealBuilder

- (Meal *)prepareVegMeal
{
    Meal *meal = [Meal new];
    [meal addItem:[VegBurger new]];
    [meal addItem:[Coke new]];
    return meal;
}

- (Meal *)prepareNonVegMeal
{
    Meal *meal = [Meal new];
    [meal addItem:[ChickenBurger new]];
    [meal addItem:[Pepsi new]];
    return meal;
}


@end
