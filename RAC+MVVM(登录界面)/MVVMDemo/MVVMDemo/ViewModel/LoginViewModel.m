//
//  LoginViewModel.m
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "LoginViewModel.h"
#import "TwpVC.h"

@implementation LoginViewModel
- (instancetype)init{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _loginEnableSignal = [RACSignal combineLatest:@[RACObserve(self, account),RACObserve(self, pwd)] reduce:^id (NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    [self setUpLoginCommand];
}

- (void)setUpLoginCommand {
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 请求数据
        NSLog(@"接收到命令传入的值: %@",input);
        RACSignal *resultSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [subscriber sendNext:@YES];
                [subscriber sendCompleted];
            });
            return nil;
        }];
        return resultSignal;
    }];
    
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"命令正在执行");
        }else{
            NSLog(@"命令执行完毕");
        }
    }];
    
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅源信号发送的值:%@",x);
    }];
    
}
@end
