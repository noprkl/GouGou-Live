//
//  SellerMyGoodsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerMyGoodsViewController.h"
#import "SellerMyGoodsTopView.h"
#import "SellerMyGoodsCell.h"
#import "SellerGoodsBarBtnView.h"
#import "SellerGoodsBottomView.h"

#import "DogDetailViewController.h" // 狗狗详情
#import "SellerCreateDogMessageViewController.h" // 新建狗狗

#import "SellerDeleDDetailView.h" //删除弹窗
#import "SellerMyGoodsModel.h"

@interface SellerMyGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) SellerMyGoodsTopView *headerView; /**< 头部View */

@property(nonatomic, strong) SellerGoodsBarBtnView *barBtnView; /**< 自定义按钮 */

@property(nonatomic, strong) SellerGoodsBottomView *bottomView; /**< 底部按钮 */

#pragma mark - 选中信息
@property(nonatomic, strong) NSMutableArray *selectedData; /**< 选中的数据 */

@property(nonatomic, strong) UIButton *allBtn; /**< 全选按钮 */

@property(nonatomic, assign) BOOL isMove; /**< 是否移动cell */

@property(nonatomic, assign) BOOL isSelect; /**< 是否选中 */

@property (nonatomic, assign) NSInteger lastBtn; /**< 上一个按钮 */

@end

static NSString *cellid = @"SellerMyGoodsCell";

