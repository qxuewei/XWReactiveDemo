//
//  RequestViewModel.m
//  MVVMDemo
//
//  Created by crazyfire on 2017/3/8.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import "RequestViewModel.h"
#import "Book.h"

@implementation RequestViewModel

- (instancetype)init {
    
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _loadSwiftBookCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        NSLog(@"执行命令接收输入 : %@",input);
        RACSignal *responseSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [[XWAFNManager sharedManager] GET:@"https://api.douban.com/v2/book/search" parameters:@{@"q":@"swift"} netIdentifier:nil success:^(NSDictionary *responseObject) {
                [responseObject writeToFile:@"/Users/carayfire-develop/Documents/TEMP/swift.plist" atomically:YES];
                NSArray *books = [responseObject objectForKey:@"books"];
                NSMutableArray *bookModels = [NSMutableArray array];
                bookModels = [[[books.rac_sequence map:^id _Nullable(id  _Nullable value) {
                     return [Book bookWithDict:value];
                }] array] mutableCopy];
                
                [subscriber sendNext:bookModels];
            } failure:^(NSError *error) {
                NSLog(@"error:%@",error);
            }];
            return nil;
        }];
        return responseSignal;
    }];
}

@end
