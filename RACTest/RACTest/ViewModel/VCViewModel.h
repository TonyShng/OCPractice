//
//  VCViewModel.h
//  RACTest
//
//  Created by TonyShng on 2019/1/29.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCViewModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) RACSubject *successObject;
@property (nonatomic, strong) RACSubject *failureObject;
@property (nonatomic, strong) RACSubject *errorObject;

- (id)buttonIsValid;
- (void)login;


@end

NS_ASSUME_NONNULL_END
