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

#import "TwoVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toTwoVCBtn;
@property (weak, nonatomic) IBOutlet UITextField *testTF;
@property (weak, nonatomic) IBOutlet UIButton *sent123NotiBtn;

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
    
    [self addTargetMethod];
    [self replaceNotification];
    [self monitorTextField];
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
    [[self.toTwoVCBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
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





@end
