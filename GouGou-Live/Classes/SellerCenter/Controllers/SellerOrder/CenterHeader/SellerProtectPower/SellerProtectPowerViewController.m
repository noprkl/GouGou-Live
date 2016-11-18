//
//  SellerProtectPowerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerProtectPowerViewController.h"
#import "SellerProtectPowerCell.h"


@interface SellerProtectPowerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SellerProtectPowerCell";

@implementation SellerProtectPowerViewController

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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 62) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerProtectPowerCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerProtectPowerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            cell.orderState = @"维权成功";

        }else if (indexPath.row == 1){
            cell.orderState = @"维权中";
        }else if (indexPath.row == 2){
            cell.orderState = @"维权失败";
        }
    cell.costMessage = @[@"已付全款：¥ 950"];

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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
}
- (void)clickBtnActionWithBtnTitle:(NSString *)title {

    if ([title isEqualToString:@"联系买家"]) {
        TalkingToOneViewController *talkVC = [[TalkingToOneViewController alloc] init];
        talkVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:talkVC animated:YES];
        
    }else if ([title isEqualToString:@"查看详情"]){
        SellerOrderDetailProtectPowerViewController *orderPPVC = [[SellerOrderDetailProtectPowerViewController alloc] init];
        orderPPVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderPPVC animated:YES];
    }
}
@end
