//
//  main.m
//  Pro_1112NSProxy
//
//  Created by Tony on 2018/11/12.
//  Copyright © 2018年 quanyoubao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyProxy.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        dispatch_semaphore_t sem = dispatch_semaphore_create(0);
        
        NSURL *url = [MyProxy proxyForObject:[NSURL URLWithString:@"https://www.google.com"]];
        NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_semaphore_signal(sem);
        }];
        
        [task resume];
        
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
