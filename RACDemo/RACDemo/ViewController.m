//
//  ViewController.m
//  RACDemo
//
//  Created by 邱学伟 on 2017/3/7.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "GlobalHeader.h"
#import "XWRACTest.h"
#import "XWGCDManager.h"
#import "TwoVC.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toTwoVCBtn;
@property (weak, nonatomic) IBOutlet UITextField *testTF;
@property (weak, nonatomic) IBOutlet UITextField *testTF2;
@property (weak, nonatomic) IBOutlet UIButton *sent123NotiBtn;
@property (weak, nonatomic) IBOutlet UILabel *testTFLabel;

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [XWRACTest RACSignal];
//    [XWRACTest RACDisposable];
//    [XWRACTest RACSubject];
//    [XWRACTest RACReplaySubject];
    
//    [XWRACTest arraySequence];
//    [XWRACTest dictSequence];
//    [XWRACTest dictToModel];
    
//    [self addTargetMethod];
//    [self replaceNotification];
//    [self monitorTextField];
//    
//    [self RACLiftSeector];
    
//    [self testTFLabelDefine];
    
//    [self commonRACSignal];
//    [self RACMulticastConnect];
//    [self RACMulticastConnectReply];
    
//    [self RACCommand3];
//    [self RACBind];
//    [self RACMap];
//    [self flattenMap2];
//    [self concatSignal];
    [self thenSignal];
//    [self mergeSignal];
    
//    [self zipSignal];
//    [self zipSignal2];
//    [self reduceSignal];
//    [self reduceSignal2];
//    [self filterSignal];
//    [self ignoreSignal];
//    [self takeSignal];
//    [self takeLastSignal];
//    [self takeUntilSignal];
//    [self distinctUntilChangedSignal];
//    [self skipSignal];
//    [self sendSignal];
//    [self sequence];
}

// 信号秩序
- (void)sendSignal {

    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"发送数据 1");
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] doNext:^(id  _Nullable x) {
        NSLog(@"do next : %@",x);
    }] doCompleted:^{
        NSLog(@"doCompleted");
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收订阅数据 : %@",x);
    }];
}

// skip 跳过 前几次 信号后订阅并处理
- (void)skipSignal {
    
    RACSubject *subject = [RACSubject subject];
    [[subject skip:3] subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅 跳过 3次信号后接收数据 : %@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendNext:@4];
}

// distinctUntilChanged 约束: 只有在源信号发送不同数据才会订阅并处理数据
- (void)distinctUntilChangedSignal {
    
    RACSubject *subject = [RACSubject subject];
    [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅后处理数据 : %@",x);
    }];
    [subject sendNext:@1];
    [subject sendNext:@1];  //与上次相同 不处理
    [subject sendNext:@2];
    [subject sendNext:@3];
    [subject sendNext:@3];  //与上次相同 不处理
}

// taleUntil 传入信号发送任意信号或发送完成后 停止接收源信号发送数据
- (void)takeUntilSignal {
    
    RACSubject *subject = [RACSubject subject];
    RACSubject *untilSignal = [RACSubject subject];
    [[subject takeUntil:untilSignal] subscribeNext:^(id  _Nullable x) {
        NSLog(@"提取目标信号发送完成之前发送的值 接收数据: %@",x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [untilSignal sendNext:@"0"];
    //或
//    [untilSignal sendCompleted];
    [subject sendNext:@"3"];
    [subject sendCompleted];
}

// takeLast 提取信号 (提取后n个值)  - 注意发送完信号需要结束发送
- (void)takeLastSignal {
    
    RACSubject *subject = [RACSubject subject];
    [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"提取发送的后两个值 接收数据: %@",x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
    [subject sendCompleted];
}

// take 提取信号 (提取前n个值)
- (void)takeSignal {
    
    RACSubject *subject = [RACSubject subject];
    [[subject take:2] subscribeNext:^(id  _Nullable x) {
        NSLog(@"提取发送的前两个值 接收数据: %@",x);
    }];
    [subject sendNext:@"1"];
    [subject sendNext:@"2"];
    [subject sendNext:@"3"];
}

// ignore 忽略信号
- (void)ignoreSignal {
    
    RACSubject *subject = [RACSubject subject];
    // 忽略内容 - 凡是发送的信号中有@12 均忽略
    RACSignal *ignoreSignal = [subject ignore:@"12"];
//    [subject ignoreValues];  -> 忽略所有值
    [ignoreSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"忽略信号接收数据:%@",x);
    }];
    [subject sendNext:@"12"];
    [subject sendNext:@"123"];
}

// filter 过滤信号
- (void)filterSignal {
    
    [[_testTF.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
       // 过滤条件
        return value.length > 3;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"过滤后的信号数据: %@",x);
    }];
}

// 聚合信号  可以返回所聚合信号的内容, 可用于监听文本框输入
- (void)reduceSignal2 {
    
    // reduce 后值需要与所聚合信号发送的数据一一对应
    RACSignal *reduceSignal = [RACSignal combineLatest:@[_testTF.rac_textSignal,_testTF2.rac_textSignal] reduce:^id (NSString *testTFText, NSString *testTF2Text){
        return @(testTFText.length && testTF2Text.length);
    }];
    // 为某对象某参数绑定一个信号
    RAC(_toTwoVCBtn, enabled) = reduceSignal;
    
}

- (void)reduceSignal {
    
    NSArray *enumeration = @[_testTF.rac_textSignal, _testTF2.rac_textSignal];
    RACSignal *combineLatestSignal = [RACSignal combineLatest:enumeration reduce:^id(NSString *testTFText,NSString *testTF2Text){
        
        return @"123";
    }];
    [combineLatestSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅组合信号  接收数据:%@",x);
        
    }];
}

