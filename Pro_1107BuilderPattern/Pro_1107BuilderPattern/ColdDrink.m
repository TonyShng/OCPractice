//
//  ColdDrink.m
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "ColdDrink.h"
#import "Bottle.h"

@implementation ColdDrink
@synthesize packing;
@synthesize name;
@synthesize price;

- (id<Packing>)packing
{
    return [Bottle new];
}

@end
