//
//  ProtectPowerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//  维权

#import "ProtectPowerViewController.h"

#import "FunctionButtonView.h"  // cell下边的按钮

#import "ProtectingPowerCell.h" // 维权中cell
#import "ProtectSuccessCell.h"  // 维权成功cell
#import "ProtectFaliedCell.h"   // 维权失败cell

#import "ProtectProwerTableModel.h"

#import "SellerOrderDetailProtectPowerViewController.h"

static NSString * protectingCell = @"protectingCell";
static NSString * protectSuccessCell = @"protectSuccessCell";
static NSString * protectFailedCell = @"protectFailedCell";

@interface ProtectPowerViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation ProtectPowerViewController
#pragma mark - 网络请求
- (void)getProtectPowerRequest {

    NSDictionary * dict = @{@"user_id":@([[UserInfos sharedUser].ID intValue]),
                            @"page":@(1),
                            @"pageSize":@(10)
                            };
    
    [self getRequestWithPath:API_Activist params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArray = [ProtectProwerTableModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        [self.tableview reloadData];
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self getProtectPowerRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getProtectPowerRequest];
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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 88 -64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        // 注册cell
        [_tableview registerClass:[ProtectingPowerCell class] forCellReuseIdentifier:protectingCell];
        [_tableview registerClass:[ProtectSuccessCell class] forCellReuseIdentifier:protectSuccessCell];
        [_tableview registerClass:[ProtectFaliedCell class] forCellReuseIdentifier:protectFailedCell];
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
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell1 == nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    ProtectProwerTableModel * model = self.dataArray[indexPath.row];
    
    if ([model.status integerValue] == 1) {
        ProtectingPowerCell * cell = [tableView dequeueReusableCellWithIdentifier:protectingCell];
        cell.protectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"在线客服"] buttonNum:1];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"在线客服"]) {
                // 跳转至在线客服
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat1;
                 viewController.chatID = EaseTest_Chat1;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        };
        
        [cell addSubview:funcBtn];
        
        return cell;
    }
    
    if ([model.status integerValue] == 2) {
        
        ProtectSuccessCell * cell = [tableView dequeueReusableCellWithIdentifier:protectSuccessCell];
        cell.protectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"在线客服"] buttonNum:1];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"在线客服"]) {
                
                // 跳转至在线客服
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat1;
                 viewController.chatID = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
            }
        };
        
        [cell addSubview:funcBtn];
        return cell;
    }
    
    if ([model.status integerValue] == 3) {
        
        ProtectFaliedCell * cell = [tableView dequeueReusableCellWithIdentifier:protectFailedCell];
        cell.protectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"再次申请",@"在线客服"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"在线客服"]) {
                
                // 跳转至在线客服
                SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
                viewController.title = EaseTest_Chat1;
                 viewController.chatID = EaseTest_Chat3;
                viewController.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:viewController animated:YES];
                
                DLog(@"%@",button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"再次申请"]) {
                // 跳转至再次申请
                
                DLog(@"%@",button.titleLabel.text);
                
                [self clickApplyProtectPower:model.ID];
            }
        };
        [cell addSubview:funcBtn];
        
        return cell;
    }
    return cell1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProtectProwerTableModel * model = self.dataArray[indexPath.row];
    SellerOrderDetailProtectPowerViewController *protcetVc = [[SellerOrderDetailProtectPowerViewController alloc] init];
    protcetVc.orderID = model.ID;
    [self.navigationController pushViewController:protcetVc animated:YES];
}
@end