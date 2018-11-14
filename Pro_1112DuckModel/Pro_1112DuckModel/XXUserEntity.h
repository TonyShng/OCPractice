//
//  XXUserEntity.h
//  Pro_1112DuckModel
//
//  Created by Tony on 2018/11/14.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XXUserEntity <NSObject>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, strong) NSNumber *age;

@end

NS_ASSUME_NONNULL_END
