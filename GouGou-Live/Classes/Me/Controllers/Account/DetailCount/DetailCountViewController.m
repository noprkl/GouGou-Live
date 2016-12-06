//
//  DetailCountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DetailCountViewController.h"
#import "DetailCountTopView.h"
#import "DetailCountViewCell.h"
#import "UserAssetModel.h"

@interface DetailCountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) DetailCountTopView *centerView; /**< headerView */

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 总数据源 */
@property(nonatomic, strong) NSArray *allcomeArr; /**< 全部 */
@property(nonatomic, strong) NSMutableArray *incomeArr; /**< 收入 */
@property(nonatomic, strong) NSMutableArray *outComeArr; /**< 支出 */
@property(nonatomic, strong) NSMutableArray *payingArr; /**< 支付中 */
@property(nonatomic, strong) NSString *allCount; /**< 总收入 */
@property(nonatomic, strong) UILabel *headerLabel; /**< 头部内容 */

@end

static NSString *cellid = @"cellid";

@implementation DetailCountViewController
- (void)getReauestAssetDetail {
    NSDictionary *dict = @{
                           @"user_id":@(11),
                           @"page":@(1),
                           @"pageSize":@(5)
                           };
    [self getRequestWithPath:API_GetUserAssertDetai params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            
        }
        self.dataArr = [UserAssetModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        self.allcomeArr = self.dataArr ;
        
        // 对数据分类
        for (NSInteger i = 0; i < self.dataArr.count; i ++) {
            UserAssetModel *model = self.dataArr[i];
            if ([model.assetChangeType isEqualToString:@"-1"]) { //转出，下单扣除
                [self.outComeArr addObject:model];
            }else if ([model.assetChangeType isEqualToString:@"-2"]){ //转出，提现
                [self.outComeArr addObject:model];
            }else if ([model.assetChangeType isEqualToString:@"1"]){ //转入，维权
                [self.incomeArr addObject:model];
            }else if ([model.assetChangeType isEqualToString:@"2"]){ //转入，后台充值
                [self.incomeArr addObject:model];
            }else if ([model.assetChangeType isEqualToString:@"3"]){ //转入，取消订单，获得系统退款
                [self.payingArr addObject:model];
            }
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getReauestAssetDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
    [self setNavBarItem];
}
- (void)initUI {
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.tableView];
    
    self.edgesForExtendedLayout = 0;
    
    [self.centerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo((SCREEN_HEIGHT - 44 - 64));
    }];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"DetailCountViewCell" bundle:nil] forCellReuseIdentifier:cellid];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSArray *)allcomeArr {
    if (!_allcomeArr) {
        _allcomeArr = [NSArray array];
    }
    return _allcomeArr;
}
- (NSMutableArray *)payingArr {
    if (!_payingArr) {
        _payingArr = [NSMutableArray array];
    }
    return _payingArr;
}
- (NSMutableArray *)incomeArr {
    if (!_incomeArr) {
        _incomeArr = [NSMutableArray array];
    }
    return _incomeArr;
}
- (NSArray *)outComeArr {
    if (!_outComeArr) {
        _outComeArr = [NSMutableArray array];
    }
    return _outComeArr;
}
// 一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
//    return 10;
}
// 加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}
// 头部添加内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        label.textColor = [UIColor colorWithHexString:@"#000000"];
        label.font = [UIFont systemFontOfSize:16];
//        label.text = self.allCount;
        label.text = @"总收入：10000";
        self.headerLabel = label;
        [view addSubview:label];
        
        return view;
    }
    return nil;
}
// 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 65;
}

- (DetailCountTopView *)centerView {
    
    if (!_centerView) {
        _centerView = [[DetailCountTopView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        _centerView.talkBlock = ^(UIButton *btn){
            weakSelf.dataArr = weakSelf.allcomeArr;
            [weakSelf.tableView reloadData];
            
//            CGFloat money = 0;
//            for (NSInteger i = 0; i < weakSelf.allcomeArr.count; i ++) {
//                UserAssetModel *model = weakSelf.allcomeArr[i];
//                money += [model.assetChange floatValue];
//            }
            weakSelf.headerLabel.text = @"总收入：10000";
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            weakSelf.dataArr = weakSelf.incomeArr;
            [weakSelf.tableView reloadData];
            DLog(@"收入");
            weakSelf.headerLabel.text = @"总收入：10000";
            
            return YES;
        };
        _centerView.serviceBlock = ^(UIButton *btn){
            weakSelf.dataArr = weakSelf.outComeArr;
            [weakSelf.tableView reloadData];
            DLog(@"支出");
        weakSelf.headerLabel.text = @"总支出：10000";
            return YES;
        };
        _centerView.sellerBlock = ^(UIButton *btn){
            weakSelf.dataArr = weakSelf.payingArr;
            [weakSelf.tableView reloadData];
            DLog(@"交易中");
            weakSelf.headerLabel.text = @"交易中：10000";
            return YES;
        };
    }
    return _centerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
