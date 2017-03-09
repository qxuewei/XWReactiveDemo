//
//  ViewController.m
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "GlobelHeader.h"
#import "LoginViewModel.h"
#import "RequestViewModel.h"
#import "TwpVC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accoundTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) LoginViewModel *loginVM;
@property (nonatomic, strong) RequestViewModel *requestVM;

@end

@implementation ViewController

-(LoginViewModel *)loginVM{
    if(!_loginVM){
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (RequestViewModel *)requestVM{
    if(!_requestVM){
        _requestVM = [[RequestViewModel alloc] init];
    }
    return _requestVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindSignal];
    [self loginEvent];
    [self testAFN];
}

- (void)testAFN {
    [[self.requestVM.loadSwiftBookCommand execute:@"开始执行!"] subscribeNext:^(id  _Nullable x) {
        NSLog(@"拿到请求结果:%@",x);
    }];
}

- (void)loginEvent {

    RAC(_loginBtn,enabled) = self.loginVM.loginEnableSignal;
    @weakify(self);
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) { 
        @strongify(self);
        [[self.loginVM.loginCommand execute:@"点击登录"] subscribeNext:^(id  _Nullable x) {
            NSLog(@"登录逻辑处理完成 - %@",x);
            if (x) {
                [self.navigationController pushViewController:[[TwpVC alloc]init] animated:YES];
            }
        }];
    }];
}

- (void)bindSignal {
    
    // 为 ViewModel 属性绑定信号, 否则无法监听属性值的更改
    RAC(self.loginVM, account) = _accoundTF.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdTF.rac_textSignal;
}

@end