// 会将所压缩的信号发送的数据包装成元组, 注意需要压缩信号先订阅 再发送数据
// 应用场景: 等所有信号发送完成才会调用 -> 所有网络请求完成更新UI
- (void)zipSignal {
    
    RACSubject *subjectA = [RACSubject subject];
    RACSubject *subjectB = [RACSubject subject];
    RACSignal *zipSignal = [subjectA zipWith:subjectB];
    [zipSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"压缩信号接收到数据: %@",x);
    }];
    [subjectA sendNext:@"A 数据"];
    [subjectB sendNext:@"B 数据"];
}


- (void)zipSignal2 {
    
    RACSubject *loadImage1 = [RACSubject subject];
    RACSubject *loadImage2 = [RACSubject subject];
    RACSubject *loadImage3 = [RACSubject subject];
    RACSignal *zipSignal = [[loadImage1 zipWith:loadImage2] zipWith:loadImage3];
    [zipSignal subscribeNext:^(RACTuple  *imageTuple) {
        NSLog(@"订阅接收数据:%@    ++   更新图片线程:%@",imageTuple,[NSThread currentThread]);
        RACTupleUnpack(RACTuple *imageTuple12, UIImage *image3) = imageTuple;
        RACTupleUnpack(UIImage *image1, UIImage *image2) = imageTuple12;
        [_imageView1 setImage:image1];
        [_imageView2 setImage:image2];
        [_imageView3 setImage:image3];
    }];
    [XWGCDManager executeInGlobalQueue:^{
        NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/140915/0114515533-3.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        NSLog(@"图片 1 下载线程:%@",[NSThread currentThread]);
        [XWGCDManager executeInMainQueue:^{
            [loadImage1 sendNext:image];
        }];
    }];
    
    [XWGCDManager executeInGlobalQueue:^{
        NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/140915/0114514437-7.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        NSLog(@"图片 2 下载线程:%@",[NSThread currentThread]);
       [XWGCDManager executeInMainQueue:^{
           [loadImage2 sendNext:image];
       }];
    }];
    
    [XWGCDManager executeInGlobalQueue:^{
        NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/140915/0114516213-5.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        NSLog(@"图片 3 下载线程:%@",[NSThread currentThread]);
       [XWGCDManager executeInMainQueue:^{
           [loadImage3 sendNext:image];
       }];
    }];
}

// 将多个信号订阅放在一个信号中处理
- (void)mergeSignal {
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据A");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据B");
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];

    RACSignal *mergeSignal = [signalA merge:signalB];
    [mergeSignal subscribeNext:^(id  _Nullable x) {
        // 任意一个信号发送数据都会调用!
        NSLog(@"合并信号接收到数据: %@",x);
    }];
}

// then  应用场景: 忽略第一个信号发送的内容 (请求数据A 依然会执行)
- (void)thenSignal {
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据A");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据B");
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *thenSignal = [signalA then:^RACSignal * _Nonnull{
        return signalB;
    }];
    
    [thenSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"then 接收到信号:%@",x);
    }];
    
}

