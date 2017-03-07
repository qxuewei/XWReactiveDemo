//
//  TwoVC.h
//  RACDemo
//
//  Created by 邱学伟 on 2017/3/7.
//  Copyright © 2017年 邱学伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalHeader.h"

@interface TwoVC : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
@property (nonatomic, strong) RACSubject *delegateSubject;
@end
