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
#import "DeletePrommtView.h" // 弹出的提示框
#import "PayingAllMoneyViewController.h" // 支付全款
#import "ProtecePowerPromptView.h" // 确定维权提示框
#import "ApplyProtectPowerViewController.h" // 申请维权控制器

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
    
    return 245;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WaitBackMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitBackCells];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // cell底部按钮
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 45) title:@[@"查看评价",@"申请维权",@"联系买家",@"删除订单"] buttonNum:4];
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"删除订单"]) {
            
            [self clickDeleteOrder];
            
        } else if ([button.titleLabel.text  isEqual:@"查看评价"]){
            // 跳转至支付全款
            PayingAllMoneyViewController * payAllVC = [[PayingAllMoneyViewController alloc] init];
            
            [self.navigationController pushViewController:payAllVC animated:YES];
            
        } else if ([button.titleLabel.text isEqual:@"申请维权"]) {
            
            [self clickApplyProtectPower];
        }
        
    };
    
    [cell addSubview:funcBtn];
    
    return cell;
}
#pragma mark
#pragma mark - 弹框方法调用
// 删除订单
- (void)clickDeleteOrder {
   
    // 点击删除订单出现的弹框
    DeletePrommtView * prompt = [[DeletePrommtView alloc] init];
    prompt.message = @"删除订单后将不能找回";
    
    prompt.sureBlock = ^(UIButton * btn) {
        
        // 点击确定按钮，删除订单
        
    };
    
    [prompt show];

}
// 点击申请维权调用
- (void)clickApplyProtectPower {

    // 点击申请维权按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"我们会再次调查您的实际情况，并根据《用户使用协议》维护您的权益";
    
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureBlock = ^(UIButton *btn) {
        
        // 点击弹框内确认按钮出现的弹框
        ProtecePowerPromptView * pppView = [[ProtecePowerPromptView alloc] init];
        pppView.message = @"请保持电话通畅，\n如有疑问请拨打热线电话010-0928928";
        [weakself dismiss];
        
        pppView.sureApplyBtnBlock = ^(UIButton * btn) {
            
            // 跳转至申请维权
            ApplyProtectPowerViewController * allpyProVC = [[ApplyProtectPowerViewController alloc] init];
            [self.navigationController pushViewController:allpyProVC animated:YES];

        };
        // 弹框显示
        [pppView show];
        
    };
    // 弹框显示
    [allpyPrompt show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
