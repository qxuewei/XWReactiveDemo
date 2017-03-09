//
//  Book.h
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray<NSString *> *author;
+ (instancetype)bookWithDict:(NSDictionary *)dict;
@end
