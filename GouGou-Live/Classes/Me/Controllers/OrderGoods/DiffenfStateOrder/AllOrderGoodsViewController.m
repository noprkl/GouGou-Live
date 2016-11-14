//
//  AllOrderGoodsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AllOrderGoodsViewController.h"

#import "TopButonView.h"
#import "AllOrderGoodsCell.h"
#import "FunctionButtonView.h"

static NSString * allGoodsCell = @"allGoodsCellID";

@interface AllOrderGoodsViewController ()<UITableViewDelegate,UITableViewDataSource>
///** 顶部View */
//@property (strong,nonatomic) TopButonView *topView;
/** tableView */
@property (strong,nonatomic) UITableView *tableview;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation AllOrderGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    

    [self.view addSubview:self.tableview];
    
        self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
}
#pragma mark
#pragma mark - 初始化
- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (UITableView *)tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[AllOrderGoodsCell class] forCellReuseIdentifier:allGoodsCell];
    }
    return _tableview;
}

#pragma mark
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 330;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AllOrderGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:allGoodsCell];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    FunctionButtonView * funcBtn = [[FunctionButtonView alloc] initWithFrame:CGRectMake(0, 289, SCREEN_WIDTH, 45) title:@[@"查看评价",@"申请维权",@"联系买家",@"删除订单"] buttonNum:4];
    [cell addSubview:funcBtn];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
