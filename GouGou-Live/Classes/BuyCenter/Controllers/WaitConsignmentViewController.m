//
//  WaitConsignmentViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
// 待发货

#import "WaitConsignmentViewController.h"
#import "FunctionButtonView.h"  // cell下边的按钮
#import "WaitConsignmentCell.h" // 待发货cell
#import "WaitConsignessCell.h"
#import "ProtecePowerPromptView.h"

#import "WaitSellConsigmentViewContorller.h" // 代发货订单详情
static NSString * waitConsignmentCell = @"waitConsignmentCell";

@interface WaitConsignmentViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation WaitConsignmentViewController
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getConsignmentRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getConsignmentRequest];
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
- (void)getConsignmentRequest {

    NSDictionary * dict = @{@"user_id":@(17),
                            @"status":@(2),
                            @"page":@(1),
                            @"pageSize":@(10),
                            @"is_right":@(2)
                            };
    
    [self getRequestWithPath:API_List_order params:dict success:^(id successJson) {
        
        self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
    
        DLog(@"%@",successJson[@"message"]);
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
        [_tableview registerClass:[WaitConsignmentCell class] forCellReuseIdentifier:waitConsignmentCell];
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
    
    BuyCenterModel * model = self.dataArray[indexPath.row];
        
        WaitConsignmentCell * cell = [tableView dequeueReusableCellWithIdentifier:waitConsignmentCell];
        if ([model.status integerValue] == 7) {
            
            cell.centerModel = model;
        
        }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"申请维权",@"联系卖家",@"提醒发货"] buttonNum:3];
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"提醒发货"]) {
            
            // 跳转至提醒发货
            [self clickConsignment:model];
            DLog(@"%@",button.titleLabel.text);
            
        } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
            // 跳转至联系卖家
            SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
            viewController.title = EaseTest_Chat2;
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WaitSellConsigmentViewContorller * waitSelllVC = [[WaitSellConsigmentViewContorller alloc] init];
    
    [self.navigationController pushViewController:waitSelllVC animated:YES];
}

@end