// 组合信号 应用场景 : 信号需要按顺序执行
- (void)concatSignal {
    
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据A");
        [subscriber sendNext:@"数据A"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据B");
        [subscriber sendNext:@"数据B"];
        [subscriber sendCompleted];
        return nil;
    }];
    
    //concat 会按顺序连接
    RACSignal *concatSignal = [signalA concat:signalB];
    [concatSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅组合信号  接收数据:  %@",x);
    }];
}

//flattenMap 主要用于处理信号中的信号
- (void)flattenMap2 {
    
    RACSubject *signalOfSignals = [RACSubject subject];
    RACSubject *signal = [RACSubject subject];
    /*
     订阅信号中信号方式1:
    [signalOfSignals subscribeNext:^(RACSignal *x) {
        [x subscribeNext:^(id  _Nullable x) {
            NSLog(@"接收到数据 : %@",x);
        }];
    }];
     */
    
    /*
    订阅信号中的信号方式2
    [signalOfSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到数据 : %@",x);
    }];
     */
    
//    订阅信号中的信号方式3
    [[signalOfSignals flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        return value;
    }] subscribeNext:^(id  _Nullable x) {
       NSLog(@"接收到数据 : %@",x);
    }];
    [signalOfSignals sendNext:signal];
    [signal sendNext:@"lovke"];
}


// 处理发送数据可用如下三种方式
/// map 映射 可以修改发送的数据
- (void)RACMap {
    
    RACSubject *subject = [RACSubject subject];
    RACSignal *bindSignal = [subject map:^id _Nullable(id  _Nullable value) {
       return [NSString stringWithFormat:@" %@ 是 qxuewei",value];
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号 -> 接收数据:%@",x);
    }];
    [subject sendNext:@"wo"];
}

- (void)RACFlattenMap1 {
    
    RACSubject *subject = [RACSubject subject];
    RACSignal *bindSignal = [subject flattenMap:^__kindof RACSignal * _Nullable(id  _Nullable value) {
        
        value = [NSString stringWithFormat:@"xw_%@",value];
        return [RACReturnSignal return:value];
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号-> 接收数据:%@",x);
    }];
    [subject sendNext:@"HEHEHHEHE"];
}

- (void)RACBind {
    
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    RACSignal *bindSignal = [replaySubject bind:^RACSignalBindBlock _Nonnull{
        // 信号被订阅时调用
        NSLog(@"信号绑定操作");
        return ^RACSignal *(id value, BOOL *stop){
            //源信号发送数据就会调用 -> 处理源信号发送的数据
            
            NSLog(@"value : %@, stop : %@",value,stop?@"YES":@"NO");
            return [RACReturnSignal return:value];
        };
    }];
    [bindSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅信号:%@",x);
    }];
    [replaySubject sendNext:@12];
    
}


// 使用RAC 命令必须在发送完数据后手动结束发送
- (void)RACCommand3 {
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令传入的 : %@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSLog(@"发送执行结果 nn");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [command execute:@"paramter"];
    [[command executing] subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"执行状态:%@",x);
        if ([x boolValue]) {
            NSLog(@"命令正在执行");
        }else{
            NSLog(@"命令尚未执行/执行完成");
        }
    }];
     
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"获取到执行结果: %@ 进行相应操作",x);
    }];
}

// 根据命令中信号源进行操作  必须先订阅在执行命令
- (void)RACCommand2 {
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令传入参数:%@",input);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"result"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    /*
    [command.executionSignals subscribeNext:^(RACSignal *signal) {
        [signal subscribeNext:^(id  _Nullable x) {
            NSLog(@"根据 %@ 进行下一步操作",x);
        }];
    }];
     */
    // 等价于^   executionSignals.switchToLatest   信号源中最近一个信号(switchToLatest  -> 信号中的信号)
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"根据 %@ 进行下一步操作",x);
    }];
    [command execute:@"parameter"];
}

// RACCommand 接收订阅者发出信号方式一: 直接订阅
- (void)RACCommand1 {
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"所转入的参数:%@",input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [subscriber sendNext:@"执行命令产生的数据 mm "];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    RACSignal *signal = [command execute:@"hahaha"];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"接收到订阅信号发出的数据: %@",x);
    }];
}

- (void)RACMulticastConnectReply {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求数据");
        [subscriber sendNext:@"zz"];
        return nil;
    }];
    RACMulticastConnection *multicastConnection2 = [signal multicast:[RACReplaySubject subject]];
    [multicastConnection2.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅数据1 : %@",x);
    }];
    [multicastConnection2.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅数据2 : %@",x);
    }];
    [multicastConnection2 connect];
}

