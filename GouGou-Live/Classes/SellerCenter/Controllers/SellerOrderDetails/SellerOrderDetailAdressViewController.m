//
//  SellerOrderDetailAdressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailAdressViewController.h"
#import "SellerOrderDetailStateView.h" // 状态view
#import "ChosedAdressView.h" // 地址信息
#import "SellerDogCardView.h" // 狗狗信息
#import "SellerOrderDetailPriceView.h" // 价格信息
#import "SellerOrderDetailInfoView.h" // 订单信息
#import "SellerOrderDetailNoteView.h" // 备注
#import "SellerOrderDetailBottomView.h" // 底部按钮


#import "TalkingToOneViewController.h"
#import "SellerAcceptedRateViewController.h"

@interface SellerOrderDetailAdressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */

@property(nonatomic, strong) SellerOrderDetailStateView *stateView; /**< 状态view */

@end

@implementation SellerOrderDetailAdressViewController
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.equalTo(49);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.top);
    }];
}
- (void)setOrderState:(NSString *)orderState {
    _orderState = orderState;
    self.stateView.stateMessage = orderState;
}
- (void)setBottomBtns:(NSArray *)bottomBtns {
    _bottomBtns = bottomBtns;
    self.bottomView.btnTitles = bottomBtns;
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        
    }
    return _tableView;
}
- (SellerOrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerOrderDetailBottomView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
      
        __weak typeof(self) weakSelf = self;
        _bottomView.clickBlock = ^(NSString *btnTitle){
            
            [weakSelf clickBtnActionWithBtnTitle:btnTitle];
        };
    }
    return _bottomView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.row == 0) {
       static NSString *cellid = @"cellid1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        SellerOrderDetailStateView *stateView = [[SellerOrderDetailStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        self.stateView = stateView;
        stateView.stateMessage = self.orderState;
        // 订单信息
        [cell.contentView addSubview:stateView];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *cellid = @"cellid2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        ChosedAdressView *adressView = [[ChosedAdressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
        [cell.contentView addSubview:adressView];
        return cell;

    }else if (indexPath.row == 2){
        static NSString *cellid = @"cellid3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        SellerDogCardView *dogCardView = [[SellerDogCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
        [cell.contentView addSubview:dogCardView];
        return cell;

    }else if (indexPath.row == 3){
        static NSString *cellid = @"cellid4";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        SellerOrderDetailPriceView *priceView = [[SellerOrderDetailPriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        [cell.contentView addSubview:priceView];
        return cell;

    }else if (indexPath.row == 4){
        static NSString *cellid = @"cellid5";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        SellerOrderDetailInfoView *orderInfoView = [[SellerOrderDetailInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 127)];
        [cell.contentView addSubview:orderInfoView];
        return cell;

    }else if (indexPath.row == 5){
        static NSString *cellid = @"cellid6";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

        SellerOrderDetailNoteView *noteView = [[SellerOrderDetailNoteView alloc] initWithFrame:CGRectMake(kDogImageWidth, 0, 356 , 80)];
        [cell.contentView addSubview:noteView];
        return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    switch (indexPath.row) {
        case 0:
            return 54;
            break;
        case 1:
            return 98;
            break;
        case 2:
            return 108;
            break;
        case 3:
            return 210;
            break;
        case 4:
            return 137;
            break;
        case 5:
            return 90;
            break;
        default:
            break;
    }
    
    return 0;
}

#pragma mark
#pragma mark - 点击按钮Action
- (void)clickBtnActionWithBtnTitle:(NSString *)title {
    
    
    if ([title isEqualToString:@"联系买家"]) {
        TalkingToOneViewController *talkVC = [[TalkingToOneViewController alloc] init];
        talkVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:talkVC animated:YES];
        
    }else if ([title isEqualToString:@"修改运费"]){
        
    }else if ([title isEqualToString:@"修改价格"]){

    }else if ([title isEqualToString:@"发货"]){
        
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
