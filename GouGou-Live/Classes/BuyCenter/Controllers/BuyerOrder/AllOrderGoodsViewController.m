//
//  AllOrderGoodsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AllOrderGoodsViewController.h"

#import "WaitBackMoneyCell.h"   // 订单详情cell
#import "WaitConsignessCell.h" // 代收货cell
#import "ProtectingPowerCell.h" // 维权中cell
#import "ProtectSuccessCell.h"  // 维权成功cell
#import "ProtectFaliedCell.h"   // 维权失败cell
#import "WaitAssessCell.h"  // 待评价cell
#import "WaitConsignmentCell.h" // 待发货cell
#import "WaitBackMoneyCell.h"  // 待付尾款cell
#import "WaitFontMoneyCell.h"  // 待付定金cell
#import "WaitAllMoneyCell.h"   // 待付全款cell
#import "BuyerCloseOrderCell.h" // 关闭交易
#import "FunctionButtonView.h" // 订单底部按钮
#import "BuyCenterModel.h"
#import "GotoAssessViewController.h"

#import "SingleChatViewController.h" // 联系卖家
#import "BuyCenterModel.h"
#import "ChosePayStyleView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "PayMoneyPrompt.h"
#import "PromptView.h"
#import "NSString+MD5Code.h"

#import "OrderCompleteAssess.h" // 已评价
#import "OrderWaitAssessViewController.h" // 待评价
#import "PayBackMoneyViewController.h"// 代付尾款
#import "PayFontMoneyViewController.h"// 代付定金
#import "PayingAllMoneyViewController.h"// 待付全款
#import "SureConsigneedViewController.h" // 待收货
#import "WaitSellConsigmentViewContorller.h" // 待发货

static NSString * waitConsignessCell = @"waitConsignessCell";
static NSString * waitBackCell = @"waitBackCellID";
static NSString * waitFontCell = @"waitFontCellID";
static NSString * waitAllMoneyCell = @"waitAllMoneyCellID";
static NSString * waitConsignmentCell = @"waitConsignmentCell";
static NSString * waitsAssessCell = @"waitsAssessCell";
static NSString * protectingCell = @"protectingCell";
static NSString * protectSuccessCell = @"protectSuccessCell";
static NSString * protectFailedCell = @"protectFailedCell";
static NSString * closeCell = @"closeCell";

@interface AllOrderGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation AllOrderGoodsViewController

//#pragma mark - 网络请求
- (void)postGetAllStateOrderRequest {
    
    NSDictionary * dict = @{
                            @"user_id":@([[UserInfos sharedUser].ID intValue]),
                            @"status":@(0),
                            @"page":@(1),
                            @"pageSize":@(10)
                            };
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        DLog(@"%@", successJson);        
        if (successJson[@"data"][@"info"]) {
            self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            [self.tableview reloadData];
        }
    } error:^(NSError *error) {
        
        DLog(@"%@",error);
        
    }];
}

