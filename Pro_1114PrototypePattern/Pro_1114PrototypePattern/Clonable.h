//
//  Clonable.h
//  Pro_1114PrototypePattern
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Clonable <NSObject>
@property (nonatomic, copy) NSString *ids;
@property (nonatomic, copy) NSString *type;

- (void)draw;


@end

NS_ASSUME_NONNULL_END
