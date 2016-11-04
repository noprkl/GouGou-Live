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


static NSString * indenifer = @"addressCellID";

@interface ShopAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据源 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation ShopAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self.view addSubview:self.tableview];
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"商家地址";
    
}

- (NSArray *)dataArray {

    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (UITableView *)tableview {

    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview registerClass:[AddrsssTableViewCell class] forCellReuseIdentifier:indenifer];
    }
    return  _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 113;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AddrsssTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indenifer];
    cell.backgroundColor = [UIColor whiteColor];
    
    cell.editBtnBlock = ^(){
    
        EditNewAddressViewController * editVC = [[EditNewAddressViewController alloc] init];
        
        [self.navigationController pushViewController:editVC animated:YES];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];

    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] init];
    
    [rightBar setImage:[UIImage imageNamed:@"添加"]];
    self.navigationItem.rightBarButtonItem = rightBar;
    
}

- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAddress {


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
