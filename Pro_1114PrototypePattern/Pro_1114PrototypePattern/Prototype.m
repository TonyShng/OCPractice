//
//  Prototype.m
//  Pro_1114PrototypePattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "Prototype.h"

@interface Prototype ()<NSCopying>

@end

@implementation Prototype


/**
 深拷贝
 */
- (id)copyWithZone:(NSZone *)zone
{
    Prototype *copyPrototype = [[Prototype alloc]init];
    copyPrototype.name = self.name;
    
    return copyPrototype;
}

@end
