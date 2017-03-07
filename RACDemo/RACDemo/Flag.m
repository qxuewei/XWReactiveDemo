//
//  Flag.m
//  RACDemo
//
//  Created by 邱学伟 on 2017/3/7.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "Flag.h"

@implementation Flag
+ (instancetype)flagWithDict:(NSDictionary *)dict {
    Flag *flag = [[self alloc] init];
    [flag setValuesForKeysWithDictionary:dict];
    return flag;
}
@end
