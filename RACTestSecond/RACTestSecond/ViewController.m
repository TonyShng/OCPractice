//
//  ViewController.m
//  RACTestSecond
//
//  Created by TonyShng on 2019/4/4.
//  Copyright © 2019 TonyShng. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorMaker.h"
#import "Calculator.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "TwoViewController.h"

@interface ViewController ()
@property (nonatomic, strong) RACCommand *command;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBar;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
    double result = [CalculatorMaker makeCalculator:^(CalculatorMaker * _Nonnull maker) {
        maker.add(1).add(10).sub(5).muilt(3).divide(10);
    }];
    
    NSLog(@"%.2f", result);
    
    Calculator *c = [[Calculator alloc] init];
    BOOL isEqule = [[c calculator:^double(double result) {
        result += 2;
        result *= 5;
        NSLog(@"%.2f", result);
        return result;
    }] equle:^BOOL(double result) {
        return result == 10.0;
    }];
    
    NSLog(@"%d", isEqule);
     */
    
//    [self useRACSignal];
    
    [self useCommand];
    
}

- (void)useRACSignal
{
    /*
     RACSignal 信号类，一般表示将来有数据传递，只要有数据改变，信号内部接收到数据，就会马上发出数据。
     
     // 注意⚠️
     RACSignal 只是表示当数据改变时，信号内部会发出数据，它本身不具备发送信号的能力，而是交给内部一个订阅者去发出。
     
     默认一个信号都是冷信号，也就是值改变了，也不会触发，只有订阅了这个信号，这个信号才会变为热信号，值改变了才会触发。
     
     如何订阅信号： 调用信号RACSignal的subscribeNext就能订阅.
     
     */
    
    
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // block调用时刻： 每当有订阅着订阅信号，就会调用block
        
        // 2. 发送信号
        [subscriber sendNext:@1];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable] 取消订阅信号
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            // block调用时刻，当信号发送完成或者发送错误，就会自动执行这个block， 取消订阅信号
            
            // 执行完block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
        }];
    }];
    
    // 3. 订阅信号 才会激活信号
    [signal subscribeNext:^(id  _Nullable x) {
        // block调用时刻， 每当有信号发出数据，就会调用block
        NSLog(@"接收到数据%@", x);
    }];
    
    // RACSubscriber 表示订阅者的意思，用于发送信号，这是一个协议，不是一个类，只要遵守这个协议，并且实现方法才能成为订阅着。通过create创建的信号，都有一个订阅者，帮助他发送数据。
    
    // RACDisposable 用于取消订阅或者清理资源，当信号发送完成或者发送错误的时候，就会自动触发它。
        // 不想监听某个信号时，可以通过它主动取消订阅信号。
    
    // RACSubject 信号提供者，自己可以充当信号，又能发送信号。
        // 通常用代理代替，有了它，就不必要定义代理了。
    
    // RACReplaySubject 重复提供信号类，RACSubject的子类。
    
    /*
     RACReplaySubject 与 RACSubject 区别:
        RACReplaySubject可以先发送信号，再订阅信号，RACSubject就不可以.
        一、 如果一个信号每被订阅一次，就需要把之前的值重复发送一次，使用重复提供信号类。
        二、 可以设置capacity数量来限制缓存的value的数量，即只缓冲最新的几个值。
     */
    
    // 1. 创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2. 订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        // block调用时刻: 当信号发出新值，就会调用
        NSLog(@"第一个订阅者%@", x);
    }];
    
    [subject subscribeNext:^(id  _Nullable x) {
        // block调用时刻: 当信号发出新值，就会调用
        NSLog(@"第二个订阅者%@",x);
    }];
    
    // 3. 发送信号
    [subject sendNext:@"1"];
    
    // 1. 创建信号
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    
    // 2. 发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者接受到的数据%@", x);
    }];
    
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者接收到的数据%@", x);
    }];
}


- (IBAction)rightBarSelected:(UIBarButtonItem *)sender
{ 
    TwoViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"TwoViewController"];
    vc.delegateSignal = [RACSubject subject];
    [vc.delegateSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了通知按钮");
    }];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)useTuple
{
    // RACTuple 元祖类 类似NSArray， 用来包装值
    
    // RACSequence 集合类 用于代替NSArray NSDictionary 可以使用它来快速遍历数组和字典
    
    // 字典转模型
    NSArray *numbers = @[@1, @2, @3, @4];
    
    // 第一步 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步 把集合RACSequence转换成RACSignal信号类, numbers.rac_sequence.signal
    // 第三步 订阅信号，激活信号，会自动把集合中的所有值，遍历出来
    [numbers.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    
    // 2. 遍历字典 遍历出来的键值对会包装成RACTuple（元祖对象）
    NSDictionary *dict = @{@"name": @"xmg", @"age": @18};
    [dict.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        // 解包元祖，会把元祖的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key, NSString *value) = x;
        
        NSLog(@"%@ -- %@", key, value);
    }];
}

