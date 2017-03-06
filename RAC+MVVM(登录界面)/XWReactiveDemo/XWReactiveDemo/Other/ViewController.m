//
//  ViewController.m
//  XWReactiveDemo
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSignal *loginEnableSiganl = [RACSignal combineLatest:@[self.accountTF.rac_textSignal, self.pwdTF.rac_textSignal] reduce:^id (NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    RAC(self.loginBtn,enabled) = loginEnableSiganl;
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击登录按钮!");
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
