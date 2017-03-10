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
#import "ProtecePowerPromptView.h"

#import "WaitSellConsigmentViewContorller.h" // 代发货订单详情
static NSString * waitConsignmentCell = @"waitConsignmentCell";

@interface WaitConsignmentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    int page;
}
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@end

@implementation WaitConsignmentViewController
#pragma mark - 网络请求
- (void)getConsignmentRequest {
    
    NSDictionary * dict = @{@"user_id":[UserInfos sharedUser].ID,
                            @"status":@(2),
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
    [self getConsignmentRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self getConsignmentRequest];
        [self.tableview.mj_header endRefreshing];
    }];
    self.tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self getConsignmentRequest];
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
            [self clickConsignment:model.ID];
            DLog(@"%@",button.titleLabel.text);
            
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyCenterModel *model = self.dataArray[indexPath.row];
    WaitSellConsigmentViewContorller * waitSelllVC = [[WaitSellConsigmentViewContorller alloc] init];
    waitSelllVC.orderID = model.ID;
    [self.navigationController pushViewController:waitSelllVC animated:YES];
}

@end
