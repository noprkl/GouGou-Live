//
//  WaitConsignmentViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "WaitConsignmentViewController.h"
#import "FunctionButtonView.h"  // cell下边的按钮
#import "WaitConsignmentCell.h" // 待发货cell
#import "ProtecePowerPromptView.h"

static NSString * waitConsignmentCell = @"waitConsignmentCell";
@interface WaitConsignmentViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation WaitConsignmentViewController

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
        [_tableview registerClass:[WaitConsignmentCell class] forCellReuseIdentifier:waitConsignmentCell];
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
    
    WaitConsignmentCell * cell = [tableView dequeueReusableCellWithIdentifier:waitConsignmentCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, 45) title:@[@"申请维权",@"联系买家",@"提醒发货"] buttonNum:3];
    
    funcBtn.difFuncBlock = ^(UIButton * button) {
        if ([button.titleLabel.text  isEqual:@"提醒发货"]) {
            
            // 跳转至提醒发货
#warning 不同提示框
            [self clickConsignment];
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
            [self clickApplyProtectPower];
            
            DLog(@"%@--%@",self,button.titleLabel.text);
            
        }
        
    };
    
    [cell addSubview:funcBtn];
    
    return cell;
}

@end
