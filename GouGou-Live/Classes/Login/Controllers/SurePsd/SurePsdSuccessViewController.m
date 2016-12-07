//
//  SurePsdSuccessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SurePsdSuccessViewController.h"
#import "LoginViewController.h"

@interface SurePsdSuccessViewController ()

@property (weak, nonatomic) IBOutlet UIButton *countdownBtn;

@end

@implementation SurePsdSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"设置密码";
    
    [self freetimeout];
}

- (IBAction)clickSureBtnAction:(UIButton *)sender {
    
    [self pushLoginVC];
}

- (void)pushLoginVC {
    LoginViewController * loginVC = [[LoginViewController alloc] init];
    
    [self.navigationController pushViewController:loginVC animated:YES];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)freetimeout {
    __block NSInteger time = 3;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time < 1) {
            //取消计时
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self pushLoginVC];
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.countdownBtn.tintColor = [UIColor colorWithHexString:@"#b2b2b2"];
                NSString *string = [NSString stringWithFormat:@"%ldS",time];
                
                [self.countdownBtn setTitle:string forState:(UIControlStateNormal)];
            });
            time --;
        }
        
    });
    dispatch_resume(timer);
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
