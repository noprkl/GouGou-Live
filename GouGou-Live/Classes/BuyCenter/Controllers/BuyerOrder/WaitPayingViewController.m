//
//  WaitPayingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//   代付款

#import "WaitPayingViewController.h"  // 待支付控制器
#import "WaitBackMoneyCell.h"  // 待付尾款cell
#import "WaitFontMoneyCell.h"  // 待付定金cell
#import "WaitAllMoneyCell.h"   // 待付全款cell
#import "FunctionButtonView.h"  // cell下边按钮
#import "PayingAllMoneyViewController.h"  // 支付全款控制器
#import "NicknameView.h" // 商家昵称View

// 订单详情
#import "PayBackMoneyViewController.h" // 代付尾款
#import "PayFontMoneyViewController.h" // 代付定金
#import "PayingAllMoneyViewController.h" // 代付全款

#import "PromptView.h"   // 提示框
#import "DeletePrommtView.h"
#import "NSString+MD5Code.h" // 加密
#import "ChosePayStyleView.h"
#import "PayMoneyPrompt.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import "BuyCenterModel.h"

static NSString * waitBackCell = @"waitBackCellID";
static NSString * waitFontCell = @"waitFontCellID";
static NSString * waitAllMoneyCell = @"waitAllMoneyCellID";

