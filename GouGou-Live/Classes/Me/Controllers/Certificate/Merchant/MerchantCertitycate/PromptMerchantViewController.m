//
//  PromptMerchantViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PromptMerchantViewController.h"
#import "CertificateViewController.h"
#import "CertificatePromptView.h"

@interface PromptMerchantViewController ()
/** 提示实名认证 */
@property (strong,nonatomic) CertificatePromptView *promptCerView;
/** 接收倒计时 */
@property (strong,nonatomic) UIButton *countdownBtn;

@end

@implementation PromptMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    //    [self freetimeout];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBarItem];
}

- (void)initUI {
    
    [self.view addSubview:self.promptCerView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self freetimeout];
}

- (CertificatePromptView *)promptCerView {
    
    if (!_promptCerView) {
        
        _promptCerView = [[CertificatePromptView alloc] initWithFrame:self.view.frame];
        
        __weak typeof(self) weakself = self;
        
        _promptCerView.certificateBlack = ^() {
            
            [weakself pushToCertificateViewController];
        };
        
        _promptCerView.countdownBlock = ^(UIButton *btn) {
            
            weakself.countdownBtn = btn;
            
        };
    }
    return _promptCerView;
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
                
                self.countdownBtn.userInteractionEnabled = NO;
                
                [self pushToCertificateViewController];
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.countdownBtn.tintColor = [UIColor colorWithHexString:@"#b2b2b2"];
                
                NSString *string = [NSString stringWithFormat:@"%ldS自动跳转",time];
                
                [self.countdownBtn setTitle:string forState:(UIControlStateNormal)];
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
