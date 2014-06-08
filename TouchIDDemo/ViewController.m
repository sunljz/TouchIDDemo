//
//  ViewController.m
//  TouchIDDemo
//
//  Created by sun on 14-6-8.
//  Copyright (c) 2014年 sun. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configAuthButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - config

- (void)configAuthButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"test touch ID" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(60, 100, 200, 30)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(authBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - event

- (void)authBtnTouch:(UIButton *)sender {
    // 初始化验证上下文
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    // 验证的原因, 应该会显示在会话窗中
    NSString *reason = @"测试: 验证touchID";
    
    // 判断是否能够进行验证
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL succes, NSError *error)
         {
             NSString *text = nil;
             if (succes) {
                 text = @"验证成功";
             } else {
                 text = error.domain;
             }
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
             [alert show];
         }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:[error domain] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }
}

@end
