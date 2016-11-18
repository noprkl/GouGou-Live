//
//  SellerWaitPayViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitPayViewController.h"
#import "SellerWaitPayCell.h"

@interface SellerWaitPayViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSMutableArray *btnTitles; /**< 按钮数组 */

@property(nonatomic, strong) NSMutableArray *states; /**< 状态数组 */

@end

static NSString *cellid = @"SellerWaitPayCell";

@implementation SellerWaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    
    [self.view addSubview:self.tableView];
    
}
#pragma mark
#pragma mark - 懒加载
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 62) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerWaitPayCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

    if (indexPath.row == 0) {
        cell.orderState = @"待付尾款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.costMessage = @[@"尾款：950"];
       
//        [self.btnTitles addObject:cell.btnTitles];
//        [self.states addObject:cell.orderState];
    }else if (indexPath.row == 1){
        cell.orderState = @"待付全款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
        cell.costMessage = @[@"已付定金：500", @"尾款：950"];

//        [self.btnTitles addObject:cell.btnTitles];
//        [self.states addObject:cell.orderState];
    }else if (indexPath.row == 2){
        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
        cell.costMessage = @[@"定金：500", @"尾款：950"];

//        [self.btnTitles addObject:cell.btnTitles];
//        [self.states addObject:cell.orderState];
    }
    [self.btnTitles addObject:cell.btnTitles];
    [self.states addObject:cell.orderState];
    __weak typeof(self) weakSelf = self;

    cell.clickBtnBlock = ^(NSString *btnText){
        [weakSelf clickBtnActionWithBtnTitle:btnText];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 245;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SellerOrderDetailAdressViewController *adressVC = [[SellerOrderDetailAdressViewController alloc] init];
    adressVC.hidesBottomBarWhenPushed = YES;
    adressVC.bottomBtns = self.btnTitles[indexPath.row];
    adressVC.orderState = self.states[indexPath.row];
    [self.navigationController pushViewController:adressVC animated:YES];
}
#pragma mark
#pragma mark - 点击按钮Action
- (void)clickBtnActionWithBtnTitle:(NSString *)title {
    
    
    if ([title isEqualToString:@"联系买家"]) {
        TalkingToOneViewController *talkVC = [[TalkingToOneViewController alloc] init];
        talkVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:talkVC animated:YES];
        
    }else if ([title isEqualToString:@"修改运费"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.changeStyle = title;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"修改价格"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.changeStyle = title;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"发货"]){
        
        SellerSendViewController *sendVC = [[SellerSendViewController alloc] init];
        sendVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:sendVC animated:YES];
        
    }else if ([title isEqualToString:@"查看评价"]){
        
        SellerAcceptedRateViewController *rateVC = [[SellerAcceptedRateViewController alloc] init];
        rateVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rateVC animated:YES];
    }else if ([title isEqualToString:@"未评价"]){
        DLog(@"%@", title);
    }else if ([title isEqualToString:@"查看详情"]){
        
    }else if ([title isEqualToString:@"在线客服"]){
        TalkingToOneViewController *talkVC = [[TalkingToOneViewController alloc] init];
        talkVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:talkVC animated:YES];
    }
}

@end
