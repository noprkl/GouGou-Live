//
//  WatiConsigneeViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WatiConsigneeViewController.h"

#import "FunctionButtonView.h" // cell下边的按钮
#import "WaitConsignessCell.h" // 代收货cell
#import "ApplyProtectPowerViewController.h" // 申请维权控制器
#import "DeletePrommtView.h" // 提示框（此处为不想买了复用）
#import "ProtecePowerPromptView.h"

static NSString * waitConsignessCell = @"waitConsignessCell";
@interface WatiConsigneeViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation WatiConsigneeViewController

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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 88 - 64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[WaitConsignessCell class] forCellReuseIdentifier:waitConsignessCell];
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
    
    WaitConsignessCell * cell = [tableView dequeueReusableCellWithIdentifier:waitConsignessCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 289, SCREEN_WIDTH, 44)title:@[@"申请维权",@"联系卖家",@"确认收货"] buttonNum:3];
   
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"确认收货"]) {
            
        
            
            DLog(@"%@--%@",self,button.titleLabel.text);
            
        } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
            // 跳转至联系卖家
            
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

#pragma mark
#pragma mark - 弹框显示
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
