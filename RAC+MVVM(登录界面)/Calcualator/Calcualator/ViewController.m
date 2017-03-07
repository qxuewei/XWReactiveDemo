//
//  ViewController.m
//  Calcualator
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "Calcualator.h"
#import "NSObject+Calculator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Calcualator *cal = [[Calcualator alloc] init];
    double result = [[cal calculator:^double(double result) {
        result += 5;
        result *= 5;
        return result;
    }] result];
    
//    double result = [[self class] xw_calculator:^(Calcualator *cal) {
//        cal.add(1).add(2).add(3).subtract(2);
//    }];
    NSLog(@"结果:%.2f",result);
//    Calcualator *cal = [[Calcualator alloc] init];
//    cal.add(10).add(10);
//    NSLog(@"结果:%.2f",cal.result);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
