//
//  WatiConsigneeViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
// 待收货

#import "WatiConsigneeViewController.h"

#import "FunctionButtonView.h" // cell下边的按钮
#import "WaitConsignessCell.h" // 代收货cell
#import "SureConsigneedViewController.h"

static NSString * waitConsignessCell = @"waitConsignessCell";
@interface WatiConsigneeViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation WatiConsigneeViewController
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getConsigneeRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getConsigneeRequest];
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
- (void)getConsigneeRequest {
    
    NSDictionary * dict = @{@"user_id":@(17),
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
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview registerClass:[WaitConsignessCell class] forCellReuseIdentifier:waitConsignessCell];
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
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
     WaitConsignessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitConsignessCell];
    if ([model.status integerValue] == 8) {
       
        cell.centerModel = model;
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 45)title:@[@"申请维权",@"联系卖家",@"确认收货"] buttonNum:3];
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"确认收货"]) {
            
            DLog(@"%@--%@",self,button.titleLabel.text);
            
        } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
            // 跳转至联系卖家
            SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
            viewController.title = EaseTest_Chat3;
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewController animated:YES];
            
            DLog(@"%@--%@",self,button.titleLabel.text);
            
        } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
            // 跳转至申请维权
            [self clickApplyProtectPower];
            
            DLog(@"%@--%@",self,button.titleLabel.text);
        }
    };
    [cell addSubview:funcBtn];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SureConsigneedViewController * congisnee = [[SureConsigneedViewController alloc] init];
    
    [self.navigationController pushViewController:congisnee animated:YES];
}

@end