//
//  XWRACTest.m
//  RACDemo
//
//  Created by 邱学伟 on 2017/3/7.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "XWRACTest.h"
#import "GlobalHeader.h"
#import "Flag.h"


@implementation XWRACTest

+ (void)RACSignal {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [subscriber sendNext:@[@1,@2,@3]];
        return nil;
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据:%@",x);
    }];
}

+ (void)RACDisposable {
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"创建信号订阅者");
        [subscriber sendNext:@123];
        NSLog(@"订阅者发送数据");
       return [RACDisposable disposableWithBlock:^{
           
           NSLog(@"信号被取消订阅");
       }];
    }];
    [signal subscribeNext:^(id  _Nullable x) {
       NSLog(@"信号被订阅");
        NSLog(@"接收数据:%@",x);
    }];
}

+ (void)RACSubject {
    // 创建信号  即可充当信号 又 能作为订阅者
    RACSubject *subject = [RACSubject subject];
    // 订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号");
        NSLog(@"接收到数据:%@",x);
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号2");
        NSLog(@"接收到数据2:%@",x);
    }];
    // 订阅者发送数据
    [subject sendNext:@"456"];
}

+ (void)RACReplaySubject {
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    [replaySubject sendNext:@"hahahaha"];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者一接收数据:%@",x);
    }];
    [replaySubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅者二接收数据:%@",x);
    }];
}

+ (void)arraySequence {
    NSArray *arr = @[@123,@1234,@12345];
    [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

+ (void)dictSequence {
    NSDictionary *dict = @{@"name":@"qxuewei",@"age":@18,@"height":@1.83};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        RACTupleUnpack(NSString *key,NSString *value) = x;
        NSLog(@"key:%@  ++  value:%@",key,value);
    }];
}

+ (void)dictToModel {
    NSString *flagFilePath = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    NSArray *flagArr = [[NSArray alloc] initWithContentsOfFile:flagFilePath];
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    /*
    for (NSDictionary *dict in flagArr) {
        Flag *flag = [Flag flagWithDict:dict];
        [arrM addObject:flag];
    }
     */
    /*
     信号解析 - 注意在异步线程执行
    [flagArr.rac_sequence.signal subscribeNext:^(NSDictionary *dict) {
        Flag *flag = [Flag flagWithDict:dict];
        [arrM addObject:flag];
        
        NSLog(@"++++ arrM.count : %zd  -- %@",arrM.count,[NSThread currentThread]);
    }];
    NSLog(@"arrM.count : %zd  -- %@",arrM.count,[NSThread currentThread]);
     */
    arrM = [[[flagArr.rac_sequence map:^id _Nullable(NSDictionary *value) {
        NSLog(@"+++%@",[NSThread currentThread]);
        return [Flag flagWithDict:value];
    }] array] mutableCopy];
    NSLog(@"%@",arrM);
}

@end
