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

    [self setNavBarItem];
    self.title = @"提现申请";

}
- (void)setNoteStr:(NSString *)noteStr {
    _noteStr = noteStr;
    self.promptLabel.text = _noteStr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
