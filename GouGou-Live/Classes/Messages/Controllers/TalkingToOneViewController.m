//
//  TalkingToOneViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//  

#import "TalkingToOneViewController.h"

@interface TalkingToOneViewController ()

@end

@implementation TalkingToOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
    self.title = @"联系买家";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
