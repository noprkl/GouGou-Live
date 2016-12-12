//
//  AllOrderGoodsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AllOrderGoodsViewController.h"

#import "WaitBackMoneyCell.h"   // 订单详情cell
#import "FunctionButtonView.h" // 订单底部按钮
#import "PayBackMoneyViewController.h"
#import "PayFontMoneyViewController.h"
#import "BuyCenterModel.h"
#import "GotoAssessViewController.h"

#import "SingleChatViewController.h" // 联系卖家

static NSString * waitBackCells = @"waitBackCells";

@interface AllOrderGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation AllOrderGoodsViewController
/*
//#pragma mark - 网络请求
- (void)postGetAllStateOrderRequest {
    
    NSDictionary * dict = @{//[[UserInfos sharedUser].ID integerValue]
                            @"user_id":@(17),
                            @"status":@(2),
                            @"page":@(1),
                            @"pageSize":@(10),
                            @"is_right":@(2)
                            };
    
    [self postRequestWithPath:API_List_order params:dict success:^(id successJson) {
        
        [self showAlert:successJson[@"message"]];
  
            if (successJson[@"data"][@"info"]) {
                
                DLog(@"%@",successJson[@"data"][@"info"]);
        
                self.dataArray = [BuyCenterModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
                [self.tableview reloadData];
            }
    } error:^(NSError *error) {
        
        DLog(@"%@",error);
        
    }];
}
*/
#pragma mark -  生命周期
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
//    [self postGetAllStateOrderRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {

    [self.view addSubview:self.tableview];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -88- 64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.showsVerticalScrollIndicator = NO;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview registerClass:[WaitBackMoneyCell class] forCellReuseIdentifier:waitBackCells];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 255;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSArray * cellNamesArray = @[@"WaitFontMoneyCell",@"WaitBackMoneyCell",@"WaitAllMoneyCell",@"WaitConsignmentCell",@"WaitConsignessCell",@"WaitAssessCell",@"ProtectSuccessCell",@"ProtectingPowerCell",@"ProtectFaliedCell"];
//
    WaitBackMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitBackCells];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // cell底部按钮
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"查看评价",@"申请维权",@"联系卖家",@"删除订单"] buttonNum:4];
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"删除订单"]) {
            
            [self clickDeleteOrder:self.detailModel];

            
        } else if ([button.titleLabel.text  isEqual:@"查看评价"]){
            // 跳转至支付全款
            //            PayingAllMoneyViewController * payAllVC = [[PayingAllMoneyViewController alloc] init];
            //
            //            [self.navigationController pushViewController:payAllVC animated:YES];
            
            PayBackMoneyViewController * payBack = [[PayBackMoneyViewController alloc] init];
            [self.navigationController pushViewController:payBack animated:YES];
            
            //            PayFontMoneyViewController * payFomntVC = [[PayFontMoneyViewController alloc] init];
            //            [self.navigationController pushViewController:payFomntVC animated:YES];
        } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
            
            [self clickApplyProtectPower:self.detailModel.ID];
            
        } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
            
            // 跳转至联系卖家
            SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat3 conversationType:(EMConversationTypeChat)];
            viewController.title = EaseTest_Chat3;
            viewController.chatID = EaseTest_Chat3;
            viewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:viewController animated:YES];
            DLog(@"%@--%@",self,button.titleLabel.text);

        }
        
    };
    
    [cell addSubview:funcBtn];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GotoAssessViewController * goToAssessVC = [[GotoAssessViewController alloc] init];
    [self.navigationController pushViewController:goToAssessVC animated:YES];
    
}

@end
