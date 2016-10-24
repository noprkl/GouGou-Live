//
//  CodeLoginViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CodeLoginViewController.h"

@interface CodeLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *regisePhoneNumber;

@end

@implementation CodeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];
    
}


#pragma mark
#pragma mark - Action
- (IBAction)clickGetCodeBtnAction:(UIButton *)sender {
}
- (IBAction)chickAffirmBtnAction:(UIButton *)sender {
    
}

- (void)setNav {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStyleDone target:nil action:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:nil action:nil];
}

//- (void)pushToLoginContreller {
//
//
//}

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
