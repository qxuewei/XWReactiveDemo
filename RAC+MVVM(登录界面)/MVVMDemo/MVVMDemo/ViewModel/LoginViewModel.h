//
//  LoginViewModel.h
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobelHeader.h"

@interface LoginViewModel : NSObject

@property (nonatomic, strong, readwrite) NSString *account;
@property (nonatomic, strong, readwrite) NSString *pwd;

@property (nonatomic, strong, readonly) RACSignal *loginEnableSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

@end
