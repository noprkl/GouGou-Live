//
//  MerchantViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MerchantViewController.h"
#import "AddressChooseView.h" // 城市选择
#import "PromptMerchantViewController.h"
#import "MerchantCertitycateViewController.h"


static NSString * MedrchantCell = @"MedrchantCell";

@interface MerchantViewController ()
/** 未认证 */
@property (strong,nonatomic) PromptMerchantViewController *promptCertityVC;
/** 已经实名认证 */
@property (strong,nonatomic) MerchantCertitycateViewController *   medrchantVC;

@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];

//    PromptMerchantViewController * proMedrVC = [[PromptMerchantViewController alloc] init];
//    [self.navigationController pushViewController:proMedrVC animated:YES];
    
    MerchantCertitycateViewController * medrVC =[[MerchantCertitycateViewController alloc] init];
    
    [self.navigationController pushViewController:medrVC animated:YES];
}


//- (PromptMerchantViewController *)promptCertityVC {
//
//    if (!_promptCertityVC) {
//        _promptCertityVC = [[PromptMerchantViewController alloc] init];
//        _promptCertityVC.view = self.view;
//    }
//    return _promptCertityVC;
//}
//
//- (MerchantCertitycateViewController *)medrchantVC {
//    
//    if (!_medrchantVC) {
//        _medrchantVC = [[MerchantCertitycateViewController alloc] init];
//        _medrchantVC.view = self.view;
//    }
//    return _medrchantVC;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
