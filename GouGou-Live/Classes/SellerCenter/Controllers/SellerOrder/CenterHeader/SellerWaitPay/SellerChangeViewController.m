//
//  SellerChangeViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerChangeViewController.h"
#import "PromptView.h" // 弹窗

@interface SellerChangeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SellerAcceptRateCell";

@implementation SellerChangeViewController

#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    
    [self.view addSubview:self.tableView];
    [self showAlertView];
}


// 网络请求
- (void)codePayPsdRequest {
    
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 230;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
}
- (void)showAlertView {
    // 封装蒙版的View
    __block  PromptView * prompt = [[PromptView alloc] initWithFrame:self.view.bounds];
    prompt.title = @"请输入交易密码";
    
    __weak typeof(self) weakself = self;
    // 提示框textfiled设置代理
    prompt.playpsdBlock = ^(UITextField *textfiled) {
        
    };
    
    // 点击提示框确认按钮请求支付密码
    prompt.clickSureBtnBlock = ^(){
        [weakself codePayPsdRequest];
        
        return @"输入错误";
    };
    
    prompt.cancelBlock = ^(){
        [weakself.navigationController popViewControllerAnimated:YES];
        prompt = nil;
        [prompt dismiss];
        
        
    };
    // 显示蒙版
    [prompt show];
}
@end
