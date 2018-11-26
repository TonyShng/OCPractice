//
//  DrawAPI.h
//  Pro_1116BridgePattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DrawAPI <NSObject>

- (void)drawCircleWithRadius:(int )radius X:(int )x Y:(int )y;

@end

NS_ASSUME_NONNULL_END
