//
//  PaySuccessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/18.
//  Copyright © 2016年 LXq. All rights reserved.
//  支付成功（已完成）（订单操作）

#import "PaySuccessViewController.h"
#import "PaySuccessView.h"
@interface PaySuccessViewController ()
/** 支付成功 */
@property (strong,nonatomic) PaySuccessView *paysuccessView;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    self.title = @"支付结果";
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
    
    [self addControllers];

}

- (void)addControllers {

    [_paysuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.bottom.equalTo(self.view);
        
    }];
}

- (PaySuccessView *)paysuccessView {

    if (_paysuccessView) {
        _paysuccessView = [[PaySuccessView alloc] init];
    }
    return _paysuccessView;
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
