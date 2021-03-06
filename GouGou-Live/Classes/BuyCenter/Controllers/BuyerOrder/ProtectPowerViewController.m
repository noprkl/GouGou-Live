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
{
    int page;
}
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation ProtectPowerViewController
#pragma mark - 网络请求
- (void)getProtectPowerRequest {

    NSDictionary * dict = @{@"user_id":[UserInfos sharedUser].ID,
                            @"page":@(page),
                            @"pageSize":@(10)
                            };
    [self showHudInView:self.view hint:@"加载中.."];
    [self getRequestWithPath:API_Activist params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        self.dataArray = [ProtectProwerTableModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
//        [self.tableview reloadData];
//        [self hideHud];
        if (page == 1) {
            [self.tableview.mj_footer resetNoMoreData];
            self.dataArray = [ProtectProwerTableModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            [self hideHud];
            [self.tableview reloadData];
        }else{
            NSArray *array = [ProtectProwerTableModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
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
    [self getProtectPowerRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getProtectPowerRequest];
        [self.tableview.mj_header endRefreshing];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getProtectPowerRequest];
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
                [self clickServiceBtnAction];
            }
        };
        
        [cell addSubview:funcBtn];
        cell.copyBlock = ^(){
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            
            NSString *string = model.ID;
            
            [pab setString:string];
            
            if (pab != nil) {
                [self showAlert:@"已复制"];
            }

        };
        return cell;
    }
    
    if ([model.status integerValue] == 2) {
        
        ProtectSuccessCell * cell = [tableView dequeueReusableCellWithIdentifier:protectSuccessCell];
        cell.protectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"在线客服"] buttonNum:1];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"在线客服"]) {
              [self clickServiceBtnAction];
            }
        };
        
        [cell addSubview:funcBtn];
        cell.copyBlock = ^(){
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            
            NSString *string = model.ID;
            
            [pab setString:string];
            
            if (pab != nil) {
                [self showAlert:@"已复制"];
            }
        };

        return cell;
    }
    
    if ([model.status integerValue] == 3) {
        
        ProtectFaliedCell * cell = [tableView dequeueReusableCellWithIdentifier:protectFailedCell];
        cell.protectModel = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45) title:@[@"再次申请",@"在线客服"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"在线客服"]) {
                
              [self clickServiceBtnAction];
                DLog(@"%@",button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"再次申请"]) {
                // 跳转至再次申请
                
                DLog(@"%@",button.titleLabel.text);
                
                [self clickApplyProtectPower:model.ID];
            }
        };
        [cell addSubview:funcBtn];
        cell.copyBlock = ^(){
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            
            NSString *string = model.ID;
            
            [pab setString:string];
            
            if (pab != nil) {
                [self showAlert:@"已复制"];
            }
        };

        return cell;
    }
    return cell1;
}

/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ProtectProwerTableModel * model = self.dataArray[indexPath.row];
    SellerOrderDetailProtectPowerViewController *protcetVc = [[SellerOrderDetailProtectPowerViewController alloc] init];
    protcetVc.orderID = model.ID;
    [self.navigationController pushViewController:protcetVc animated:YES];
}
*/
@end
