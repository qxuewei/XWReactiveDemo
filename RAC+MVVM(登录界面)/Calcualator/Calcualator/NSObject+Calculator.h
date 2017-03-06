//
//  NSObject+Calculator.h
//  Calcualator
//
//  Created by 邱学伟 on 2017/3/6.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Calcualator;
@interface NSObject (Calculator)

+ (double)xw_calculator:(void(^)(Calcualator *))block;

@end
