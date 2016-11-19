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

@interface SellerMyGoodsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) SellerMyGoodsTopView *headerView; /**< 头部View */

@property(nonatomic, strong) SellerGoodsBarBtnView *barBtnView; /**< 自定义按钮 */

@property(nonatomic, strong) SellerGoodsBottomView *bottomView; /**< 底部按钮 */

@end

static NSString *cellid = @"SellerMyGoodsCell";

@implementation SellerMyGoodsViewController
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
    // 添加两个按钮
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.barBtnView];
    self.navigationItem.rightBarButtonItem = item;
   
    [self.view addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
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
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerMyGoodsCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (SellerGoodsBarBtnView *)barBtnView {
    if (!_barBtnView) {
        _barBtnView = [[SellerGoodsBarBtnView alloc] init];
        _barBtnView.bounds = CGRectMake(0, 0, 100, 44);
        __weak typeof(self) weakSelf = self;
        _barBtnView.editBlock = ^(BOOL flag){
            weakSelf.tableView.editing = flag;
            weakSelf.bottomView.hidden = !flag;
            

        };
        _barBtnView.addBlock = ^(){
            
        };
    }
    return _barBtnView;
}
- (SellerGoodsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerGoodsBottomView alloc] init];
        _bottomView.hidden = YES;
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.allSelectBlock = ^(){
            
        };
        _bottomView.deleteBlock = ^(){
            
        };
    }
    return _bottomView;
}

#pragma mark - 删除编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete |UITableViewCellEditingStyleInsert;
}

#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerMyGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        cell.cellState = @"待售";
    }else if (indexPath.row == 1){
        cell.cellState = @"已预订";
    }else if (indexPath.row == 2){
        cell.cellState = @"已售";
    }else if (indexPath.row == 3){
        cell.cellState = @"审核中";
    }else if (indexPath.row == 4){
        cell.cellState = @"未通过";
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 108;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    DogDetailViewController *dogDetailVC = [[DogDetailViewController alloc] init];
    
    [self.navigationController pushViewController:dogDetailVC animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        SellerMyGoodsTopView *topView = [[SellerMyGoodsTopView alloc] init];
        topView.backgroundColor = [UIColor whiteColor];
        topView.allBlock = ^(){

            DLog(@"请求+刷新表格-0");
        };
        topView.waitSellBlock = ^(){
            DLog(@"请求+刷新表格-1");
        };
        topView.soldBlock = ^(){
            
            DLog(@"请求+刷新表格-2");
        };
        topView.reviewBlock = ^(){
            
            DLog(@"请求+刷新表格-3");
        };
        return topView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

@end
