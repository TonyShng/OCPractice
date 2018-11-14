//
//  XXDuckEntity.m
//  Pro_1112DuckModel
//
//  Created by Tony on 2018/11/12.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import "XXDuckEntity.h"

@interface XXDuckEntity ()
@property (nonatomic, strong) NSMutableDictionary *innerDictionary;

@end

@implementation XXDuckEntity

id XXDuckEntityCreateWithJson(NSString *json){
    return [[XXDuckEntity alloc]initWithJSONString:json];
}

- (instancetype)initWithJSONString:(NSString *)json
{
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        self.innerDictionary = jsonObject;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    // 这里可以返回任何NSMethondSignature对象,你也可以完全自己构造一个
    
    SEL changedSelector = sel;
    if ([self propertyNameScanFromGetterSelector:sel]) {
        changedSelector = @selector(objectForKey:);
    } else if ([self propertyNameScanFromSetterSelector:sel]){
        changedSelector = @selector(setObject:forKey:);
    }
    return [[self.innerDictionary class] instanceMethodSignatureForSelector:changedSelector];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    NSString *propertyName = nil;
    // Getter
    propertyName = [self propertyNameScanFromGetterSelector:invocation.selector];
    if (propertyName) {
        invocation.selector = @selector(objectForKey:);
        [invocation setArgument:&propertyName atIndex:2];
        [invocation invokeWithTarget:self.innerDictionary];
        return;
    }
    
    propertyName = [self propertyNameScanFromSetterSelector:invocation.selector];
    if (propertyName) {
        invocation.selector = @selector(setObject:forKey:);
        [invocation setArgument:&propertyName atIndex:3];
        [invocation invokeWithTarget:self.innerDictionary];
        return;
    }
    [super forwardInvocation:invocation];
}

- (NSString *)propertyNameScanFromGetterSelector:(SEL)selector
{
    NSString *selectorName = NSStringFromSelector(selector);
    NSUInteger parameterCount = [[selectorName componentsSeparatedByString:@":"] count] - 1;
    if (parameterCount == 0) {
        return selectorName;
    }
    return nil;
}

- (NSString *)propertyNameScanFromSetterSelector:(SEL)selector
{
    NSString *selecotrName = NSStringFromSelector(selector);
    NSUInteger parameterCount = [[selecotrName componentsSeparatedByString:@":"] count] - 1;
    if ([selecotrName hasPrefix:@"set"] && parameterCount == 1) {
        NSUInteger firstColonLocation = [selecotrName rangeOfString:@":"].location;
        return [selecotrName substringWithRange:NSMakeRange(3, firstColonLocation - 3)].lowercaseString;
    }
    return nil;
}



@end
