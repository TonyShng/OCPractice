//
//  Square.h
//  Pro_1101AbstractFactoryPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
NS_ASSUME_NONNULL_BEGIN

@interface Square : NSObject<Shape>

- (void)draw;

@end

NS_ASSUME_NONNULL_END
