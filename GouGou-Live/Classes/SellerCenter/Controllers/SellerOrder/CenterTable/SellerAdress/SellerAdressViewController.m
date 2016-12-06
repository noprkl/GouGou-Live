//
//  SellerAdressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  卖家中心-商家地址

#import "SellerAdressViewController.h"
#import "SellerAdressCell.h"
#import "SellerEditAdressVc.h"
#import "SellerAddNewAdressVc.h"
#import "DeletePrommtView.h"
#import "SellerAdressModel.h"

@interface SellerAdressViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据源 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@property(nonatomic, strong) UIButton *lastBtn; /**< 上一个按钮 */

@end

static NSString * indenifer = @"SellerAdressCell";

@implementation SellerAdressViewController

#pragma mark
#pragma mark - 网络请求
// 所有地址
- (void)postGetAdressRequest {
    
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue])
                           };
    [self getRequestWithPath:API_Seller_address params:dict success:^(id successJson) {
        [self showAlert:successJson[@"message"]];
        DLog(@"1%@", successJson);
        if (successJson[@"code"]) {
            // 数据解析
            self.dataArray = [[SellerAdressModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]] mutableCopy];
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
    [self postGetAdressRequest];
    // 上下拉刷新
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self postGetAdressRequest];
        [self.tableview.mj_header endRefreshing];
    }];    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)initUI {
    
    self.title = @"商家地址";
    self.edgesForExtendedLayout = 0;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStyleDone) target:self action:@selector(ClickAddBtnBlock)];
    
    [self.view addSubview:self.tableview];
    [self.tableview makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}
- (void)ClickAddBtnBlock {
    
    SellerAddNewAdressVc *addAdressVC = [[SellerAddNewAdressVc alloc] init];
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
        [_tableview registerClass:[SellerAdressCell class] forCellReuseIdentifier:indenifer];
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
    
    SellerAdressCell * cell = [tableView dequeueReusableCellWithIdentifier:indenifer];
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SellerAdressModel *model = (SellerAdressModel *)self.dataArray[indexPath.row];
    
    cell.adressModel = model;
    
    // 请求参数
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID intValue]),
                           @"id":@(model.ID)
                           };
    
    // 编辑
    cell.editBtnBlock = ^(){
        
        SellerEditAdressVc * editVC = [[SellerEditAdressVc alloc] init];
        editVC.title  = @"地址编辑";
        editVC.adressModel = model;
        [self.navigationController pushViewController:editVC animated:YES];
    };
    
    // 默认
    cell.acquiesceBlock = ^(UIButton *btn){
        [self getRequestWithPath:API_Seller_address_default params:dict success:^(id successJson) {
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
            
            [self getRequestWithPath:API_Seller_address_del params:dict success:^(id successJson) {
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
