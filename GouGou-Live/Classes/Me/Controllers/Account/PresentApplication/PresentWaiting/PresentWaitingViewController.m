//
//  PresentWaitingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PresentWaitingViewController.h"
#import "PromptView.h"

@interface PresentWaitingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *promptLabel;

@end

@implementation PresentWaitingViewController


- (IBAction)clickHelpButton:(UIButton *)sender {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)initUI {

    self.title = @"提现申请";
    
    
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