- (void)useCommand
{
    // RACCommand 用于处理事件的类，可以把事件如何处理，事件中的数据 如何传递，包装到这个类中，它可以很方便的监控事件执行的过程
        // 监听按钮点击，网络请求
    // 注意⚠️
    /*  1. signalBlock 必须要返回一个信号，不能传nil
        2. 如果不想要传递信号，直接创建空的信号[RACSignal empty];
        3. RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted], 这时命令才会执行完毕，否则永远处于执行中。
        4. RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
    */
    
    // 三、 RACCommand设计思想 内部signalBlock为什么要返回一个信号，这个信号有什么用
    // 1. 在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2. 当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候需要通过signalBlock返回的信号传递了。
    
    // 四、 如何拿到RACCommand中返回信号发出的数据
    // 1. RACCommand有个执行信号executionSignals, 这个是signal of signals（信号的信号），意思是信号发出的数据是信号，不是普通的类型。
    // 2. 订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    
    // 五、 监听当前命令是否正在执行executing
    
    // 六、 使用场景，监听按钮点击 网络请求
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令");
        
        // 创建空信号，必须返回信号
//        return [RACSignal empty];
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            /// 数据传递完， 最好调用sendCompleted,这时命令才执行完毕
            [subscriber sendCompleted];
            
            return nil;
        }];
        
    }];
    
    // 强引用命令， 不要被销毁， 否则接收不到数据
    _command = command;
    
    // 3. 订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@", x);
        }];
    }];
    
    // RAC高级用法
    // switchToLatest 用于signal of signals 获取signal of signals 发出的最新信号，也就是可以直接拿到rRACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 4. 监听命令是否执行完毕，默认会来一次，可以直接跳过，skip表示跳过第一次信号
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
        } else {
            // 执行完毕
            NSLog(@"执行完毕");
        }
    }];
    
    // 5. 执行命令
    [self.command execute:@1];
}

- (void)useMulticastConnection
{
    // 用于当一个信号，被多次订阅时，为了保证创建信号时，避免多次调用创建信号中的block，造成副作用,可以使用这个类处理
    // 注意 RACMulticastConnection通过RACSignal的 -publish 或者 -muticast 方法创建
    
    // RACMulticastConnection使用步骤
    // 1. 创建信号
    // 2. 创建连接
    // 3. 订阅信号 注意：订阅的不在是之前的信号，而是连接的信号。
    // 4. 连接
    
    // RACMulticastConnect底层原理:
    // 1.创建connect， connect.sourceSignal -> RACSignal（原始信号） connect.signal -> RACSubject
    // 2. 订阅connect.signal 会调用RACSubejct的subscribeNext 创建订阅者，而且把订阅者保存起来，不会执行block
    // 3. [connect connect] 内部会订阅RACSignal（原始信号），并且订阅者是RACSubject
    //
    
    // 1. 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求");
        return nil;
    }];
    
    // 2. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据");
    }];
    
    // 2. 订阅信号
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收数据");
    }];
    
    // 3. 运行结果, 会执行两遍发送请求, 也就是每次订阅都会发送一次请求
    
    // RACMulticastConnection: 解决重复请求问题
    // 1. 创建信号
    RACSignal *signal_two = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送请求");
        return nil;
    }];
    
    // 2. 创建连接
    RACMulticastConnection *connect = [signal_two publish];
    
    // 3. 订阅信号 注意 订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接，当调用连接，就会一次性调用所有订阅者的subscribeNext:
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者一信号");
    }];
    
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者二信号");
    }];
    
    // 4. 连接 激活信号
    [connect connect];
    
    // RACScheduler RAC中的队列，用GCD封装的
    // RACUnit 表示stream不包含有意义的值，也就是看到这个，可以直接理解为nil
    // RACEvent 把数据包装成信号事件（signal event） 它主要通过RACSignal的materialize来使用,然并卵
}

