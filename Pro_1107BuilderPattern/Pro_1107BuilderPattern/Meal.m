//
//  Meal.m
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "Meal.h"

@interface Meal ()
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation Meal

- (void)addItem:(id<Item>)item
{
    if (self.items == nil) {
        self.items = [NSMutableArray array];
    }
    
    [self.items addObject:item];
}

- (float)getCost
{
    float cost = 0.0f;
    for (id<Item> item in self.items) {
        cost += item.price;
    }
    return cost;
}

- (void)showItems
{
    for (id<Item> item in self.items) {
        NSLog(@"Item : %@, Packing : %@, Price : %.2f", item.name, item.packing.pack, item.price);
    }
}

@end
