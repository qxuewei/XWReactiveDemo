//
//  NSObject+Calculator.m
//  Calcualator
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "NSObject+Calculator.h"
#import "Calcualator.h"
@implementation NSObject (Calculator)
+ (double)xw_calculator:(void(^)(Calcualator *))block{
    Calcualator *calculator = [[Calcualator alloc] init];
    block(calculator);
    return calculator.result;
}
@end
