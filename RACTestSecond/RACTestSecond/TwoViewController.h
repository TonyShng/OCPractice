//
//  TwoViewController.h
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/8.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface TwoViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSignal;

@end

NS_ASSUME_NONNULL_END
