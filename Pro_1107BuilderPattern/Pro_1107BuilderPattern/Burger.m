//
//  Burger.m
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "Burger.h"
#import "Wrapper.h"

@implementation Burger
@synthesize name;
@synthesize price;
@synthesize packing;

-(id<Packing>)packing
{
    return [Wrapper new];

}


@end
