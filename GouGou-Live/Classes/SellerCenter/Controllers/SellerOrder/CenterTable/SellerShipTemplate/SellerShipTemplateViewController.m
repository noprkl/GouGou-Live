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

@interface SellerShipTemplateViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerNoneShipTemplate *noneTemplate; /**< 没有运费模板 */

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
    [self getRequestWithPath:API_List_freight params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [SellerShipTemplateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
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
    //    [self.view addSubview:self.noneTemplate];
    [self.view addSubview:self.tableView];
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
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerShipTemplateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.model = self.dataArr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        self.lastBtn.selected = YES;
    }
    cell.acquiesceBlock = ^(UIButton *acquBtn){
        
        self.lastBtn.selected = NO;
        acquBtn.selected = YES;
        self.lastBtn = acquBtn;
    };
    
    cell.editBtnBlock = ^(){
        DLog(@"编辑模板--%ld", indexPath.row);
    };
    
    cell.deleteBlock = ^(){
        DeletePrommtView *deleAlert = [[DeletePrommtView alloc] init];
        deleAlert.message = @"确认删除这个运费模板";
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
