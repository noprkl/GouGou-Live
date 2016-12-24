//
//  WaitAssessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//   待评价
#import "WaitAssessViewController.h"

#import "WaitAssessCell.h"  // 待评价cell
#import "FunctionButtonView.h"  // cell底部按钮
#import "GotoAssessViewController.h"

#import "DeletePrommtView.h"   // 点击删除出现提示框

// 订单详情
#import "OrderCompleteAssess.h" // 完成评价

#import "OrderWaitAssessViewController.h" // 待评价

static NSString * waitsAssessCell = @"waitsAssessCell";
@interface WaitAssessViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;
///** 按钮 */
//@property (strong,nonatomic) FunctionButtonView *funcBtn;
///** 数组 */
//@property (strong,nonatomic) NSMutableArray *array;

@end

@implementation WaitAssessViewController
#pragma mark - 网络请求
- (void)getAssessRequest {
    
    NSDictionary * dict = @{
                            @"user_id":@([[UserInfos sharedUser].ID intValue]),
                            @"status":@(4),
                            @"page":@(1),
                            @"pageSize":@(10)
                            };
    
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        
        self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        
        [self.tableview reloadData];
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getAssessRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getAssessRequest];
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
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableview.showsVerticalScrollIndicator = NO;
        [_tableview registerClass:[WaitAssessCell class] forCellReuseIdentifier:waitsAssessCell];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 345;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // 待评价列表只放置未评价cell（原型）
    
    BuyCenterModel * model = self.dataArray[indexPath.row];

    WaitAssessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitsAssessCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

//    if ([model.status integerValue] == 9) {
        cell.centerModel = model;
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"未评价",@"申请维权",@"联系卖家",@"删除订单"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"删除订单"]) {
                // 跳转删除订单
                [self clickDeleteOrder:model];
                
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
//    }
     return cell;
}
// cell选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
    if ([model.status integerValue] == 9) {
        OrderWaitAssessViewController * OrderVC = [[OrderWaitAssessViewController alloc] init];
        OrderVC.detailModel = model;
        [self.navigationController pushViewController:OrderVC animated:YES];
        
    } else if ([model.status integerValue] == 10) {
        
        OrderCompleteAssess * orderAssessVc = [[OrderCompleteAssess alloc] init];
        orderAssessVc.detailModel = model;
        [self.navigationController pushViewController:orderAssessVc animated:YES];
     
    }
    
}
#pragma mark - 删除订单网络请求
- (void)getDeleteOrderRequest:(BuyCenterModel *)model {
    
    NSDictionary * dict = @{
                            @"id":@([model.ID intValue]),
                            @"user_id":@([[UserInfos sharedUser].ID intValue])
                            };
    
    [self getRequestWithPath:API_Order_Delete params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}
// 删除订单
- (void)clickDeleteOrder:(BuyCenterModel *)model {
    
    // 点击删除订单出现的弹框
    DeletePrommtView * prompt = [[DeletePrommtView alloc] init];
    prompt.message = @"删除订单后将不能找回";
    
    prompt.sureBlock = ^(UIButton * btn) {
        
        // 点击确定按钮，删除订单
        [self getDeleteOrderRequest:model];
        [self getAssessRequest];
    };
    [prompt show];
    
}

@end
