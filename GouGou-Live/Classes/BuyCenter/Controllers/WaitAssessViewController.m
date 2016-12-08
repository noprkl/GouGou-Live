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

// 订单详情
#import "OrderCompleteAssess.h" // 完成评价
#import "OrderCompleteViewController.h" // 订单完成（未评价）
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
#pragma mark - 网络请求
- (void)getAssessRequest {
    
    NSDictionary * dict = @{
                            @"user_id":@(17),
                            @"status":@(2),
                            @"page":@(1),
                            @"pageSize":@(10),
                            @"is_right":@(2)
                            };
    
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        
        self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        DLog(@"%@",successJson[@"data"]);
        DLog(@"%@",successJson[@"data"][@"info"]);
        [self.tableview reloadData];
    } error:^(NSError *error) {
        DLog(@"%@",error);
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
    
//    UITableViewCell * cellSys = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
//    
//    if (!cellSys) {
//        
//        cellSys = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellid"];
//    }
    
    BuyCenterModel * model = self.dataArray[indexPath.row];

    WaitAssessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitsAssessCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if ([model.status integerValue] == 9) {
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
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat1;
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
                [self.navigationController pushViewController:goToAssessVC animated:YES];
                DLog(@"%@",button.titleLabel.text);
            }
        };
        [cell addSubview:funcBtn];
//        return cell;
    } else if ([model.status integerValue] == 10) {
//        WaitAssessCell * cell = [tableView equeueReusableCellWithIdentifier:waitsAssessCell];

        cell.centerModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"查看评价",@"申请维权",@"联系卖家",@"删除订单"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"删除订单"]) {
                // 跳转删除订单
                [self clickDeleteOrder:model];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                
                // 跳转至联系卖家
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat2;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
                // 跳转至申请维权
                [self clickApplyProtectPower:model.ID ];
                DLog(@"%@--%@",self,button.titleLabel.text);
            } else if ([button.titleLabel.text isEqual:@"查看评价"]) {
                // 跳转至查看评价
                DLog(@"%@",button.titleLabel.text);
            }
        };
        [cell addSubview:funcBtn];
//        return cell;

    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
    if ([model.status integerValue] == 9) {
        OrderCompleteViewController * OrderVC = [[OrderCompleteViewController alloc] init];
        [self.navigationController pushViewController:OrderVC animated:YES];
        
    } else if ([model.status integerValue] == 10) {
        
        OrderCompleteAssess * orderAssessVc = [[OrderCompleteAssess alloc] init];
        
        [self.navigationController pushViewController:orderAssessVc animated:YES];
     
    }
    
}


@end
