//
//  SellerOrderDetailLogisticsInfoViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerOrderDetailLogisticsInfoViewController.h"

#import "SellerOrderDetailStateView.h" // 状态view
#import "SellerLogisticsInfoView.h" // 物流信息
#import "SellerDogCardView.h" // 狗狗信息
#import "SellerOrderDetailMorePriceView.h" // 价格信息
#import "SellerOrderDetailInfoView.h" // 订单信息

#import "SingleChatViewController.h"
#import "SellerAcceptedRateViewController.h"
#import "SellerChangeViewController.h"
#import "SellerSendViewController.h"

#import "OrderDetailModel.h"

@interface SellerOrderDetailLogisticsInfoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UIView *bottomView; /**< 底部按钮 */

@property(nonatomic, strong) UIButton *callBuyer; /**< 联系买家 */

@property(nonatomic, strong) OrderDetailModel *orderInfo; /**< 订单信息 */

@end
static NSString *cellid = @"SellerOrderDetailLogisticsInfo";

@implementation SellerOrderDetailLogisticsInfoViewController
- (void)getRequestOrderDetail {
    NSDictionary *dict = @{
                           @"id":@([_orderID intValue])
                           };
    
    [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.orderInfo = [OrderDetailModel mj_objectWithKeyValues:successJson[@"data"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestOrderDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    
    self.title = @"订单详情";
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.callBuyer];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.equalTo(49);
    }];
    [self.callBuyer makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView.right);
        make.centerY.equalTo(self.bottomView.centerY);
        make.size.equalTo(CGSizeMake(125, 49));
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.width.equalTo(self.view);
        make.bottom.equalTo(self.bottomView.top);
    }];
    
}
- (void)setOrderState:(NSString *)orderState {
    _orderState = orderState;
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
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
- (UIButton *)callBuyer {
    if (!_callBuyer) {
        _callBuyer = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_callBuyer setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _callBuyer.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_callBuyer setTitle:@"联系买家" forState:(UIControlStateNormal)];
        _callBuyer.titleLabel.font = [UIFont systemFontOfSize:16];
        [_callBuyer addTarget:self action:@selector(clickCallBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _callBuyer;
}
- (void)clickCallBtnAction {
    // 跳转至买家
    SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
    viewController.title = EaseTest_Chat2;
     viewController.chatID = EaseTest_Chat3;
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *cellid = @"cellid1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

            SellerOrderDetailStateView *stateView = [[SellerOrderDetailStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            // 订单信息
            stateView.stateMessage = self.orderState;
        stateView.noteStr = [NSString stringFromDateString:self.orderInfo.createTime];
        NSString *state = @"";
        
        if ([self.orderInfo.status isEqualToString:@"1"]) {
            state = @"待付款";
        }else if ([self.orderInfo.status isEqualToString:@"2"]) {
            state = @"待付定金";
        }else if ([self.orderInfo.status isEqualToString:@"3"]) {
            state = @"待付尾款";
        }else if ([self.orderInfo.status isEqualToString:@"4"]) {
            state = @"";
        }else if ([self.orderInfo.status isEqualToString:@"5"]) {
            state = @"待付全款";
        }else if ([self.orderInfo.status isEqualToString:@"6"]) {
            state = @"";
        }else if ([self.orderInfo.status isEqualToString:@"7"]) {
            state = @"待发货";
        }else if ([self.orderInfo.status isEqualToString:@"8"]) {
            state = @"待收货";
        }else if ([self.orderInfo.status isEqualToString:@"9"]) {
            state = @"已评价";
        }else if ([self.orderInfo.status isEqualToString:@"10"]) {
            state = @"待评价";
        }else if ([self.orderInfo.status isEqualToString:@"20"]) {
            state = @"订单取消";
        }
        stateView.stateMessage = state;
            [cell.contentView addSubview:stateView];
            return cell;

        }
            break;
        case 1:
        {
            static NSString *cellid = @"cellid2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

            SellerLogisticsInfoView *logisticsView = [[SellerLogisticsInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
            
            [cell.contentView addSubview:logisticsView];
            return cell;

        }
            break;
        case 2:
        {
            static NSString *cellid = @"cellid3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

            SellerDogCardView *dogCardView = [[SellerDogCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
            if (self.orderInfo.pathSmall != NULL) {
                NSString *urlString = [IMAGE_HOST stringByAppendingString:self.orderInfo.pathSmall];
                [dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
            }
            
            dogCardView.dogNameLabel.text = self.orderInfo.name;
            dogCardView.dogKindLabel.text = self.orderInfo.kindName;
            dogCardView.dogAgeLabel.text = self.orderInfo.ageName;
            dogCardView.dogSizeLabel.text = self.orderInfo.sizeName;
            dogCardView.dogColorLabel.text = self.orderInfo.colorName;
            dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:[NSString stringWithFormat:@"￥%@", self.orderInfo.priceOld]];
            dogCardView.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@", self.orderInfo.price];

            [cell.contentView addSubview:dogCardView];
            return cell;

        }
            break;
        case 3:
        {
            static NSString *cellid = @"cellid4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

            SellerOrderDetailMorePriceView *morePriceView = [[SellerOrderDetailMorePriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
            morePriceView.allPriceCount.text = self.orderInfo.priceOld;
            morePriceView.favorablePriceCount.text = self.orderInfo.price;
            morePriceView.realPriceCount.text = [NSString stringWithFormat:@"%d", [self.orderInfo.priceOld intValue] - [self.orderInfo.price intValue]];
            morePriceView.templatePriceCount.text = self.orderInfo.traficRealFee;
            morePriceView.finalMoneyCount.text = self.orderInfo.productBalance;
            morePriceView.depositCount.text = self.orderInfo.productDeposit;
            
            [cell.contentView addSubview:morePriceView];
            return cell;

        }
            break;
        case 4:
        {
            static NSString *cellid = @"cellid5";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

            SellerOrderDetailInfoView *orderInfoView = [[SellerOrderDetailInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 127)];
            orderInfoView.orderCodeNumber.text = self.orderInfo.createTime;
            
            orderInfoView.createTime.text = self.orderInfo.createTime;
            
            orderInfoView.depositTime.text = self.orderInfo.depositTime;
            
            orderInfoView.finalMoneyTime.text = self.orderInfo.balanceTime;
            [cell.contentView addSubview:orderInfoView];
            return cell;

        }
            break;
            
        default:
            break;
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
            return 310;
            break;
        case 4:
            return 137;
            break;
        default:
            break;
    }
    
    return 230;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
}
#pragma mark
#pragma mark - 点击按钮Action
- (void)clickBtnActionWithBtnTitle:(NSString *)title {
    
    
    if ([title isEqualToString:@"联系买家"]) {
        // 跳转至买家
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat2 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat2;
         viewController.chatID = EaseTest_Chat3;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if ([title isEqualToString:@"修改运费"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"修改价格"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
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
        // 跳转至买家
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat1;
         viewController.chatID = EaseTest_Chat3;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];   }
}
@end
