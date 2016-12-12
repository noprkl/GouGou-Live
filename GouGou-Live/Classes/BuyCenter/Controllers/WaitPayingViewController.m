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
                            @"user_id":@(17),
                            @"status":@(2),
                            @"page":@(1),
                            @"pageSize":@(10),
                            @"is_right":@(2)
                            };
    
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        DLog(@"%@",successJson[@"data"][@"info"]);
        
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
   
    BuyCenterModel *model = self.dataArray[indexPath.row];
    
    if ([model.status integerValue] == 5) {
        // 代付全款cell
        WaitAllMoneyCell *cell = [tableView dequeueReusableCellWithIdentifier:waitAllMoneyCell];
        cell.centerModel = model;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"支付全款",@"联系卖家"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全款
                [self clickPayAllMoney:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
                //                // 待付全款控制器
                //                PayingAllMoneyViewController * payAllVC = [[PayingAllMoneyViewController alloc] init];
                //
                //                [self.navigationController pushViewController:payAllVC animated:YES];
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    
    if ([model.status integerValue] == 2) {
        
        WaitFontMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitFontCell];
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
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    } else if ([model.status integerValue] == 3) {
        
        WaitBackMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitBackCell];
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
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
  
    }

    
    return nil;
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
/*
#pragma mark - 不想买了网络请求
- (void)getNobuyRequest {
    
    NSDictionary *dict = @{
                           @"id":@(12),
                           @"user_id":@([[UserInfos sharedUser].ID intValue])
                           };
    
    [self getRequestWithPath:API_Order_Nobuy params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        
    } error:^(NSError *error) {
        
        DLog(@"%@",error);
    }];
    
}
// 点击不想买了
- (void)clickNotBuy:(BuyCenterModel *)model {
    // 点击不想买了按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"放弃定金后，定金将全部打给卖家";
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureBlock = ^(UIButton * btn) {
        // 不想买了
        [self getNobuyRequest];
        
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
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
        };
        
        [prompt show];
        
    };
    
    [allpyPrompt show];
    
}
*/
@end
