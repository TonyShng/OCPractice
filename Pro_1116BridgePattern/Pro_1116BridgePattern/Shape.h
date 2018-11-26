//
//  Shape.h
//  Pro_1116BridgePattern
//
//  Created by Tony on 2018/11/16.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawAPI.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Shape <NSObject>
@protected (nonatomic, strong) id<DrawAPI> drawAPI;



@end

NS_ASSUME_NONNULL_END
