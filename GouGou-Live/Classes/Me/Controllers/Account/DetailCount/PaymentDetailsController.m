//
//  PaymentDetailsController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PaymentDetailsController.h"
#import "PayMentmodel.h"

static NSString * detailTextCell = @"detailTextCellID";
@interface PaymentDetailsController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableView;
/** celltext数据源 */
@property (strong,nonatomic) NSArray *dataArray;
/** cellDetailText数据 */
@property (strong,nonatomic) NSArray *detailTextArray;

/** 类型 */
@property (strong,nonatomic) NSString *typeStr;
/** 支付方式 */
@property (strong,nonatomic) NSString *payMentStr;

/** 模型 */
@property (strong,nonatomic) PayMentmodel *model;


@end

@implementation PaymentDetailsController
#pragma mark - 网络请求
- (void)getRequest {
    
    NSDictionary *dict =@{
                          @"id":@(1),
//                          @"pay_ment":@(1),
//                          @"type":@(1)
                          };
    
    [self getRequestWithPath:@"/api/UserService/getUserAssertlimit/id/1" params:dict success:^(id successJson) {
        
        
        DLog(@"%@",successJson);
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
    self.title = @"收支详情";
}

- (void)initUI {
    [self.view addSubview:self.tableView];
}
#pragma mark - 懒加载
- (NSArray *)dataArray {

    if (!_dataArray) {
        _dataArray = @[@"流水号:",@"类型:",@"收入:",@"支付方式:",@"订单号:",@"时间:",@"余额:"];
    }
    return _dataArray;
}

- (NSArray *)detailTextArray {

    if (!_detailTextArray) {
        _detailTextArray = [NSArray array];
    }
    return _detailTextArray;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _tableView;
}
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:detailTextCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:detailTextCell];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font =[UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
