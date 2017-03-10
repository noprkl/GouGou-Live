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
{
    int page;
}
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSMutableArray *dataArray;
///** 按钮 */
//@property (strong,nonatomic) FunctionButtonView *funcBtn;
///** 数组 */
//@property (strong,nonatomic) NSMutableArray *array;

@end

@implementation WaitAssessViewController
#pragma mark - 网络请求
- (void)getAssessRequest {
    
    NSDictionary * dict = @{
                            @"user_id":[UserInfos sharedUser].ID,
                            @"status":@(4),
                            @"page":@(page),
                            @"pageSize":@(10)
                            };
    [self showHudInView:self.view hint:@"加载中.."];
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        
//        self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
//        
//        [self.tableview reloadData];
//        [self hideHud];
        if (page == 1) {
            [self.tableview.mj_footer resetNoMoreData];
            self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            [self hideHud];
            [self.tableview reloadData];
        }else{
            NSArray *array = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            [self.dataArray addObjectsFromArray:array];
            [self hideHud];
            [self.tableview reloadData];
            if (array.count < 10) {
                [self.tableview.mj_footer endRefreshingWithNoMoreData];
                page -= 1;
            }else{
                [self.tableview.mj_footer endRefreshing];
            }
        }

    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    page = 1;
    [self getAssessRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getAssessRequest];
        [self.tableview.mj_header endRefreshing];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getAssessRequest];
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
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
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
                [self clickDeleteOrder:model.ID];
                                
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
        OrderVC.orderID = model.ID;
        [self.navigationController pushViewController:OrderVC animated:YES];
        
    } else if ([model.status integerValue] == 10) {
        
        OrderCompleteAssess * orderAssessVc = [[OrderCompleteAssess alloc] init];
        orderAssessVc.orderID = model.ID;
        [self.navigationController pushViewController:orderAssessVc animated:YES];
     
    }
    
}
#pragma mark - 删除订单网络请求
- (void)getDeleteOrderRequest:(NSString *)orderID {
    
    NSDictionary * dict = @{
                            @"id":orderID,
                            @"user_id":@([[UserInfos sharedUser].ID intValue])
                            };
    
    [self getRequestWithPath:API_Order_Delete params:dict success:^(id successJson) {
        
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        [self showAlert:successJson[@"message"]];

    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}
// 删除订单
- (void)clickDeleteOrder:(NSString *)orderID {
    
    // 点击删除订单出现的弹框
    DeletePrommtView * prompt = [[DeletePrommtView alloc] init];
    prompt.message = @"删除订单后将不能找回";
    
    prompt.sureBlock = ^(UIButton * btn) {
        
        // 点击确定按钮，删除订单
        [self getDeleteOrderRequest:orderID];
        [self getAssessRequest];
    };
    [prompt show];
    
}

@end
