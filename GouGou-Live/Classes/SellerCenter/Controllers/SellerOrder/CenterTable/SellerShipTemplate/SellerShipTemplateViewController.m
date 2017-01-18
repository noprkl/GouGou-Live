//
//  SellerShipTemplateViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerShipTemplateViewController.h"
#import "SellerNoneShipTemplate.h"
#import "SellerShipTemplateCell.h"
#import "DeletePrommtView.h"

#import "SellerAddShipTemplateViewController.h" // 模板管理
#import "SellerShipTemplateModel.h"
#import "SellerEditShipTemplateVc.h"

@interface SellerShipTemplateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerNoneShipTemplate *noneTemplate; /**< 没有运费模板 */

@property (nonatomic, strong) UILabel *noneTemplateLabel; /**< 没有模板 */

@property(nonatomic, strong) UIButton *lastBtn; /**< 上一个按钮 */

@end

static NSString *cellid = @"SellerShipTemplateCell";

@implementation SellerShipTemplateViewController
// 请求运费模板
- (void)getRequestShipTemplate {
    NSDictionary *dict = @{
                    @"user_id":[UserInfos sharedUser].ID,
                    @"page":@1,
                    @"pageSize":@10
                    };
    [self showHudInView:self.view hint:@"加载中"];

    [self getRequestWithPath:API_List_freight params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [SellerShipTemplateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
        if (self.dataArr.count == 0) {
            self.noneTemplateLabel.hidden = NO;
            self.tableView.hidden = YES;
        }else{
            self.noneTemplateLabel.hidden = YES;
            self.tableView.hidden = NO;
        }
        [self.tableView reloadData];
        [self hideHud];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 设置默认模板
- (void)setDefaultShiptemplate:(SellerShipTemplateModel *)model {
    NSDictionary *dict = @{
                           @"is_default":@(1),
                           @"id":@(model.ID)
                           };
    [self getRequestWithPath:API_Freight_default params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        // 重新请求
        [self getRequestShipTemplate];
    } error:^(NSError *error) {
        
    }];
}
- (void)deleteShipTemplate:(SellerShipTemplateModel *)model {
    NSDictionary *dict = @{
                           @"id":@(model.ID)
                           };
    [self getRequestWithPath:API_Del_freight params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        // 重新请求
        [self getRequestShipTemplate];
    } error:^(NSError *error) {
        
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStylePlain) target:self action:@selector(addShipTemplate)];
    [self getRequestShipTemplate];
    // 判断是否有运费模板
    //
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:self.noneTemplateLabel];
    [self.noneTemplateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.top).offset(40);
        make.centerX.equalTo(self.tableView.centerX);
    }];
}
- (void)initUI{
    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getRequestShipTemplate];
        [self.tableView.mj_header endRefreshing];
    }];
}
- (void)addShipTemplate {
    SellerAddShipTemplateViewController *addTemplateVC = [[SellerAddShipTemplateViewController alloc] init];
    addTemplateVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:addTemplateVC animated:YES];
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (SellerNoneShipTemplate *)noneTemplate {
    if (!_noneTemplate) {
        _noneTemplate = [[SellerNoneShipTemplate alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    return _noneTemplate;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerShipTemplateCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (UILabel *)noneTemplateLabel {
    if (!_noneTemplateLabel) {
        _noneTemplateLabel = [[UILabel alloc] init];
        _noneTemplateLabel.text = @"暂时还没有运费模板";
        _noneTemplateLabel.font = [UIFont systemFontOfSize:14];
        _noneTemplateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _noneTemplateLabel.textAlignment = NSTextAlignmentCenter;
        _noneTemplateLabel.hidden = YES;
    }
    return _noneTemplateLabel;
}

#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerShipTemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    SellerShipTemplateModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    __weak typeof(self) weakSlef = self;
    cell.acquiesceBlock = ^(UIButton *acquBtn){
        [weakSlef setDefaultShiptemplate:model];
    };
    
    cell.editBtnBlock = ^(){
        DLog(@"编辑模板--%ld", indexPath.row);
        SellerEditShipTemplateVc *editShipVc = [[SellerEditShipTemplateVc alloc] init];
        editShipVc.hidesBottomBarWhenPushed = YES;
        editShipVc.shipModel = model;
        [weakSlef.navigationController pushViewController:editShipVc animated:YES];
    };
    
    cell.deleteBlock = ^(){
        DeletePrommtView *deleAlert = [[DeletePrommtView alloc] init];
        deleAlert.message = @"确认删除这个运费模板";
        deleAlert.sureBlock = ^(UIButton *btn){
            [weakSlef deleteShipTemplate:model];
        };
        [deleAlert show];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 155;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
