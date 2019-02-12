//
//  ViewController.m
//  RACTest
//
//  Created by TonyShng on 2019/1/29.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "VCViewModel.h"
#import "ViewController/LoginSuccessViewController.h"

@interface ViewController ()
@property (nonatomic, strong)VCViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // https://www.cnblogs.com/ludashi/p/4925042.html
    
    /// -- 2. Sequence Map
    /*
     // rac_sequence方法生成Sequence
     RACSequence *sequence = [@[@"you", @"are", @"beautiful"] rac_sequence];
     
     RACSignal *signal = sequence.signal;
     // 首字母大写
     RACSignal *capitalizedSignal = [signal map:^id _Nullable(id  _Nullable value) {
     return [value capitalizedString];
     }];
     
     [signal subscribeNext:^(id  _Nullable x) {
     NSLog(@"signal -- %@", x);
     }];
     
     [capitalizedSignal subscribeNext:^(id  _Nullable x) {
     NSLog(@"capitalizedSignal --- %@", x);
     }];
     
     // 简化
     [self uppercaseString];
     */
    
    
    /// -- 3. Switch
    //    [self signalSwitch];
    
    /// -- 4. 信号的合并 combineLatest
    //    [self combiningLatest];
    
    /// -- 5. 信号的合并 merge
    //    [self merge];
    
    [self bindModel];
    [self onClick];
    
}

- (void)uppercaseString
{
    [[[@[@"thank'u", @"very", @"much"] rac_sequence].signal map:^id _Nullable(id  _Nullable value) {
        return [value capitalizedString];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"uppercaseString -- %@", x);
    }];
}


/// 信号开关
- (void)signalSwitch
{
    // 创建3个自定义信号
    RACSubject *google = [RACSubject subject];
    RACSubject *baidu = [RACSubject subject];
    RACSubject *signalOfSignal = [RACSubject subject];
    
    // 获取开关信号  通过switchToLatest加工成开关信号
    RACSignal *switchSignal = [signalOfSignal switchToLatest];
    
    // 对通过开关的信号进行操作
    [[switchSignal map:^id _Nullable(id  _Nullable value) {
        return [@"https//www." stringByAppendingFormat:@"%@", value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 通过开关打开百度
    [signalOfSignal sendNext:baidu];
    [baidu sendNext:@"baidu.com"];
    [google sendNext:@"google.com"];
    
    // 通过开关打开google
    [signalOfSignal sendNext:google];
    [baidu sendNext:@"baidu.com/"];
    [google sendNext:@"google.com/"];
    
}

// 组合信号
- (void)combiningLatest
{
    // 创建两个自定义的信号
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    
    // 通过combineLatest函数合并两个信号  reduce块中是合并规则，把numbers中的值拼接到letters信号的值的后面
    [[RACSignal combineLatest:@[letters, numbers] reduce:^(NSString *letter, NSString *number){
        return [letter stringByAppendingString:number];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 通过sendNext方法往信号中发送值
    [letters sendNext:@"A"];
    [letters sendNext:@"B"];
    [numbers sendNext:@"1"];
    [letters sendNext:@"C"];
    [numbers sendNext:@"2"];
}

// 信号的合并
- (void)merge
{
    RACSubject *letters = [RACSubject subject];
    RACSubject *numbers = [RACSubject subject];
    RACSubject *chinese = [RACSubject subject];
    
    /// 合并上面创建的三个信号 都走这个方法
    [[RACSignal merge:@[letters, numbers, chinese]] subscribeNext:^(id  _Nullable x) {
        NSLog(@"merge: %@", x);
    }];
    
    // 往信号中灌入数据
    [letters sendNext:@"AAA"];
    [numbers sendNext:@"666"];
    [chinese sendNext:@"你好"];
}

#pragma mark - Demo

- (void)bindModel
{
    _viewModel = [[VCViewModel alloc] init];
    
    RAC(self.viewModel, userName) = self.userNameTextField.rac_textSignal;
    RAC(self.viewModel, password) = self.passwordTextField.rac_textSignal;
    RAC(self.loginButton, enabled) = [_viewModel buttonIsValid];
    
    @weakify(self);
    
    [self.viewModel.successObject subscribeNext:^(NSArray *x) {
        @strongify(self);
        LoginSuccessViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginSuccessViewController"];
        vc.userName = x[0];
        vc.password = x[1];
        [self presentViewController:vc animated:YES completion:nil];
    }];
    
    
    // fail
    [self.viewModel.failureObject subscribeNext:^(id  _Nullable x) {
    }];
    
    // error
    [self.viewModel.errorObject subscribeNext:^(id  _Nullable x) {
    }];
}

- (void)onClick
{
    @weakify(self);
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.viewModel login];
    }];
}



@end
