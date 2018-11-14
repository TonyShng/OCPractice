//
//  FactoryProducer.h
//  Pro_1101AbstractFactoryPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractFactory.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FactoryType) {
    FactoryTypeShape,
    FactoryTypeColor,
};

@interface FactoryProducer : NSObject

- (id<AbstractFactory>)getFactoryWithType:(FactoryType)type;

@end

NS_ASSUME_NONNULL_END