@interface WaitPayingViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation WaitPayingViewController
#pragma mark - 网络请求
- (void)getPayStateOrderRequest {
//    @([[UserInfos sharedUser].ID integerValue]
    NSDictionary * dict = @{
                            @"user_id":@([[UserInfos sharedUser].ID intValue]),
                            @"status":@(1),
                            @"page":@(1),
                            @"pageSize":@(10)
                            };
    
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        DLog(@"%@",successJson);
        self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        DLog(@"%@",self.dataArray);
        [self.tableview reloadData];
    } error:^(NSError *error) {
        
        DLog(@"%@",error);
        
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getPayStateOrderRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getPayStateOrderRequest];
        [self.tableview.mj_header endRefreshing];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    
    [self.view addSubview:self.tableview];
    
}
#pragma mark
#pragma mark - 初始化
- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (UITableView *)tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 88 - 64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        // 注册cell
        [_tableview registerClass:[WaitBackMoneyCell class] forCellReuseIdentifier:waitBackCell];
        [_tableview registerClass:[WaitFontMoneyCell class] forCellReuseIdentifier:waitFontCell];
        [_tableview registerClass:[WaitAllMoneyCell class] forCellReuseIdentifier:waitAllMoneyCell];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 255;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *rootCell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (rootCell == nil) {
        rootCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellid"];
    }
    
    BuyCenterModel *model = self.dataArray[indexPath.row];
    if ([model.status integerValue] == 1) {
        
        WaitFontMoneyCell * cell = [[WaitFontMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitFontCell];
        cell.centerModel = model;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"待付款",@"取消订单",@"联系卖家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text  isEqual:@"待付款"]){
                __block  ChosePayStyleView *choseStyle = [[ChosePayStyleView alloc] init];
                choseStyle.dataArr = @[@"支付全款", @"支付定金"];
                choseStyle.bottomBlock = ^(NSString *style){
                    
                    if ([style isEqualToString:@"支付全款"]) {
                        // 生成待支付全款订单
                        NSDictionary *typeDict = @{
                                                   @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                                   @"order_id":@([model.ID intValue]),
                                                   @"type":@(1)
                                                   };
                        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                            if ([successJson[@"message"] isEqualToString:@"支付全额"]) {
                                [self clickPayAllMoney:model.ID price:successJson[@"data"]];
                                choseStyle = nil;
                                [choseStyle dismiss];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }else if ([style isEqualToString:@"支付定金"]) {
                        // 生成待支付定金订单
                        NSDictionary *typeDict = @{
                                                   @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                                   @"order_id":@([model.ID intValue]),
                                                   @"type":@(2)
                                                   };
                        [self postRequestWithPath:API_Order_second params:typeDict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                            if ([successJson[@"message"] isEqualToString:@"支付订金"]) {
                                [self clickPayFontMoney:model.ID productDeposit:successJson[@"data"]];
                                choseStyle = nil;
                                [choseStyle dismiss];
                            }
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                };
                [choseStyle show];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat3;
                viewController.chatID = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
        };
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    if ([model.status integerValue] == 5) {
        // 代付全款cell
        WaitAllMoneyCell *cell = [[WaitAllMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitAllMoneyCell];
        cell.centerModel = model;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付全款",@"联系卖家"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全款
                [self clickPayAllMoney:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat3;
                 viewController.chatID = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        return cell;
    }
    
    if ([model.status integerValue] == 2 ) {
        
        WaitFontMoneyCell * cell = [[WaitFontMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitFontCell];
        cell.centerModel = model;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付定金",@"取消订单",@"联系卖家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text  isEqual:@"支付定金"]){
                // 点击支付定金
                [self clickPayFontMoney:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat3;
                 viewController.chatID = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
        };
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    if ([model.status integerValue] == 3) {
        
        WaitBackMoneyCell * cell = [[WaitBackMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitBackCell];
        cell.centerModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付尾款",@"不想买了",@"联系卖家",@"申请维权"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {

            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全款
                [self clickPayAllMoney:model];
            }
            if ([button.titleLabel.text  isEqual:@"申请维权"]) {
                // 点击申请维权
                [self clickApplyProtectPower:model.ID];

                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            }
            
            if ([button.titleLabel.text  isEqual:@"支付尾款"]){
                // 点击支付尾款
                [self clickPayBackMoney:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"不想买了"]) {
                // 点击不想买了
                [self clickNotBuy:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat3;
                 viewController.chatID = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
  
    }

    return rootCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
   
    if ([model.status integerValue] == 5) {
        // 待付全款
        PayingAllMoneyViewController * allVC = [[PayingAllMoneyViewController alloc] init];
        [self.navigationController pushViewController:allVC animated:YES];
    } else if ([model.status integerValue] == 3) {
        // 代付尾款
        PayBackMoneyViewController * backVC = [[PayBackMoneyViewController alloc] init];
        
        [self.navigationController pushViewController:backVC animated:YES];
        
    } else if ([model.status integerValue] == 2) {
        // 代付定金
        PayFontMoneyViewController * fontVC = [[PayFontMoneyViewController alloc] init];
        [self.navigationController pushViewController:fontVC animated:YES];
        
    }

}
/** 定金支付 */
- (void)clickPayFontMoney:(NSString *)modelID productDeposit:(NSString *)productDeposit {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    payMonery.payMoney = productDeposit;
    payMonery.dataArr = @[@"支付定金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *payAway){
        DLog(@"%@", payAway);
    };
    payMonery.payCellBlock = ^(NSString *payWay){
        [self payMoneyFroWay:payWay orderID:modelID money:productDeposit];
    };
}
/** 全款支付 */
- (void)clickPayAllMoney:(NSString *)modelID price:(NSString *)price {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    payMonery.payMoney = price;
    payMonery.dataArr = @[@"支付全款",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };
    payMonery.payCellBlock = ^(NSString *payWay){
        [self payMoneyFroWay:payWay orderID:modelID money:price];
    };
}
- (void)payMoneyFroWay:(NSString *)payWay orderID:(NSString *)orderID money:(NSString *)money{
    if ([payWay isEqualToString:@"账户余额支付"]) {
        
        //        [self postGetWalletPayRequest];
        
        // 支付密码提示框
        PromptView * prompt = [[PromptView alloc] init];
        prompt.backgroundColor = [UIColor whiteColor];
        
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
                    [self walletPayWithOrderId:[orderID intValue] price:[money intValue] * 100 payPwd:[NSString md5WithString:text] states:3];
                    [weakPrompt dismiss];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        [prompt show];
    }
    if ([payWay isEqualToString:@"支付宝支付"]) {
        [self aliPayWithOrderId:[orderID intValue] totalFee:[money intValue] * 100];
    }
    if ([payWay isEqualToString:@"微信支付"]) {
        
        [self WeChatPayWithOrderID:[orderID intValue] totalFee:[money intValue] * 100];
    }
}
/** 钱包支付 2定金 3全款 */
- (void)walletPayWithOrderId:(int)orderID price:(int)price payPwd:(NSString *)payPwd states:(int)state {
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID intValue]),
                           @"order_id":@(orderID),
                           @"user_price":@(price),
                           @"user_pwd":payPwd,
                           @"status":@(state)
                           };
    [self postRequestWithPath:API_Wallet params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
/** 微信支付 */
- (void)WeChatPayWithOrderID:(int)orderID totalFee:(int)fee {
    // /gougou.itnuc.com/weixinpay/wxapi.php?order=wx12345678&total_fee=1&mark=testpya
    
    NSDictionary *dict = @{
                           @"order":@(orderID),
                           @"total_fee":@(0.01),
                           @"mark":@"爪行宠物直播"
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:@"weixinpay/wxapi.php" params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        PayReq * req = [[PayReq alloc] init];
        req.partnerId = [successJson objectForKey:@"partnerid"];
        req.prepayId = [successJson objectForKey:@"prepayid"];
        req.nonceStr = [successJson objectForKey:@"noncestr"];
        NSNumber *timeStamp = [successJson objectForKey:@"timestamp"];
        req.timeStamp = [timeStamp intValue];
        
        req.package = [successJson objectForKey:@"package"];
        req.sign = [successJson objectForKey:@"sign"];
        req.openID = [successJson objectForKey:@"appid"];
        
        DLog(@"sign:%@, openID:%@, partnerId:%@, prepayId:%@, nonceStr:%@, timeStamp:%u, package:%@", req.sign, req.openID, req.partnerId, req.prepayId, req.nonceStr, req.timeStamp, req.package);
        
        BOOL flag = [WXApi sendReq:req];
        if (flag) {
            
            [self showAlert:successJson[@"支付成功"]];
        }else{
            [self showAlert:successJson[@"支付失败"]];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
/** 支付宝支付 */
- (void)aliPayWithOrderId:(int)orderID totalFee:(int)fee {
    //htp://gougou.itnuc.com/appalipay/signatures_url.php?id=111111111111&total_fee=1
    NSDictionary *dit = @{
                          @"id":@(orderID),
                          @"total_fee":@(arc4random_uniform(2)+1)
                          };
    DLog(@"%@", dit);
    [self getRequestWithPath:@"appalipay/signatures_url.php" params:dit success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"msg"]];
        [self aliPayWithOrderString:successJson[@"data"]];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)aliPayWithOrderString:(NSString *)orderStr {
    if (orderStr != nil) {
        
        NSString *appScheme = @"ap2016112203105439";
        
        [[AlipaySDK defaultService] payOrder:orderStr fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            DLog(@"reslut = %@",resultDic);
        }];
    }
}

@end
