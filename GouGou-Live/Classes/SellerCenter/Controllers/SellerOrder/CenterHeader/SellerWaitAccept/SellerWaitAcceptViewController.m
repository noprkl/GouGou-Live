//
//  SellerWaitAcceptViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitAcceptViewController.h"
#import "SellerWaitAcceptCell.h"

@interface SellerWaitAcceptViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */
@property(nonatomic, strong) NSMutableArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSMutableArray *states; /**< 状态数组 */

@end

static NSString *cellid = @"SellerWaitAcceptCell";

@implementation SellerWaitAcceptViewController

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
- (NSMutableArray *)btnTitles {
    if (!_btnTitles) {
        _btnTitles = [NSMutableArray array];
    }
    return _btnTitles;
}
- (NSMutableArray *)states {
    if (!_states) {
        _states = [NSMutableArray array];
    }
    return _states;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerWaitAcceptCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerWaitAcceptCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

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
    cell.btnTitles = @[@"联系买家"];
    cell.costMessage = @[@"已付全款：1450"];
    
    [self.btnTitles addObject:cell.btnTitles];

    __weak typeof(self) weakSelf = self;
    cell.clickBtnBlock = ^(NSString *btnText){
        [weakSelf clickBtnActionWithBtnTitle:btnText];
    };
    cell.editBlock = ^(){
        DLog(@"编辑");
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 330;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    SellerOrderDetailLogisticsInfoViewController *logisticsInfoVC = [[SellerOrderDetailLogisticsInfoViewController alloc] init];
    logisticsInfoVC.orderState = @"已完成";

    logisticsInfoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:logisticsInfoVC animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}


@end
