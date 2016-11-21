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

static NSString * waitBackCells = @"waitBackCells";

@interface AllOrderGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation AllOrderGoodsViewController

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
    
    WaitBackMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitBackCells];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // cell底部按钮
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"查看评价",@"申请维权",@"联系买家",@"删除订单"] buttonNum:4];
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"删除订单"]) {
            
            [self clickDeleteOrder];
            
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
            
            [self clickApplyProtectPower];
        }
        
    };
    
    [cell addSubview:funcBtn];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
