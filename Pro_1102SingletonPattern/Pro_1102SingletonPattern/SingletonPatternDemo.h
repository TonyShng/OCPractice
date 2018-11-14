//
//  SingletonPatternDemo.h
//  Pro_1102SingletonPattern
//
//  Created by Tony on 2018/11/2.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DJ_SINGLETON_DEF(_type_) + (_type_ *)sharedInstance;\
+(instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));\
+(instancetype) new __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) copy __attribute__((unavailable("call sharedInstance instead")));\
-(instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));\


#define DJ_SINGLETON_IMP(_type_) + (_type_ *)sharedInstance{\
static _type_ *theSharedInstance = nil;\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
theSharedInstance = [[super alloc] init];\
});\
return theSharedInstance;\
}


NS_ASSUME_NONNULL_BEGIN

@interface SingletonPatternDemo : NSObject

+ (instancetype)shareInstance;

/// 告知alloc方法不可用 请使用单例
+ (instancetype) alloc __attribute__((unavailable("call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("call sharedInstance instead")));
- (instancetype) copy __attribute__((unavailable("call sharedInstance instead")));
- (instancetype) mutableCopy __attribute__((unavailable("call sharedInstance instead")));

- (void)showMessage;

@end

NS_ASSUME_NONNULL_END
