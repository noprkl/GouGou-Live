//
//  WaitPayingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WaitPayingViewController.h"  // 待支付控制器
#import "WaitBackMoneyCell.h"  // 待付尾款cell
#import "WaitFontMoneyCell.h"  // 待付定金cell
#import "WaitAllMoneyCell.h"   // 待付全款cell
#import "FunctionButtonView.h"  // cell下边按钮
#import "PayingAllMoneyViewController.h"  // 支付全款控制器
#import "ApplyProtectPowerViewController.h" // 申请维权控制器
#import "DogSizeFilter.h"  // 狗狗尺寸筛选弹框
#import "NicknameView.h" // 商家昵称View

#import "DeletePrommtView.h" // 提示框（此处为不想买了复用）

#import "PromptView.h"   // 支付密码验证弹框
#import "PayMoneyPrompt.h" // 支付弹框
#import "ProtecePowerPromptView.h"

static NSString * waitBackCell = @"waitBackCellID";
static NSString * waitFontCell = @"waitFontCellID";
static NSString * waitAllMoneyCell = @"waitAllMoneyCellID";

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
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 88 - 64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        // 注册cell
        [_tableview registerClass:[WaitBackMoneyCell class] forCellReuseIdentifier:waitBackCell];
        [_tableview registerClass:[WaitFontMoneyCell class] forCellReuseIdentifier:waitFontCell];
        [_tableview registerClass:[WaitAllMoneyCell class] forCellReuseIdentifier:waitAllMoneyCell];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 245;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        WaitBackMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitBackCell];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 45) title:@[@"支付尾款",@"不想买了",@"联系买家",@"申请维权"] buttonNum:4];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"申请维权"]) {
                // 点击申请维权
                [self clickApplyProtectPower];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text  isEqual:@"支付尾款"]){
                // 点击支付尾款
                [self clickPayBackMoney];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"不想买了"]) {
                // 点击不想买了
                [self clickNotBuy];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
        
    } else if (indexPath.row == 1) {
        
        WaitFontMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitFontCell];
        
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 45) title:@[@"支付定金",@"取消订单",@"联系买家"] buttonNum:3];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"取消订单"]) {
                // 点击取消订单
                [self clickCancleOrder];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            } else if ([button.titleLabel.text  isEqual:@"支付定金"]){
                // 点击支付定金
                [self clickPayFontMoney];
                
                DLog(@"%@--%@",self,button.titleLabel.text);

                
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
                
                DLog(@"%@--%@",self,button.titleLabel.text);
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    } else if (indexPath.row == 2) {
        
        WaitAllMoneyCell * cell = [tableView dequeueReusableCellWithIdentifier:waitAllMoneyCell];
        
        FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 45) title:@[@"支付全款",@"联系买家"] buttonNum:2];
        
        funcBtn.difFuncBlock = ^(UIButton * button) {
            if ([button.titleLabel.text  isEqual:@"支付全款"]) {
                // 点击支付全乱
                [self clickPayAllMoney];
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
//                // 待付全款控制器
//                PayingAllMoneyViewController * payAllVC = [[PayingAllMoneyViewController alloc] init];
//                
//                [self.navigationController pushViewController:payAllVC animated:YES];
            } else if ([button.titleLabel.text isEqual:@"联系卖家"]) {
               // 跳转至联系卖家
                
                DLog(@"%@--%@",self,button.titleLabel.text);
                
            }
            
        };
        
        [cell.contentView addSubview:funcBtn];
        
        return cell;
    }
    
    return nil;
}
#pragma mark
#pragma mark - 出现弹框方法
// 尾金支付
- (void)clickPayBackMoney {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    
    payMonery.dataArr = @[@"支付尾金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };

}
// 定金支付
- (void)clickPayFontMoney {
    
    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    
    payMonery.dataArr = @[@"支付定金",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };

}
// 全款支付
- (void)clickPayAllMoney {

    PayMoneyPrompt * payMonery = [[PayMoneyPrompt alloc] init];
    
    payMonery.dataArr = @[@"支付全款",@"应付金额",@"支付方式",@"账户余额支付",@"微信支付",@"支付宝支付",@"取消"];
    [payMonery show];
    
    payMonery.bottomBlock = ^(NSString *size){
        DLog(@"%@", size);
    };


}
// 点击不想买了
- (void)clickNotBuy {
    // 点击不想买了按钮出现的弹框
    DeletePrommtView * allpyPrompt = [[DeletePrommtView alloc] init];
    allpyPrompt.message = @"放弃定金后，定金将全部打给卖家";
    __weak typeof(allpyPrompt) weakself = allpyPrompt;
    
    allpyPrompt.sureBlock = ^(UIButton * btn) {
        
        [weakself dismiss];
        
        PromptView * prompt = [[PromptView alloc] init];
        prompt.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        __weak typeof(prompt) weakself = prompt;
        
        prompt.clickSureBtnBlock = ^() {
            
            // 判断支付密码输入是否正确，如果正确（fade）
            
            //
            return @"0";
        };
        
        [prompt show];
        
    };
    
    [allpyPrompt show];

}
// 点击取消订单
- (void)clickCancleOrder {
    DeletePrommtView * promptView = [[DeletePrommtView alloc] init];
    __weak typeof(promptView) weakself = promptView;
    
    promptView.message = @"取消订单后,有可能被别人买走";
    
    promptView.sureBlock = ^(UIButton *btn) {
        
        [weakself dismiss];
        
        DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
        sizeView.dataArr =  @[@"请选择原因", @"喜欢其他狗狗",@"不喜欢这只了",@"条件不允许养了",@"运费太贵", @"确定"];
        [sizeView show];
        
        sizeView.bottomBlock = ^(NSString *size){
            DLog(@"%@", size);
        };
        
    };
    [promptView show];

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
    // Dispose of any resources that can be recreated.
}


@end
