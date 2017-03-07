//
//  Calcualator.h
//  Calcualator
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calcualator : NSObject
@property (nonatomic, assign, readonly) double result;

- (Calcualator *(^)(double))add;

- (Calcualator *(^)(double))subtract;

- (instancetype)calculator:(double(^)(double))block;


@end
