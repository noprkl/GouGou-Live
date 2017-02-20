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
@property (strong,nonatomic) PayMentmodel *payMenmodel;

@end

@implementation PaymentDetailsController
#pragma mark - 网络请求
- (void)getRequest {
    
    NSDictionary *dict =@{
                          @"id":_paymentId,
                          };
    
    [self getRequestWithPath:API_GetUserAssertlimit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [PayMentmodel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        self.payMenmodel = arr[0];
        [self.tableView reloadData];
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
        _dataArray = @[@"流水号:",@"类型:",@"收支:",@"支付方式:",@"订单号:",@"时间:",@"余额:"];
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
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(cell.textLabel.frame) + 10, CGRectGetMinY(cell.textLabel.frame), 200, CGRectGetMaxY(cell.textLabel.frame) - CGRectGetMinY(cell.textLabel.frame))];
    contentLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    contentLabel.font =[UIFont systemFontOfSize:16];

    switch (indexPath.row) {
        case 0: // 流水号
            contentLabel.text = self.payMenmodel.ID;
            break;
        case 1: // 交易类型
        {
            if ([self.payMenmodel.assetChangeType isEqualToString:@"-1"]) {
                contentLabel.text = @"转出，下单扣除";
            }else if ([self.payMenmodel.assetChangeType isEqualToString:@"-2"]) {
                contentLabel.text = @"转出，提现";
            }else if ([self.payMenmodel.assetChangeType isEqualToString:@"1"]) {
                contentLabel.text = @"转入，维权";
            }else if ([self.payMenmodel.assetChangeType isEqualToString:@"2"]) {
                contentLabel.text = @"转入，后台充值";
            }else if ([self.payMenmodel.assetChangeType isEqualToString:@"3"]) {
                contentLabel.text = @"转入，取消订单，获得系统退款";
            }else if ([self.payMenmodel.assetChangeType isEqualToString:@"4"]) {
                contentLabel.text = @"转入，订单收益";
            }
        }
            break;
        case 2: // 收入
            contentLabel.text = self.payMenmodel.assetChange;
            break;
        case 3: // 支付方式
        {
            if ([self.payMenmodel.payMethod isEqualToString:@"1"]) {
                contentLabel.text = @"微信支付";
            }else if ([self.payMenmodel.payMethod isEqualToString:@"2"]) {
                contentLabel.text = @"支付宝支付";
            }else if ([self.payMenmodel.payMethod isEqualToString:@"3"]||[self.payMenmodel.payMethod isEqualToString:@"0"]) {
                contentLabel.text = @"钱包支付";
            }
        }
            break;
        case 4: // 订单号
            contentLabel.text = self.payMenmodel.orderId;
            break;
        case 5: // 时间
            contentLabel.text = [NSString stringFromDateString:self.payMenmodel.assetChangeTime];
            break;
        case 6: // 余额
            contentLabel.text = self.payMenmodel.nowAsset;
            break;
        default:
            break;
    }
    
    [cell.contentView addSubview:contentLabel];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