#pragma mark -  生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self postGetAllStateOrderRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    
    [self.view addSubview:self.tableview];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postGetAllStateOrderRequest];
        [self.tableview.mj_header endRefreshing];
    }];
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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -88- 64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
      
        [_tableview registerClass:[WaitBackMoneyCell class] forCellReuseIdentifier:waitBackCell];
        [_tableview registerClass:[WaitAllMoneyCell class] forCellReuseIdentifier:waitAllMoneyCell];
        [_tableview registerClass:[WaitConsignessCell class] forCellReuseIdentifier:waitConsignessCell];
        [_tableview registerClass:[WaitFontMoneyCell class] forCellReuseIdentifier:waitFontCell];
        [_tableview registerClass:[WaitConsignmentCell class] forCellReuseIdentifier:waitConsignmentCell];
        [_tableview registerClass:[WaitAssessCell class] forCellReuseIdentifier:waitsAssessCell];
        [_tableview registerClass:[BuyerCloseOrderCell class] forCellReuseIdentifier:closeCell];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyCenterModel * model = self.dataArray[indexPath.row];
    
    if ([model.status integerValue] == 2 || [model.status integerValue] == 1) {
        
        return 255;
        
    } else if ([model.status integerValue] == 3) {
        
        return 255;
        
    } else if ([model.status integerValue] == 5) {
        
        return 255;
        
    } else if ([model.status integerValue] == 7) {
        
        return 255;
        
    }else if ([model.status integerValue] == 8) {
        
        return 345;
        
    }else if ([model.status integerValue] == 9) {
        
        return 345;
        
    }else if ([model.status integerValue] == 10) {
        
        return 345;
        
    }
    return 255;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *rootCell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (rootCell == nil) {
        rootCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellid"];
    }
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
    DLog(@"%ld", [model.status integerValue]);
    if ([model.status integerValue] == 1) {
        // 待付款
        WaitFontMoneyCell * cell = [[WaitFontMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitFontCell];
        cell.centerModel = model;
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model];
        };
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"待付款",@"取消订单",@"联系卖家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder:model];
                [self postGetAllStateOrderRequest];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text  isEqual:@"待付款"]){
                __block  ChosePayStyleView *choseStyle = [[ChosePayStyleView alloc] init];
                choseStyle.title = @"请选择付款额度方式";
                choseStyle.dataArr = @[@"支付全款", @"支付订金"];
                choseStyle.bottomBlock = ^(NSString *style){
                    
                    if ([style isEqualToString:@"支付全款"]) {
                        [self payMoneyWithOrderID:model.ID payStyle:style];
                    }else if ([style isEqualToString:@"支付订金"]) {
                        // 生成待支付定金订单
                        [self payMoneyWithOrderID:model.ID payStyle:style];
                    }
                };
                [choseStyle show];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
        };
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    if ([model.status integerValue] == 2) {
        // 定金
        WaitFontMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitFontCell];
        cell.centerModel = model;
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model];
        };
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付订金",@"取消订单",@"联系卖家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder:model];
                DLog(@"%@--%@",self,button.titleLabel.text);
                [self postGetAllStateOrderRequest];
            } else if ([button.titleLabel.text  isEqual:@"支付订金"]){
                // 点击支付定金
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    if ([model.status integerValue] == 3) {
        // 尾款
        WaitBackMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitBackCell];
        cell.centerModel = model;
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付尾款",@"不想买了",@"联系卖家",@"申请维权"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            
            if ([button.titleLabel.text  isEqual:@"申请维权"]) {
                // 点击申请维权
                [self clickApplyProtectPower:model.ID];
            }
            
            if ([button.titleLabel.text  isEqual:@"支付尾款"]){
                // 点击支付尾款
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text];
                
            } else if ([button.titleLabel.text isEqual:@"不想买了"]) {
                // 点击不想买了
                [self clickNotBuy:model];
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    if ([model.status integerValue] == 5) {
        // 待付全款cell
        WaitAllMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:waitAllMoneyCell];
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model];
        };
        cell.centerModel = model;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付全款",@"联系卖家"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全款
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text];
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            }
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    if ([model.status integerValue] == 7) {
        // 发货
        WaitConsignmentCell * cell = [tableView dequeueReusableCellWithIdentifier:waitConsignmentCell];
        
        cell.centerModel = model;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"申请维权",@"联系卖家",@"提醒发货"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"提醒发货"]) {
                // 提醒发货
                [self clickConsignment:model];
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
                // 跳转至申请维权
                [self clickApplyProtectPower:model.ID];
                
            }
        };
        
        [cell addSubview:funcBtn];
        return cell;
        
    }
    if ([model.status integerValue] == 8) {
        // 待收货
        WaitConsignessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitConsignessCell];
        cell.centerModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45)title:@[@"申请维权",@"联系卖家",@"确认收货"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"确认收货"]) {
                
                NSDictionary *dict = @{
                                       @"user_id":@([[UserInfos sharedUser].ID  intValue]),
                                       @"status":@(9),
                                       @"id":model.ID
                                       };
                [self getRequestWithPath:API_Up_status params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    [self showAlert:successJson[@"message"]];
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
                
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
                // 跳转至申请维权
                [self clickApplyProtectPower:model.ID];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
        };
        [cell addSubview:funcBtn];
        return cell;
    }
    if ([model.status integerValue] == 9) {
        // 未评价
        WaitAssessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitsAssessCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.centerModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"未评价",@"申请维权",@"联系卖家",@"删除订单"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"删除订单"]) {
                // 跳转删除订单
                [self clickDeleteOrder:model endOptioal:^{
                    [self postGetAllStateOrderRequest];
                }];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
                // 跳转至申请维权
                [self clickApplyProtectPower:model.ID];
                DLog(@"%@--%@",self,button.titleLabel.text);
            } else if ([button.titleLabel.text isEqual:@"未评价"]) {
                // 跳转至我要评价
                GotoAssessViewController * goToAssessVC = [[GotoAssessViewController alloc] init];
                goToAssessVC.orderID = model.ID;
                [self.navigationController pushViewController:goToAssessVC animated:YES];
                DLog(@"%@",button.titleLabel.text);
            }
        };
        [cell addSubview:funcBtn];
        return cell;
    }
    if ([model.status integerValue] == 10) {
        // 已评价
        WaitAssessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitsAssessCell];
        
        cell.centerModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"查看评价",@"申请维权",@"联系卖家",@"删除订单"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"删除订单"]) {
                // 跳转删除订单
                [self clickDeleteOrder:model endOptioal:^{
                    [self postGetAllStateOrderRequest];
                }];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
                // 跳转至申请维权
                [self clickApplyProtectPower:model.ID];
                DLog(@"%@--%@",self,button.titleLabel.text);
            } else if ([button.titleLabel.text isEqual:@"查看评价"]) {
                // 跳转至查看评价
                DLog(@"%@",button.titleLabel.text);
                OrderCompleteAssess *Vc = [[OrderCompleteAssess alloc] init];
                Vc.detailModel = model;
                Vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:Vc animated:YES];
            }
        };
        [cell addSubview:funcBtn];
        
        return cell;
        
    }
        if ([model.status integerValue] == 20){ //   20：订单取消
            
            BuyerCloseOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
            cell.model = model;
            cell.orderState = @"交易关闭";
            cell.deleBlock = ^(){
                [self clickDeleteOrder:model endOptioal:^{
                    [self postGetAllStateOrderRequest];
                }];
            };
            return cell;
        }
    if ([model.status integerValue] == 21){ // 21：交易关闭
            
            BuyerCloseOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:closeCell];
            cell.model = model;
            cell.orderState = @"交易关闭";
        cell.deleBlock = ^(){
            [self clickDeleteOrder:model endOptioal:^{
                [self postGetAllStateOrderRequest];
            }];
        };
            return cell;
        }
    return rootCell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyCenterModel *model = self.dataArray[indexPath.row];
    if ([model.status isEqualToString:@"1"]) {
        
//        state = @"待付款";
        [self showAlert:@"请完成支付"];
        
    }else if ([model.status isEqualToString:@"2"]) {
        
//        state = @"待付定金";
        PayFontMoneyViewController *Vc = [[PayFontMoneyViewController alloc] init];
        Vc.detailModel = model;
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }else if ([model.status isEqualToString:@"3"]) {
        
//        state = @"待付尾款";
        PayBackMoneyViewController *Vc = [[PayBackMoneyViewController alloc] init];
        Vc.hidesBottomBarWhenPushed = YES;
        Vc.detailModel = model;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }else if ([model.status isEqualToString:@"4"]) {
        
//        state = @"";
        
    }else if ([model.status isEqualToString:@"5"]) {
        
//        state = @"待付全款";
        PayingAllMoneyViewController *Vc = [[PayingAllMoneyViewController alloc] init];
        Vc.detailModel = model;
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];

    }else if ([model.status isEqualToString:@"6"]) {
        
//        state = @"";
        
    }else if ([model.status isEqualToString:@"7"]) {
        
//        state = @"待发货";
        WaitSellConsigmentViewContorller *Vc = [[WaitSellConsigmentViewContorller alloc] init];
        Vc.detailModel = model;
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
        
    }else if ([model.status isEqualToString:@"8"]) {
        
//        state = @"待收货";
        SureConsigneedViewController *Vc = [[SureConsigneedViewController alloc] init];
        Vc.detailModel = model;
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
    }else if ([model.status isEqualToString:@"9"]) {
        
//        state = @"未评价";
        
        OrderWaitAssessViewController *Vc = [[OrderWaitAssessViewController alloc] init];
        Vc.detailModel = model;
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];

    }else if ([model.status isEqualToString:@"10"]) {
        
//        state = @"已评价";
        OrderCompleteAssess *Vc = [[OrderCompleteAssess alloc] init];
        Vc.detailModel = model;
        Vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:Vc animated:YES];
    }else if ([model.status isEqualToString:@"20"]) {
        
//        state = @"订单取消";
        [self showAlert:@"订单已关闭"];
    }
}

@end
