//
//  MerchantViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MerchantViewController.h"
#import "CertificateViewController.h"

@interface MerchantViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nameCertificateBtn;
@property (weak, nonatomic) IBOutlet UIButton *countDownBtn;

@end

@implementation MerchantViewController
- (IBAction)clickNameCertificateBtn:(UIButton *)sender {

    [self pushToCertificateViewController];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self freetimeout];
    
    [self setNavBarItem];
}

- (void)initUI {

    self.nameCertificateBtn.layer.cornerRadius = 5;
    self.nameCertificateBtn.layer.masksToBounds = YES;
}

- (void)pushToCertificateViewController {

    CertificateViewController * cerVC = [[CertificateViewController alloc] init];

    [self.navigationController pushViewController:cerVC animated:YES];
}

- (void)freetimeout {
    __block NSInteger time = 2;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        
        if (time < 1) {
            //取消计时
            dispatch_source_cancel(timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self pushToCertificateViewController];
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.countDownBtn.tintColor = [UIColor colorWithHexString:@"#b2b2b2"];
                NSString *string = [NSString stringWithFormat:@"%ldS",time];
                
                [self.countDownBtn setTitle:string forState:(UIControlStateNormal)];
            });
            time --;
        }
        
    });
    dispatch_resume(timer);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
