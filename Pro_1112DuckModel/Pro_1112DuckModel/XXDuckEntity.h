//
//  XXDuckEntity.h
//  Pro_1112DuckModel
//
//  Created by Tony on 2018/11/12.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XXDuckEntity <NSObject, NSCopying, NSCoding>

@property (nonatomic, copy, readonly) NSString *jsonString;
- (void)foo;

@end

@interface XXDuckEntity : NSProxy<XXDuckEntity>

//- (instancetype)initWithJSONString:(NSString *)json;

extern id XXDuckEntityCreateWithJson(NSString *json);

@end

NS_ASSUME_NONNULL_END
