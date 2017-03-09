
//
//  Book.m
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "Book.h"

@implementation Book
+ (instancetype)bookWithDict:(NSDictionary *)dict{
    Book *b = [[Book alloc] init];
    b.title = dict[@"title"];
    b.author = dict[@"author"];
    return b;
}
@end