@implementation SellerMyGoodsViewController
#pragma mark
#pragma mark - 网络请求
// 全部商品
- (void)getRequestSellerDog {
    NSDictionary *dict = @{ //
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"page":@(1),
                           @"pageSize":@(10),
                           @"type":@(0)
                           };
    [self showHudInView:self.view hint:@"加载中"];

    [self getRequestWithPath:API_Commodity params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            self.dataArr = [SellerMyGoodsModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            [self.tableView reloadData];
            [self hideHud];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 删除
- (void)deleGoods {
    for (NSInteger i = 0; i < self.selectedData.count; i ++) {
        SellerMyGoodsModel *model = self.selectedData[i];
        [self.selectedData replaceObjectAtIndex:i withObject:model.ID];
    }
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"id":[self.selectedData componentsJoinedByString:@","]
                           };
    
    [self getRequestWithPath:API_Del_Commodity params:dict success:^(id successJson) {
        //        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        [self getRequestSellerDog];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 不同状态请求
- (void)GetRequestStateGoods:(NSInteger)state {
    NSDictionary *dict = @{ //
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"page":@(1),
                           @"pageSize":@(10),
                           @"type":@(state)
                           };
    [self showHudInView:self.view hint:@"加载中"];

    [self getRequestWithPath:API_Commodity params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [SellerMyGoodsModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        [self.tableView reloadData];
        [self hideHud];
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

}
- (void)initUI{
    _isMove = NO;
    _isSelect = NO;
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.tableView];
//    if (self.lastBtn == 5) {
        [self getRequestSellerDog];
//    }else{
//        [self GetRequestStateGoods:self.lastBtn];
//    }
    // 添加两个按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.barBtnView];
    self.navigationItem.rightBarButtonItem = item;
   
    [self.view addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    
    // 上下拉刷新
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getRequestSellerDog];
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)selectedData {
    if (!_selectedData) {
        _selectedData = [NSMutableArray array];
    }
    return _selectedData;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.tableHeaderView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[SellerMyGoodsCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
// 头部
- (SellerMyGoodsTopView *)headerView {
    if (!_headerView) {
        _headerView = [[SellerMyGoodsTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _headerView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;

        _headerView.allBlock = ^(){ //0 所有 1审核中/审核未通过  2 售完 3 待售
            weakSelf.lastBtn = 0;
            [weakSelf GetRequestStateGoods:0];
        };
        _headerView.waitSellBlock = ^(){
            weakSelf.lastBtn = 3;
            [weakSelf GetRequestStateGoods:3];
        };
        _headerView.soldBlock = ^(){
            weakSelf.lastBtn = 2;
            [weakSelf GetRequestStateGoods:2];
        };
        _headerView.reviewBlock = ^(){
            weakSelf.lastBtn = 1;
            [weakSelf GetRequestStateGoods:1];
        };
    }
    return _headerView;
}
// 编辑
- (SellerGoodsBarBtnView *)barBtnView {
    if (!_barBtnView) {
        _barBtnView = [[SellerGoodsBarBtnView alloc] init];
        _barBtnView.bounds = CGRectMake(0, 0, 100, 44);
        __weak typeof(self) weakSelf = self;
        _barBtnView.editBlock = ^(BOOL flag){
#pragma mark - 编辑
            // 清除所有选中数据
            [weakSelf.selectedData removeAllObjects];
            
            // 设置cell移动
            _isMove = flag;
            [weakSelf.tableView reloadData];
            
            // 编辑时不允许跳转 底部按钮不隐藏
            weakSelf.bottomView.hidden = !flag;
            // 当底部按钮隐藏时 全选按钮为非选中状态
            if (weakSelf.bottomView.hidden) {
                weakSelf.allBtn.selected = NO;
            }
            
            // 头部按钮不能点击
            weakSelf.headerView.canClick = !flag;
        };
        _barBtnView.addBlock = ^(){
            // 添加狗狗
            SellerCreateDogMessageViewController *createDogVC = [[SellerCreateDogMessageViewController alloc] init];
            [weakSelf.navigationController pushViewController:createDogVC animated:YES];
        };
    }
    return _barBtnView;
}
// 底部按钮
- (SellerGoodsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerGoodsBottomView alloc] init];
        _bottomView.hidden = YES;
        _bottomView.backgroundColor = [UIColor whiteColor];
    
        __weak typeof(self) weakSelf = self;
        _bottomView.allSelectBlock = ^(UIButton *btn){
            btn.selected = !btn.selected;
            // 全选按钮选中
            _isSelect = btn.selected;
            
            // 如果全选 把数据全添加进去
            if (btn.selected) {
                [weakSelf.selectedData addObjectsFromArray:weakSelf.dataArr];
                
            }else{ // 否则 把数据全清除
                [weakSelf.selectedData removeAllObjects];
            }
            [weakSelf.tableView reloadData];
            
            weakSelf.allBtn = btn;
        };
        
        // 删除选中数据
        _bottomView.deleteBlock = ^(){
            
            __block SellerDeleDDetailView *prommit = [[SellerDeleDDetailView alloc] init];
            NSInteger count = 0;
            if (weakSelf.allBtn.selected) {
                count = self.dataArr.count;
            }else{
                count = self.selectedData.count;
            }
            prommit.message = [NSString stringWithFormat:@"你将删除%ld个宝贝", count];
            prommit.sureBlock = ^(UIButton *btn){
                [weakSelf deleGoods];
                [weakSelf.dataArr removeObjectsInArray:weakSelf.selectedData];
                
                _isMove = YES;
//                [weakSelf.tableView reloadData];
                // 清空数据
                [weakSelf.selectedData removeAllObjects];
                
                prommit = nil;
                [prommit dismiss];
            };
            [prommit show];
            
        };
    }
    return _bottomView;
}

#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SellerMyGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    SellerMyGoodsModel *index = self.dataArr[indexPath.row];
    cell.model = index;

    BOOL btnFlag = [self.selectedData containsObject:index];
    cell.isBtnSelect = btnFlag;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.isMove = _isMove;

    
#pragma mark - 添加选中数据
    __weak typeof(self) weakSelf = self;

    // 判断当前数据是否在数组中
    cell.selectBlock = ^(UIButton *btn){
        BOOL flag = [self.selectedData containsObject:index];
        
        DLog(@"%c", flag);
        if (flag) {
            // 如果存在 删掉
            [weakSelf.selectedData removeObject:index];
            btn.selected = NO;

        }else{
            [weakSelf.selectedData addObject:index];
            btn.selected = YES;
        }
        DLog(@"%@",weakSelf.selectedData);
    };
    


    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerMyGoodsModel *model = self.dataArr[indexPath.row];

    if (!_isMove) {
        DogDetailViewController *dogDetailVC = [[DogDetailViewController alloc] init];
        dogDetailVC.model = model;
        [self.navigationController pushViewController:dogDetailVC animated:YES];
    }
  
}
@end
