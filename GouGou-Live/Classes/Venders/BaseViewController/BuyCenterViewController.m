//
//  BuyCenterViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BuyCenterViewController.h"
#import "PromptView.h"
#import "DogSizeFilter.h"
#import "DeletePrommtView.h"
#import "PayMoneyPrompt.h"
#import "ProtecePowerPromptView.h"
#import "ApplyProtectPowerViewController.h"
#import "CancleOrderAlter.h"
@interface BuyCenterViewController ()

@end

@implementation BuyCenterViewController
// 删除订单
- (void)clickDeleteOrder {
    
    // 点击删除订单出现的弹框
    DeletePrommtView * prompt = [[DeletePrommtView alloc] init];
    prompt.message = @"删除订单后将不能找回";
    
    prompt.sureDeleteBtnBlock = ^(UIButton * btn) {
        
        // 点击确定按钮，删除订单
        
    };
    
    [prompt show];
    
}
// 尾金支付
- (void)clickPayBackMoney {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    
    payMonery.dataArr = @[@"支付尾金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };
    
}
// 定金支付
- (void)clickPayFontMoney {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    
    payMonery.dataArr = @[@"支付定金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *payAway){
        DLog(@"%@", payAway);
    };
    
}
// 全款支付
- (void)clickPayAllMoney {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    
    payMonery.dataArr = @[@"支付全款",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };
    
    
}
// 点击取消订单
- (void)clickCancleOrder {
    // 点击取消订单出现的弹框
    DeletePrommtView * promptView = [[DeletePrommtView alloc] init];
    __weak typeof(promptView) weakself = promptView;
    
    promptView.message = @"取消订单后,有可能被别人买走";
    
    promptView.sureDeleteBtnBlock = ^(UIButton *btn) {
        
        [weakself dismiss];
        // 点击确定按钮出现的弹框（原因选择）
       CancleOrderAlter  *cancleOrder = [[CancleOrderAlter alloc] init];
        cancleOrder.dataArr =  @[@"请选择原因", @"喜欢其他狗狗",@"不喜欢这只了",@"条件不允许养了",@"运费太贵", @"取消"];
        [cancleOrder show];
#pragma mark - 有问题
        cancleOrder.bottomBlock = ^(NSString *reson){
           // 此处删除订单，并返回
            
            DLog(@"%@", reson);
        };
        
    };
    [promptView show];
    
}
// 点击不想买了
- (void)clickNotBuy {
    // 点击不想买了按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"放弃定金后，定金将全部打给卖家";
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureDeleteBtnBlock = ^(UIButton * btn) {
        
        [weakself dismiss];
        
        PromptView * prompt = [[PromptView alloc] init];
        prompt.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
//        __weak typeof(prompt) weakself = prompt;
        
        prompt.clickSureBtnBlock = ^() {
            
            // 判断支付密码输入是否正确，如果正确（fade）
            
            //
            return @"0";
        };
        
        [prompt show];
        
    };
    
    [allpyPrompt show];
    
}
// 点击申请维权调用
- (void)clickApplyProtectPower {
    
    // 点击申请维权按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"我们会再次调查您的实际情况，并根据《用户使用协议》维护您的权益";
    
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureDeleteBtnBlock = ^(UIButton *btn) {
        
        // 点击弹框内确认按钮出现的弹框
        ProtecePowerPromptView * pppView = [[ProtecePowerPromptView alloc] init];
        pppView.message = @"请保持电话通畅，\n如有疑问请拨打热线电话010-0928928";
        [weakself dismiss];
        
        pppView.sureApplyBtnBlock = ^(UIButton * btn) {
            
            // 跳转至申请维权
            ApplyProtectPowerViewController * allpyProVC = [[ApplyProtectPowerViewController alloc] init];
            [self.navigationController pushViewController:allpyProVC animated:YES];
            
        };
        // 弹框显示
        [pppView show];
        
    };
    // 弹框显示
    [allpyPrompt show];
    
}
// 点击提醒发货
- (void)clickConsignment {
    
    NSDate * firstDate = [NSDate date];
    NSDate * secondDate = [NSDate dateWithTimeInterval:2  sinceDate:firstDate];
    //    NSDate * secondDate = [NSDate dateWithTimeInterval:60 * 60 * 24  sinceDate:firstDate];
    
    NSDate * thirdDate = [NSDate dateWithTimeInterval:4  sinceDate:firstDate];
    //    NSDate * thirdDate = [NSDate dateWithTimeInterval:60 * 60 * 24 *3 sinceDate:secondDate];
    ProtecePowerPromptView * consignmentPrompt = [[ProtecePowerPromptView alloc] init];
    
    if (secondDate) {
        
        consignmentPrompt.message = @"付款不超过24小时,不能提醒";
        
        [consignmentPrompt show];
    } else if (thirdDate) {
        
        consignmentPrompt.message = @"已提醒卖家发货，请耐心等待";
        
        [consignmentPrompt show];
    } else {
        
        consignmentPrompt.message = @"三小时内不能重复提醒";
        
        [consignmentPrompt show];
    }
}


@end
