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
#import "PayingAllMoneyViewController.h" //待付全款

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

    NSDictionary * dict = @{
                            @"user_id":[UserInfos sharedUser].ID,
                            @"status":@(1),
                            @"page":@(1),
                            @"pageSize":@(10)
                            };
    [self showHudInView:self.view hint:@"加载中.."];
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        DLog(@"%@",successJson);
        self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
        DLog(@"%@",self.dataArray);
        [self.tableview reloadData];
        [self hideHud];
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
    __weak typeof(self) weakSelf = self;

    BuyCenterModel *model = self.dataArray[indexPath.row];
    if ([model.status integerValue] == 1) {
        
        WaitFontMoneyCell * cell = [[WaitFontMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitFontCell];
        cell.centerModel = model;
        
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model.ID endOptioal:^{
                [weakSelf getPayStateOrderRequest];
            }];
        };
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"待付款",@"取消订单",@"联系卖家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder:model.ID endOptioal:^{
                    [weakSelf getPayStateOrderRequest];
                }];
                [self getPayStateOrderRequest];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text  isEqual:@"待付款"]){
                __block  ChosePayStyleView *choseStyle = [[ChosePayStyleView alloc] init];
                choseStyle.title = @"请选择付款额度方式";
                choseStyle.dataArr = @[@"支付全款", @"支付订金"];
                choseStyle.bottomBlock = ^(NSString *style){
                    if ([style isEqualToString:@"支付全款"]) {
                        [self payMoneyWithOrderID:model.ID payStyle:style endOptioal:^{
                            [weakSelf getPayStateOrderRequest];
                        }];
                    }else if ([style isEqualToString:@"支付订金"]) {
                        [self payMoneyWithOrderID:model.ID payStyle:style endOptioal:^{
                            [weakSelf getPayStateOrderRequest];
                        }];
                    }
                };
                [choseStyle show];
                
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
        
        WaitFontMoneyCell * cell = [[WaitFontMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitFontCell];
        cell.centerModel = model;
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model.ID endOptioal:^{
                [self getPayStateOrderRequest];
            }];
        };
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付订金",@"取消订单",@"联系卖家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder:model.ID endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
            } else if ([button.titleLabel.text  isEqual:@"支付订金"]){
                // 点击支付定金
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
                
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
        
        WaitBackMoneyCell * cell = [[WaitBackMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitBackCell];
        cell.centerModel = model;
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model.ID endOptioal:^{
                [self getPayStateOrderRequest];

            }];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付尾款",@"不想买了",@"联系卖家",@"申请维权"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {

            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全款
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
            }
            if ([button.titleLabel.text  isEqual:@"申请维权"]) {
                // 点击申请维权
                [self clickApplyProtectPower:model.ID];
            }
            
            if ([button.titleLabel.text  isEqual:@"支付尾款"]){
                // 点击支付尾款
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
                
            } else if ([button.titleLabel.text isEqual:@"不想买了"]) {
                // 点击不想买了
                [self clickNotBuy:model.ID endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
                
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
        WaitAllMoneyCell *cell = [[WaitAllMoneyCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:waitAllMoneyCell];
        cell.centerModel = model;
        cell.cancelBlock = ^(){
            [self getCancleOrderRequest:model.ID endOptioal:^{
                [self getPayStateOrderRequest];
            }];
        };
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付全款",@"联系卖家", @"取消订单"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全款
                [self payMoneyWithOrderID:model.ID payStyle:button.titleLabel.text endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:model.saleUserId conversationType:(EMConversationTypeChat)];
                viewController.title = model.saleUserId;
                viewController.chatID = model.saleUserId;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }else if ([button.titleLabel.text isEqualToString:@"取消订单"]) {
                [self clickCancleOrder:model.ID endOptioal:^{
                    [self getPayStateOrderRequest];
                }];
            }
        };
        
        [cell.contentView addSubview:funcBtn];
        return cell;
    }
    return rootCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
    if ([model.status isEqualToString:@"1"]) {
        
        //        state = @"待付款";
        [self showAlert:@"请完成支付"];
        
    } else if ([model.status integerValue] == 5) {
        // 待付全款
        PayingAllMoneyViewController * allVC = [[PayingAllMoneyViewController alloc] init];
        allVC.orderID = model.ID;
        [self.navigationController pushViewController:allVC animated:YES];
    } else if ([model.status integerValue] == 3) {
        // 代付尾款
        PayBackMoneyViewController * backVC = [[PayBackMoneyViewController alloc] init];
        backVC.orderID = model.ID;
        [self.navigationController pushViewController:backVC animated:YES];
        
    } else if ([model.status integerValue] == 2) {
        // 代付定金
        PayFontMoneyViewController * fontVC = [[PayFontMoneyViewController alloc] init];
        fontVC.orderID = model.ID;
        [self.navigationController pushViewController:fontVC animated:YES];
        
    }}

@end
