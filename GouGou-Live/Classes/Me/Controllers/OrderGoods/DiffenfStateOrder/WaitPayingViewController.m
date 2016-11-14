//
//  WaitPayingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WaitPayingViewController.h"
#import "AllOrderGoodsCell.h"
#import "FunctionButtonView.h"
#import "ResonsTableView.h"
#import "PayingAllMoneyViewController.h"

static NSString * allGoodsCell = @"allGoodsCellID";
@interface WaitPayingViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation WaitPayingViewController

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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[AllOrderGoodsCell class] forCellReuseIdentifier:allGoodsCell];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 330;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllOrderGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:allGoodsCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 289, SCREEN_WIDTH, 45) title:@[@"取消订单",@"联系买家",@"支付全款"] buttonNum:3];
    
    //    __weak typeof(self) weakself = self;
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"取消订单"]) {
            
            ResonsTableView * reson = [[ResonsTableView alloc] init];
            [reson show];
            
        } else if ([button.titleLabel.text  isEqual:@"支付全款"]){
            
            PayingAllMoneyViewController * payAllVC = [[PayingAllMoneyViewController alloc] init];
            
            [self.navigationController pushViewController:payAllVC animated:YES];
            
        }
        
    };
    
    [cell addSubview:funcBtn];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
