//
//  RequestViewModel.h
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobelHeader.h"
@interface RequestViewModel : NSObject

@property (nonatomic, strong, readonly) RACCommand *loadSwiftBookCommand;

@end
