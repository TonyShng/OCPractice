//
//  TwoViewController.h
//  RACTest
//
//  Created by TonyShng on 2019/2/12.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

// 步骤一 : 在第二个控制器.h 添加一个RACSubject代替代理

@interface TwoViewController : UIViewController
@property (nonatomic, strong) RACSubject *delegateSignal;
@end

NS_ASSUME_NONNULL_END
