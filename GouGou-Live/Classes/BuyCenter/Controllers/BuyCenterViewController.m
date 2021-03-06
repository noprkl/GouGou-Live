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
#import "NSString+MD5Code.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface BuyCenterViewController ()

@end

@implementation BuyCenterViewController
#pragma mark - 删除订单网络请求
// 删除订单
- (void)clickDeleteOrder:(NSString *)orderID endOptioal:(EndOptionalBlock)endOptional {
    
    // 点击删除订单出现的弹框
    DeletePrommtView * prompt = [[DeletePrommtView alloc] init];
    prompt.message = @"删除订单后将不能找回";
    
    prompt.sureBlock = ^(UIButton * btn) {
        // 点击确定按钮，删除订单
        NSDictionary * dict = @{
                                @"id":orderID,
                                @"user_id":[UserInfos sharedUser].ID
                                };
        
        [self getRequestWithPath:API_Order_Delete params:dict success:^(id successJson) {
            
            DLog(@"%@",successJson[@"code"]);
            DLog(@"%@",successJson[@"message"]);
            [self showAlert:successJson[@"message"]];
            // 回调
            endOptional();
        } error:^(NSError *error) {
            DLog(@"%@",error);
        }];
    };
    [prompt show];
}

#pragma mark - 支付
/** 根据支付状态请求支付金额 */
- (void)payMoneyWithOrderID:(NSString *)orderID payStyle:(NSString *)payStyle endOptioal:(EndOptionalBlock)endOptional  {
    
    if ([payStyle isEqualToString:@"支付全款"]) {
        // 生成待支付全款订单
        NSDictionary *typeDict = @{
                                   @"user_id":[UserInfos sharedUser].ID ,
                                   @"order_id":orderID,
                                   @"type":@(1)
                                   };
        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"支付全额"]) {
                if ([successJson[@"data"][@"product_price"] isEqualToString:@"0"]) {
                    [self showAlert:@"支付金额不能为0"];
                }else{
                    NSString *price = successJson[@"data"][@"product_price"];
                    NSString *orderid = successJson[@"data"][@"order_id"];
                    [self chosePayStyleWIthOrderID:orderid protductPrice:price wallentpay:orderID status:5 endOptioal:^{
                        // 回调
                        endOptional();
                    }];
                }
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
    if ([payStyle isEqualToString:@"支付订金"]) {
        // 生成待支付订金订单
        NSDictionary *typeDict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"order_id":orderID,
                                   @"type":@(2)
                                   };
        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"支付订金"]) {
                if ([successJson[@"data"][@"product_deposit"] isEqualToString:@"0"]) {
                    [self showAlert:@"支付金额不能为0"];
                }else{
                    NSString *price = successJson[@"data"][@"product_deposit"];
                    NSString *orderid = successJson[@"data"][@"order_id"];
                    [self chosePayStyleWIthOrderID:orderid protductPrice:price wallentpay:orderID status:2 endOptioal:^{
                        // 回调
                        endOptional();
                    }];
                }
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
    if ([payStyle isEqualToString:@"支付尾款"]) {
        // 生成待支付尾款订单
        NSDictionary *typeDict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"order_id":orderID,
                                   @"type":@(3)
                                   };
        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"支付尾款"]) {
                if ([successJson[@"data"][@"product_balance"] isEqualToString:@"0"]) {
                    [self showAlert:@"支付金额不能为0"];
                }else{
                    NSString *price = successJson[@"data"][@"product_balance"];
                    NSString *orderid = [NSString stringWithFormat:@"%@", successJson[@"data"][@"order_id"]];
                    [self chosePayStyleWIthOrderID:orderid protductPrice:price wallentpay:orderID status:3 endOptioal:^{
                        // 回调
                        endOptional();
                    }];
                }
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
/** 根据选择支付方式进行支付 */
- (void)chosePayStyleWIthOrderID:(NSString *)orderID protductPrice:(NSString *)price wallentpay:(NSString *)wallentid status:(int)status endOptioal:(EndOptionalBlock)endOptional {
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    payMonery.payMoney = [NSString stringWithFormat:@"%0.2lf",[price floatValue]];
    payMonery.dataArr = @[@"支付定金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    payMonery.payCellBlock = ^(NSString *payWay){
        [self payMoneyFroWay:payWay orderID:orderID money:price wallentpay:wallentid status:status endOptioal:^{
            // 回调
            endOptional();
        }];
    };
}
- (void)payMoneyFroWay:(NSString *)payWay orderID:(NSString *)orderID money:(NSString *)money wallentpay:(NSString *)wallentid status:(int)status endOptioal:(EndOptionalBlock)endOptional {
    if ([payWay isEqualToString:@"账户余额支付"]) {
        // 支付密码提示框
        PromptView * prompt = [[PromptView alloc] init];
        prompt.backgroundColor = [UIColor whiteColor];
        
        // 点击提示框确认按钮请求支付密码
        __weak typeof(prompt) weakPrompt = prompt;
        prompt.clickSureBtnBlock = ^(NSString *text){
            // 验证密码
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"pay_password":[NSString md5WithString:text]
                                   };
            
            [self postRequestWithPath:API_Validation_pwd params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                weakPrompt.noteStr = successJson[@"message"];
                if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                    [self walletPayWithOrderId:wallentid price:money payPwd:[NSString md5WithString:text] states:status endOptioal:^{
                        // 回调
                        endOptional();
                    }];
                    [weakPrompt dismiss];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        [prompt show];
    }
    if ([payWay isEqualToString:@"支付宝支付"]) {
        [self aliPayWithOrderId:orderID totalFee:money endOptioal:^{
            // 回调
            endOptional();
        }];
    }
    if ([payWay isEqualToString:@"微信支付"]) {
        
        [self WeChatPayWithOrderID:orderID totalFee:money endOptioal:^{
            // 回调
            endOptional();
        }];
    }
}
/** 钱包支付 2定金 3全款 */
- (void)walletPayWithOrderId:(NSString *)orderID price:(NSString *)price payPwd:(NSString *)payPwd states:(int)state endOptioal:(EndOptionalBlock)endOptional {

    NSDictionary *dict = @{
                           @"user_id":[UserInfos sharedUser].ID,
                           @"order_id":orderID,
                           @"user_price":price,
                           @"user_pwd":payPwd,
                           @"status":@(state)
                           };
    DLog(@"%@", dict);
    [self postRequestWithPath:API_Wallet params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        // 回调
        endOptional();
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
/** 微信支付 */
- (void)WeChatPayWithOrderID:(NSString *)orderID totalFee:(NSString *)fee endOptioal:(EndOptionalBlock)endOptional {
    NSString *money = [NSString stringWithFormat:@"%.0lf", [fee floatValue] * 100];
    
    NSDictionary *dict = @{
                           @"order":orderID,
                           @"total_fee":money,
                           @"mark":@"gougou"
                           };
    DLog(@"%@", dict);
    
    [self getRequestWithPath:@"weixinpay/wxapi.php" params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        PayReq * req = [[PayReq alloc] init];
        req.partnerId = successJson[@"partnerid"];
        req.prepayId = [successJson objectForKey:@"prepayid"] != [NSNull null] ?successJson[@"prepayid"]:@"";
        req.nonceStr = [successJson objectForKey:@"noncestr"] != [NSNull null] ?successJson[@"noncestr"]:@"";
        NSNumber *timeStamp = [successJson objectForKey:@"timestamp"] != [NSNull null] ?successJson[@"timestamp"]:@"";
        req.timeStamp = [timeStamp intValue];
        req.package = [successJson objectForKey:@"package"] != [NSNull null] ?successJson[@"package"]:@"";
        req.sign = [successJson objectForKey:@"sign"] != [NSNull null] ?successJson[@"sign"]:@"";
        req.openID = [successJson objectForKey:@"appid"] != [NSNull null] ?successJson[@"appid"]:@"";
        
        DLog(@"sign:%@, openID:%@, partnerId:%@, prepayId:%@, nonceStr:%@, timeStamp:%u, package:%@", req.sign, req.openID, req.partnerId, req.prepayId, req.nonceStr, req.timeStamp, req.package);
        if (req.partnerId.length != 0){
            BOOL flag = [WXApi sendReq:req];
            if (flag) {
                DLog(@"支付成功");
                // 回调
                endOptional();
            }else{
                DLog(@"支付失败");
            }
        }else{
            [self showAlert:@"partnerId没有值"];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
/** 支付宝支付 */
- (void)aliPayWithOrderId:(NSString *)orderID totalFee:(NSString *)fee endOptioal:(EndOptionalBlock)endOptional {

    NSString *money = [NSString stringWithFormat:@"%.0lf", [fee floatValue] * 100];
    NSDictionary *dit = @{
                          @"id":orderID,
                          @"total_fee":money
                          };
    DLog(@"%@", dit);
    [self getRequestWithPath:@"appalipay/signatures_url.php" params:dit success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"msg"]];
        [self aliPayWithOrderString:successJson[@"data"] endOptioal:^{
            // 回调
            endOptional();
        }];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)aliPayWithOrderString:(NSString *)orderStr endOptioal:(EndOptionalBlock)endOptional {
    if (orderStr != nil) {
        
        NSString *appScheme = @"ap2016112203105439";
        
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            DLog(@"reslut = %@",resultDic);
            // 回调
            endOptional();
        }];
    }
}

#pragma mark - 取消订单网络请求
- (void)getCancleOrderRequest:(NSString *)orderID endOptioal:(EndOptionalBlock)endOptional {

    NSDictionary * dict = @{@"user_id":[UserInfos sharedUser].ID,
                            @"order_id":orderID,
                            @"note":@"test"
                            };
    
    [self getRequestWithPath:API_Cancel_order params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        // 回调
        endOptional();
    } error:^(NSError *error) {
       
        DLog(@"%@",error);

    }];
}
// 点击取消订单
- (void)clickCancleOrder:(NSString *)orderID endOptioal:(EndOptionalBlock)endOptional {
    
    
    // 点击取消订单出现的弹框
    DeletePrommtView * promptView = [[DeletePrommtView alloc] init];
    __weak typeof(promptView) weakself = promptView;
    
    promptView.message = @"取消订单后,有可能被别人买走";
    
    promptView.sureBlock = ^(UIButton *btn) {
        
        [weakself dismiss];
        // 点击确定按钮出现的弹框（原因选择）
       CancleOrderAlter  *cancleOrder = [[CancleOrderAlter alloc] init];
      
        __weak typeof(cancleOrder) cancleSelf = cancleOrder;
        
        [self getRequestWithPath:API_Cancel_order_reason params:nil success:^(id successJson) {
            DLog(@"%@",successJson[@"data"]);
            cancleOrder.dataArr = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            
            [cancleOrder  show];

        } error:^(NSError *error) {
            
            DLog(@"%@",error);
        }];
        
        // 点击cell
        cancleOrder.reasonCellBlock = ^(NSString *text) {
             DLog(@"%@", text);
            [self getCancleOrderRequest:orderID endOptioal:^{
                // 回调
                endOptional();
            }];
            [cancleSelf dismiss];
            // 弹框退出，要删除对应cell
        };
    };
    [promptView show];
    
}
#pragma mark - 不想买了网络请求
- (void)getNobuyRequest:(NSString *)orderID endOptioal:(EndOptionalBlock)endOptional {

    NSDictionary *dict = @{
                           @"id":orderID
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Order_Nobuy params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson);
        // 回调
        endOptional();
    } error:^(NSError *error) {
        
        DLog(@"%@",error);
    }];

}
// 点击不想买了
- (void)clickNotBuy:(NSString *)orderID endOptioal:(EndOptionalBlock)endOptional {
    // 点击不想买了按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"放弃定金后，定金将全部打给卖家";
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureBlock = ^(UIButton * btn) {
        
        [weakself dismiss];
        
        PromptView * prompt = [[PromptView alloc] init];
        prompt.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
//        __weak typeof(prompt) weakself = prompt;
        
        // 点击提示框确认按钮请求支付密码
        __weak typeof(prompt) weakPrompt = prompt;
        prompt.clickSureBtnBlock = ^(NSString *text){
            
            // 验证密码
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"pay_password":[NSString md5WithString:text]
                                   };
            [self postRequestWithPath:API_Validation_pwd params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                weakPrompt.noteStr = successJson[@"message"];
                if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                    // 申请成功
                    [weakPrompt dismiss];
                    // 回调
                    // 不想买了
                    [self getNobuyRequest:orderID endOptioal:^{
                        // 回调
                        endOptional();
                    }];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
        };
        
        [prompt show];
        
    };
    
    [allpyPrompt show];
    
}
// 点击申请维权调用
- (void)clickApplyProtectPower:(NSString *)orderID {
    
    // 点击申请维权按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"我们会再次调查您的实际情况，并根据《用户使用协议》维护您的权益";
    
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureBlock = ^(UIButton *btn) {
        
        // 点击弹框内确认按钮出现的弹框
        ProtecePowerPromptView * pppView = [[ProtecePowerPromptView alloc] init];
        pppView.message =[NSString stringWithFormat:@"请保持电话通畅，\n如有疑问请拨打热线电话%@", ServicePhone];
        [weakself dismiss];
        
        pppView.sureApplyBtnBlock = ^(UIButton * btn) {
            
            // 跳转至申请维权
            ApplyProtectPowerViewController * allpyProVC = [[ApplyProtectPowerViewController alloc] init];
            allpyProVC.orderID = orderID;
            [self.navigationController pushViewController:allpyProVC animated:YES];
            
        };
        // 弹框显示
        [pppView show];
        
    };
    // 弹框显示
    [allpyPrompt show];
    
}
// 点击提醒发货
- (void)clickConsignment:(NSString *)orderID { 
    NSDictionary *dict = @{
                           @"id":orderID,
                           @"user_id":[UserInfos sharedUser].ID
                           };
    [self getRequestWithPath:API_Order_remind params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
@end