- (void)commonUse
{
    // rac_signalForSelector 用于代替代理
    [[self.rightBar rac_signalForSelector:@selector(rightBarSelected:)] subscribeNext:^(RACTuple * _Nullable x) {
        NSLog(@"点击了rightBar");
    }];
    // rac_valuesAndChangesForKeyPath: 用于监听某个对象的属性改变
    [[self.view rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        NSLog(@"%@", x);
    }];
    // rac_signalForControlEvents 用于监听某个事件
    
    // rac_addObserverForName 用于监听某个通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"键盘弹出");
    }];
    // rac_textSignal 只要文本框发出改变就会发出这个信号
    // rac_liftSelector: withSignalsFromArray:Signals: 当传入的Signal（信号数组）,每一个signal都至少sendNext过一次，就会触发第一个selector参数的方法 使用注意 几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    RACSignal *request1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求1
        [subscriber sendNext:@"发送请求1"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        // 发送请求2
        [subscriber sendNext:@"发送请求2"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1, request2]];
}

- (void)commonDefault
{
    // RAC(TARGET, [KEYPATH, [NIL_VALUE]]):用于给某个对象的某个属性绑定。
    // 只要文本框文字改变，就会修改label的文字
//    RAC(self.labelView,text) = _textField.rac_textSignal;
    
    // RACObserve(self, name):监听某个对象的某个属性,返回的是信号。
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // RACTuplePack：把数据包装成RACTuple（元组类）
    // 把参数中的数据包装成元组
//    RACTuple *tuple = RACTuplePack(@10,@20);
    RACTuple *tuple = RACTuplePack(@"xmg",@20);
    
    // RACTupleUnpack：把RACTuple（元组类）解包成对应的数据。
    // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
    // name = @"xmg" age = @20
    RACTupleUnpack(NSString *name,NSNumber *age) = tuple;
}

- (void)commonBind
{
    [_textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"输出%@", x);
    }];
    
//    [[_textField.rac_textSignal bind:^RACSignalBindBlock _Nonnull{
//        // 什么时候调用:
//        // block: 表示绑定了一个信号.
//        return ^(RACStream *(id value, BOOL *stop)) {
//            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@", value]];
//        };
//    }] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
}

- (void)commonMap
{
    //    [[_textField.rac_textSignal flattenMap:^__kindof RACSignal * _Nullable(NSString * _Nullable value) {
    //        return [RACReturnSignal return:[NSString stringWithFormat:@"输出%@", value]];
    //    }] subscribeNext:^(id  _Nullable x) {
    //        NSLog(@"%@", x);
    //    }];
    
    [[_textField.rac_textSignal map:^id _Nullable(NSString * _Nullable value) {
        return [NSString stringWithFormat:@"输出%@", value];
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonConcat
{
    // 按一定顺序拼接信号，当多个信号发出的时候，有顺序的接收信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 把signalA 拼接到SignalB后，SignalA发送完成，signalB才会被激活.
    RACSignal *concatSignal = [signalA concat:signalB];
    
    // 以后只需要面对拼接信号开发。
    // 订阅拼接的信号，不需要单独订阅signalA signalB
    // 内部会自动订阅
    // 注意 第一个信号必须发送完成，第二个信号才会被激活
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commenThen
{
    // then 用于连接两个信号，当第一个信号完成，才会连接then返回的信号
    // 注意使用then 之前信号的值会被忽略掉。
    // 底层实现： 1、 先过滤掉之前的信号发出的值 2、 使用concat连接then返回的信号
    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] then:^RACSignal * _Nonnull{
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@2];
            return nil;
        }];
    }] subscribeNext:^(id  _Nullable x) {
        // 只能接收到第二个信号的值，也就是then返回信号的值
        NSLog(@"%@", x);
    }];
}

