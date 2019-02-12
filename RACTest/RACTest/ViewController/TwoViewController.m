//
//  TwoViewController.m
//  RACTest
//
//  Created by TonyShng on 2019/2/12.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/// 步骤二 : 监听第二个控制器按钮点击
- (IBAction)touchButton:(UIButton *)sender
{
    // 通知第一个控制器， 告诉它， 按钮被点击了
    
    // 通知代理
    
    // 判断代理信号是否有值
    
    if (self.delegateSignal) {
        [self.delegateSignal sendNext:nil];
    }
    
}

@end
