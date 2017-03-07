//
//  TwoVC.m
//  RACDemo
//
//  Created by 邱学伟 on 2017/3/7.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "TwoVC.h"

@interface TwoVC ()
@property (weak, nonatomic) IBOutlet UIView *grayView;

@end

@implementation TwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self replaceKVO];
    
    [self replaceNotification];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    
    // 代替通知
    
}

- (void)replaceNotification {
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"接收到键盘弹出通知: %@",x);
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"123Noti" object:nil];
}

- (void)replaceKVO {
    // 代替KVO
    /*
     代替KVO 方式一:
     [[self.grayView rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id  _Nullable x) {
     NSLog(@"%@",x);
     }];
     代替KVO 方式二:
     [self.grayView rac_observeKeyPath:@"frame" options:NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey observer:nil block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
     NSLog(@"grayView 的 frame 改变了! :%@",change);
     }];
     
     
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     self.grayView.frame = CGRectMake(20, 44, 100, 100);
     });
     */
}
- (IBAction)clickBtnMethod:(UIButton *)sender {
    /*
     代替代理方法一: RACSubject
//    if (self.delegateSubject) {
//        [self.delegateSubject sendNext:@123];
//    }
     */
    //RAC 代替代理方式二:rac_signalForSelector 有传值时使用
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - getter
- (RACSubject *)delegateSubject{
    if (_delegateSubject == nil) {
        _delegateSubject = [[RACSubject alloc] init];
    }
    return _delegateSubject;
}


@end
