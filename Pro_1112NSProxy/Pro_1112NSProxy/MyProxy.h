//
//  MyProxy.h
//  Pro_1112NSProxy
//
//  Created by Tony on 2018/11/12.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyProxy : NSProxy
{
    id _object;
}

+ (id)proxyForObject:(id)obj;

@end

NS_ASSUME_NONNULL_END
