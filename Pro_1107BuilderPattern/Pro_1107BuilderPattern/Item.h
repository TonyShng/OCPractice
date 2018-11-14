//
//  Item.h
//  Pro_1107BuilderPattern
//
//  Created by Tony on 2018/11/7.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Packing.h"
NS_ASSUME_NONNULL_BEGIN

@protocol Item <NSObject>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) id<Packing> packing;
@property (nonatomic, assign) float price;

@end

NS_ASSUME_NONNULL_END
