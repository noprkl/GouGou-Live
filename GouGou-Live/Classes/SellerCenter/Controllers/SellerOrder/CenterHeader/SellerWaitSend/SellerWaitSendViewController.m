//
//  SellerWaitSendViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitSendViewController.h"
#import "SellerWaitSendCell.h"

@interface SellerWaitSendViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SellerWaitSendCell";

@implementation SellerWaitSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerWaitSendCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerWaitSendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.orderState = @"待发货";
    cell.btnTitles = @[@"联系买家", @"发货"];
//    if (indexPath.row == 0) {
//        cell.orderState = @"待发货";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
//    }else if (indexPath.row == 1){
//        cell.orderState = @"待付全款";
//        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
//    }else if (indexPath.row == 2){
//        cell.orderState = @"待付定金";
//        cell.btnTitles = @[@"联系买家"];
//    }
    cell.clickBtnBlock = ^(NSString *btnText){
        DLog(@"%@", btnText);
    };
    

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 245;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
}
@end
