//
//  Calcualator.m
//  Calcualator
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "Calcualator.h"

@interface Calcualator ()
@property (nonatomic, assign) double result;
@end

@implementation Calcualator

- (Calcualator *(^)(double))add{
    
    return ^(double x){
        self.result += x;
        return self;
    };
}

- (Calcualator *(^)(double))subtract {
    
    return ^(double x){
        self.result *= x;
        return self;
    };
}

@end
