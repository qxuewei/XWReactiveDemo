//
//  ViewController.m
//  Calcualator
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "Calcualator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Calcualator *cal = [[Calcualator alloc] init];
    cal.add(10).add(10);
    NSLog(@"结果:%.2f",cal.result);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