- (void)commonMerge
{
    // merge 把多个信号合并成一个信号
    // 创建多个信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 合并信号,任何一个信号发送数据，都能监听到
    RACSignal *mergeSignal = [signalA merge:signalB];
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonZip
{
    // zipWith 把两个信号压缩成一个信号，只有当两个信号同时发出信号内容时，并且把两个信号的内容合并成一个元祖，才会触发压缩流的next事件.
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 压缩信号A 信号B
    RACSignal *zipSignal = [signalA zipWith:signalB];
    
    [zipSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}

- (void)commonCombineLatest
{
    // combineLatest 将多个信号合并起来，并且拿到各个信号的最新的值，必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    // 把两个信号组合成一个信号， 跟zip一样，没什么区别
    RACSignal *combineSignal = [signalA combineLatestWith:signalB];
    
    [combineSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonReduce
{
    // reduce 聚合 用于信号发出的内容是元组，把信号发出元组的值聚合成一个值
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@2];
        return nil;
    }];
    
    /*
     聚合
     常见的用法，（先组合再聚合）. combineLatest:(id<NSFastEnumeration>)signals reduce:(id (^)())reduceBlock
     reduce中的block简介:
     reduceblock中的参数,有多少信号组合,reduceblock就有多少个参数，每个参数就是之前信号发出的内容
     reduceblock的返回值：聚合信号之后的内容
     */
    
    RACSignal *reduceSignal = [RACSignal combineLatest:@[signalA, signalB] reduce:^id(NSNumber *num1, NSNumber *num2){
        return [NSString stringWithFormat:@"%@ %@", num1, num2];
    }];
    
    [reduceSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonFilter
{
    // 过滤 每次信号发出，会先执行过滤条件判断
    [_textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
        return value.length > 3;
    }];
}

- (void)commonIgnore
{
    // 内部调用filter过滤，忽略掉ignore的值
    [[_textField.rac_textSignal ignore:@"1"] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonDistinctUnitlChanged
{
    // 过滤， 当上一次和当前的值不一样，就会发出内容
    // 在开发中，刷新UI经常使用，只有两次数据不一样才需要刷新
    [[_textField.rac_textSignal distinctUntilChanged] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonTake
{
    // 从开始一共取N次的信号
    // 1 创建信号
    RACSubject *signal = [RACSubject subject];
    
    // 2 处理信号
    [[signal take:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 3 发送信号
    [signal sendNext:@1];
    [signal sendNext:@2];
}

- (void)commonTakeLast
{
    // 取最后N次的信号 前提条件 订阅者必须调用完成 因为只有完成 就知道总共有多少信号
    // 1. 创建信号
    RACSubject *signal = [RACSubject subject];
    
    // 2. 处理信号 订阅信号
    [[signal takeLast:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    // 3. 发送信号
    [signal sendNext:@1];
    [signal sendNext:@2];
    [signal sendCompleted];
}

- (void)commonTakeUntil
{
    // 获取信号直到某个信号执行完成
    
    // 监听文本框的改变直到当前对象被销毁
    [_textField.rac_textSignal takeUntil:self.rac_willDeallocSignal];
}

- (void)commonSkip
{
    // 跳过几个信号 不接受
    [[_textField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonSwitchToLatest
{
    // 用于signalOfSignals (信号的信号) 有时候信号也会发出信号， 会在signalOfSignal中，获取signalOfSignals发出的最新信号
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    
    // 获取信号中信号最近发出的信号， 订阅最近发出的信号
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [signalOfSignals sendNext:signal];
    [signal sendNext:@1];
}

- (void)commonDoNext
{
    // 执行Next之前，会执行这个Block
    // doCompleted 执行sendCompleted之前，会先执行这个block
    
    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] doNext:^(id  _Nullable x) {
        // 执行[subscriber sendNext@1]; 之前会调用这个block
        NSLog(@"doNext");
    }] doCompleted:^{
        // 执行[subscriber sendCompleted]; 之前会调用这个Block
        NSLog(@"doCompleted");
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonThread
{
    // deliverOn 内容传递切换到指定线程中，副作用在原来线程中，把在创建信号时Block中的代码称之为副作用
    
    // subscriberOn 内容传递和副作用都会切换到指定线程中
}

- (void)commonTimeOut
{
    // 超时 可以让一个信号在一定的时间后，自动报错
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        return nil;
    }] timeout:1 onScheduler:[RACScheduler currentScheduler]];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } error:^(NSError * _Nullable error) {
        // 1秒后会自动调用
        NSLog(@"%@", error);
    }];
}

- (void)commonInterval
{
    // 定时 每隔一段时间发出信号
    [[RACSignal interval:1 onScheduler:[RACScheduler currentScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonDelay
{
    // 延迟发送next
    RACSignal *signal = [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        return nil;
    }] delay:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}

- (void)commonRetry
{
    // 重试 只要失败 就会重新执行创建信号中的block 直到成功
    __block int i = 0;
    [[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        if (i == 10) {
            [subscriber sendNext:@1];
        } else{
            NSLog(@"接收到错误");
            [subscriber sendError:nil];
        }
        i++;
        return nil;
    }] retry] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    } error:^(NSError * _Nullable error) {
    }];
}

- (void)commonReplay
{
    // 重放 当一个信号被多次订阅 反复播放内容
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendNext:@2];
        return nil;
    }] replay];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第一个订阅者%@", x);
    }];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"第二个订阅者%@", x);
    }];
    
}

- (void)commonThrottle
{
    // 节流 当某个信号发送比较频繁时，可以使用节流，在某一段时间不发送信号内容，过一段时间获取信号的最新内容发出
    RACSubject *signal = [RACSubject subject];
    
    // 节流 在一定时间(1秒)内，不接受任何信号内容，过了这个时间(1秒)获取最后发送的信号内容发出
    [[signal throttle:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}


// 更新UI
- (void)updateUIWithR1:(id)data r2:(id)data1
{
    NSLog(@"更新UI%@  %@",data,data1);
}

@end
