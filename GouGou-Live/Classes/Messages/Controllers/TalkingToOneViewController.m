//
//  TalkingToOneViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  

#import "TalkingToOneViewController.h"
#import <HyphenateLite_CN/EMSDK.h>

@interface TalkingToOneViewController ()<EMClientDelegate>

@end

@implementation TalkingToOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
//    self.title = @"联系买家";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    [self EaseMobLogin];
    
}
- (void)EaseMobLogin {
    // 环信登录 验证自动登录
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:@"8001" password:@"111111"];
        if (!error) {
            NSLog(@"登录成功");
        }
    }
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
}
- (void)EaseMobRegiste {
    // 环信注册
    EMError *error = [[EMClient sharedClient] registerWithUsername:@"8001" password:@"111111"];
    if (error==nil) {
        NSLog(@"注册成功");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
