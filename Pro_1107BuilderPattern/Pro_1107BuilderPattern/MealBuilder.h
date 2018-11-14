//
//  MealBuilder.h
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meal.h"
NS_ASSUME_NONNULL_BEGIN

@interface MealBuilder : NSObject

- (Meal *)prepareVegMeal;

- (Meal *)prepareNonVegMeal;

@end

NS_ASSUME_NONNULL_END
