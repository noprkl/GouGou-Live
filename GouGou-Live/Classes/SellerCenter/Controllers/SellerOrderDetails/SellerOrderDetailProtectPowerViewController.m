//
//  SellerOrderDetailProtectPowerViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailProtectPowerViewController.h"

#import "SellerProtectPowerStateView.h" // 状态view
#import "SellerProtectPLogisticsInfoView.h" // 物流信息
#import "SellerProtectApplyRefundView.h" // 申请退款信息

#import "SellerDogCardView.h" // 狗狗信息
#import "SellerOrderDetailMorePriceView.h" // 价格信息

#import "SellerOrderDetailBottomView.h" // 底部按钮

#import "TalkingToOneViewController.h"
#import "SellerAcceptedRateViewController.h"


@interface SellerOrderDetailProtectPowerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */

@end

static NSString *cellid = @"SellerOrderDetailProtectPowerCell";

@implementation SellerOrderDetailProtectPowerViewController
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
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (SellerOrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerOrderDetailBottomView alloc] init];
        _bottomView.btnTitles = @[@"联系买家"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    cell.selected = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
        {
            SellerProtectPowerStateView *stateView = [[SellerProtectPowerStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            [cell.contentView addSubview:stateView];
        }
            break;
        case 1:
        {
            SellerProtectPLogisticsInfoView *logisticsInfoView = [[SellerProtectPLogisticsInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
            [cell.contentView addSubview:logisticsInfoView];
        }
            break;
        case 2:
        {
           
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            backView.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 44)];
            label.text = @"买家昵称：慧摩尔";
            label.font = [UIFont systemFontOfSize:16];
           
            [backView addSubview:label];
            [cell.contentView addSubview:backView];

        }
            break;
        case 3:
        {
            SellerDogCardView *dogCardView = [[SellerDogCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
            [cell.contentView addSubview:dogCardView];
        }
            break;
        case 4:
        {
            SellerOrderDetailMorePriceView *morePriceView = [[SellerOrderDetailMorePriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
            [cell.contentView addSubview:morePriceView];
        }
            break;
        case 5:
        {
            SellerProtectApplyRefundView *applyRefundView = [[SellerProtectApplyRefundView alloc] initWithFrame:CGRectMake(kDogImageWidth, 0, 356 , 200)];
            [cell.contentView addSubview:applyRefundView];
        }
            break;
            
        default:
            break;
    }
    return cell;
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
            return 54;
            break;
        case 3:
            return 108;
            break;
        case 4:
            return 300;
            break;
        case 5:
            return 210;
            break;
        default:
            break;
    }
    
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
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
        DLog(@"%@", title);
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
