//
//  Meal.h
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Meal : NSObject

- (void)addItem:(id<Item> )item;

- (float)getCost;

- (void)showItems;

@end

NS_ASSUME_NONNULL_END
