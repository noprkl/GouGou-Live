//
//  ShopAddressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ShopAddressViewController.h"
#import "AddrsssTableViewCell.h"
#import "EditNewAddressViewController.h"
#import "AddNewAdressVc.h"
#import "DeletePrommtView.h"
#import "MyShopAdressModel.h"

static NSString * indenifer = @"addressCellID";

@interface ShopAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据源 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@property(nonatomic, strong) UIButton *lastBtn; /**< 上一个按钮 */

@end

@implementation ShopAddressViewController

#pragma mark
#pragma mark - 网络请求
// 所有地址
- (void)postGetAdressRequest {
    
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue])
                           };
    [self getRequestWithPath:API_Address params:dict success:^(id successJson) {
        [self showAlert:successJson[@"message"]];
        DLog(@"1%@", successJson);
        if (successJson[@"code"]) {
            // 数据解析
            self.dataArray = [[MyShopAdressModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]] mutableCopy];
            DLog(@"11%@", self.dataArray);
            // 刷新
            [self.tableview reloadData];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];

}

#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postGetAdressRequest];
        [self.tableview.mj_header endRefreshing];
    }];
    [self.tableview.mj_header beginRefreshing];

}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)initUI {

    self.title = @"收货地址";
    self.edgesForExtendedLayout = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStyleDone) target:self action:@selector(ClickAddBtnBlock)];
    
    [self.view addSubview:self.tableview];
    [self.tableview makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}
- (void)ClickAddBtnBlock {
    
    AddNewAdressVc *addAdressVC = [[AddNewAdressVc alloc] init];
    addAdressVC.title  = @"新增地址";
    [self.navigationController pushViewController:addAdressVC animated:YES];
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableview {

    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview registerClass:[AddrsssTableViewCell class] forCellReuseIdentifier:indenifer];
    }
    return  _tableview;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 113;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AddrsssTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indenifer];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyShopAdressModel *model = (MyShopAdressModel *)self.dataArray[indexPath.row];

    cell.adressModel = model;

    // 请求参数
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID intValue]),
                           @"id":@(model.ID)
                           };
    
    // 编辑
    cell.editBtnBlock = ^(){
    
        EditNewAddressViewController * editVC = [[EditNewAddressViewController alloc] init];
        editVC.title  = @"地址编辑";
        editVC.adressModel = model;
        [self.navigationController pushViewController:editVC animated:YES];
    };
    
    // 默认
    cell.acquiesceBlock = ^(UIButton *btn){
        [self getRequestWithPath:API_Default_address params:dict success:^(id successJson) {
            NSString *string = successJson[@"message"];
            if ([string isEqualToString:@"设置成功"]) {
                [self postGetAdressRequest];
            }
            [self showAlert:string];
        } error:^(NSError *error) {
             DLog(@"%@", error);
        }];
        
    };
    // 删除
    cell.deleteBlock = ^(UIButton * btn) {
       
       __block DeletePrommtView * deletePrommpt = [[DeletePrommtView alloc] init];
        deletePrommpt.sureBlock = ^(UIButton *btn){
          
            [self getRequestWithPath:API_Del_address params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
                
                if ([successJson[@"message"] isEqualToString:@"删除成功"]) {
                    
                    deletePrommpt = nil;
                    [deletePrommpt removeFromSuperview];
                    // 重新请求
                    [self postGetAdressRequest];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        [deletePrommpt show];

    };
    
    return cell;


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