/// RACMulticastConnect 解决订阅重复请求数据问题
- (void)RACMulticastConnect {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"请求xx数据");
        [subscriber sendNext:@"xx"];
        return nil;
    }];
    RACMulticastConnection *multicastConnection = [signal publish];
    [multicastConnection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅1 : %@",x);
    }];
    [multicastConnection.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"订阅2 : %@",x);
    }];
    [multicastConnection connect];
}

- (void)commonRACSignal {
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"commonRACSignal - 请求yy数据");
        [subscriber sendNext:@"commonRACSignal - yy"];
        return nil;
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"commonRACSignal 订阅1 : %@",x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"commonRACSignal 订阅2 : %@",x);
    }];
    
}

// 常用 宏
- (void)testTFLabelDefine {
    
    // 给某对象某属性绑定某信号
    RAC(_testTFLabel,text) = _testTF.rac_textSignal;
    
    // 为某对象某属性添加KVO监听
    [RACObserve(self.testTF, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"RACObserve text 属性正在变化:%@",x);
    }];
    //等价于^
    [[self.testTF rac_valuesForKeyPath:@"text" observer:nil] subscribeNext:^(id  _Nullable x) {
        NSLog(@"rac_valuesForKeyPath text 属性正在变化:%@",x);
    }];
    @weakify(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        @strongify(self);
        self.testTF.text = @"123123";
    });
    
    RACTuple *tuple = RACTuplePack(@"12",@"34");
    NSLog(@"tuple[1]: %@",tuple[1]);
    RACTupleUnpack(NSString *key, NSString *value) = tuple;
    NSLog(@"key: %@  value: %@",key,value);
}

- (void)RACLiftSeector {
    
    RACSignal *loadImage1Signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/140915/0114515533-3.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        [subscriber sendNext:image];
        NSLog(@"图片 1 下载线程:%@",[NSThread currentThread]);
        return nil;
    }];
    RACSignal *loadImage1Signa2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/140915/0114514437-7.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        [subscriber sendNext:image];
        NSLog(@"图片 2 下载线程:%@",[NSThread currentThread]);
        return nil;
    }];
    RACSignal *loadImage1Signa3 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSURL *url = [NSURL URLWithString:@"http://img1.36706.com/lipic/allimg/140915/0114516213-5.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        [subscriber sendNext:image];
        NSLog(@"图片 3 下载线程:%@",[NSThread currentThread]);
        return nil;
    }];
    
    [self rac_liftSelector:@selector(showImages:image2:image3:) withSignals:loadImage1Signal,loadImage1Signa2,loadImage1Signa3, nil];
}

- (void)showImages:(UIImage *)image1 image2:(UIImage *)image2 image3:(UIImage *)image3 {
    
//    self.imageView1.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView2.contentMode = UIViewContentModeScaleAspectFit;
//    self.imageView3.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView1.image = image1;
    self.imageView2.image = image2;
    self.imageView3.image = image3;
    NSLog(@"展示图片的线程:%@",[NSThread currentThread]);
}

- (void)monitorTextField {
    
    [self.testTF.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"文本框内容改变:%@",x);
    }];
}

- (void)replaceNotification {
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"123Noti" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"接收到123通知:%@",x);
    }];
}

- (void)addTargetMethod {
    
//    [self.toTwoVCBtn addTarget:self action:@selector(toTwoVC) forControlEvents:UIControlEventTouchUpInside];
    
    // RAC 监听按钮点击  代替如上方法
    @weakify(self);
    [[self.toTwoVCBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self toTwoVC];
    }];
    
    [[self.sent123NotiBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"123Noti" object:@"123Noti"];
    }];
}

- (void)toTwoVC {
    
    TwoVC *twoVC = [[TwoVC alloc] init];
    /*
     RAC 代替代理方式一RACSubject: 有传值时使用
    [twoVC.delegateSubject subscribeNext:^(id  _Nullable x) {
        NSLog(@"监听到按钮点击 接收到数据:%@",x);
    }];
     */
    /*
     RAC 代替代理方式e二:rac_signalForSelector 有传值时使用
    [[twoVC rac_signalForSelector:@selector(clickBtnMethod:)] subscribeNext:^(id  _Nullable x) {
        NSLog(@"监听到按钮点击!");
    }];
     */
    twoVC.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:twoVC animated:YES];
}

- (void)sequence {
    NSArray *array = @[@"qxw",@"wangkehui",@"lovke"];
    RACSequence *sequece = array.rac_sequence;
    RACSignal *sequeceSignal = sequece.signal;
    [sequeceSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
}


@end
