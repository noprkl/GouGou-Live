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

#import "SingleChatViewController.h"
#import "SellerAcceptedRateViewController.h"
#import "SellerChangeViewController.h"

#import "SellerOrderDetailModel.h"
#import "SellerAdressModel.h"
#import "SellerSendAlertView.h"

@interface SellerOrderDetailAdressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */

@property(nonatomic, strong) SellerOrderDetailStateView *stateView; /**< 状态view */

@property(nonatomic, strong) SellerOrderDetailModel *orderInfo; /**< 订单信息 */

@end

@implementation SellerOrderDetailAdressViewController

- (void)getRequestOrderDetail {
    NSDictionary * dict = @{@"id":_orderID};
    DLog(@"%@", dict);
    [self showHudInView:self.view hint:@"加载中"];

    [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.orderInfo = [SellerOrderDetailModel mj_objectWithKeyValues:successJson[@"data"]];
        [self.tableView reloadData];
        [self hideHud];
    } error:^(NSError *error) {
        DLog(@"%@",error);
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
}
- (void)setModel:(SellerOrderModel *)model {
    _model = model;
    self.stateView.noteStr = model.comment;
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
        _bottomView.btnTitles = self.bottomBtns;

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

    return 5;
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
        // 设置订单状态
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
            state = @"待评价";
        }else if ([self.orderInfo.status isEqualToString:@"10"]) {
            state = @"已评价";
        }else if ([self.orderInfo.status isEqualToString:@"20"]) {
            state = @"订单取消";
        }
        stateView.stateMessage = state;

        stateView.noteStr = [NSString stringFromDateString:self.orderInfo.closeTime];
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
        SellerAdressModel *model = [[SellerAdressModel alloc] init];
        model.merchantName = self.orderInfo.buyUserName;
        model.merchantTel = self.orderInfo.buyUserTel;
        model.merchantProvince = self.orderInfo.recevieProvince;
        model.merchantCity = self.orderInfo.recevieCity;
        model.merchantDistrict = self.orderInfo.recevieDistrict;
        model.merchantAddress = self.orderInfo.recevieAddress;
        
        adressView.sellerAdress = model;
        adressView.isHid = YES;
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
        // 商品总价
        priceView.allPriceCount.text = [NSString stringWithFormat:@"%.2lf", [self.orderInfo.productPrice floatValue] + [self.orderInfo.traficFee floatValue]];
        // 优惠价格
        if ([self.orderInfo.status isEqualToString:@"7"]) {
            priceView.favorablePriceCount.text = [NSString stringWithFormat:@"%.2lf", [self.orderInfo.price floatValue] + [self.orderInfo.traficFee floatValue] - [self.orderInfo.traficRealFee floatValue] - [self.orderInfo.productRealDeposit floatValue] - [self.orderInfo.productRealBalance floatValue]- [self.orderInfo.productRealPrice floatValue]];
        }else{
            priceView.favorablePriceCount.text = @"0.00";
        }
        priceView.realPriceCount.text = [NSString stringWithFormat:@"%.2lf", [self.orderInfo.productRealBalance floatValue] + [self.orderInfo.productRealDeposit floatValue] + [self.orderInfo.traficRealFee floatValue] + [self.orderInfo.productRealPrice floatValue]];
        priceView.templatePriceCount.text = self.orderInfo.traficRealFee.length != 0 ?self.orderInfo.traficRealFee:@"0";
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
        
        orderInfoView.orderCodeNumber.text = self.orderInfo.orderId;
        
        if (![self.orderInfo.createTime isEqualToString:@"0"]) {
            orderInfoView.createTime.text = [NSString stringFromDateString:self.orderInfo.createTime];
        }else{
            orderInfoView.createTime.text = @"***";
        }
        
        if (![self.orderInfo.depositTime isEqualToString:@"0"]) {
            orderInfoView.depositTime.text = [NSString stringFromDateString:self.orderInfo.depositTime];
        }else{
            orderInfoView.depositTime.text = @"***";
        }
        
        if (![self.orderInfo.balanceTime isEqualToString:@"0"]) {
            orderInfoView.finalMoneyTime.text = [NSString stringFromDateString:self.orderInfo.balanceTime];
        }else{
            orderInfoView.finalMoneyTime.text = @"***";
        }
        
        if (![self.orderInfo.deliveryTime isEqualToString:@"0"]) {
            orderInfoView.sendTime.text = [NSString stringFromDateString:self.orderInfo.deliveryTime];
        }else{
            orderInfoView.sendTime.text = @"***";
        }

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
       
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:self.orderInfo.buyUserId conversationType:(EMConversationTypeChat)];
        viewController.title = self.orderInfo.buyUserId;
         viewController.chatID = self.orderInfo.buyUserId;
        viewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:viewController animated:YES];
        
    }else if ([title isEqualToString:@"修改运费"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.orderID = self.orderID;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"修改价格"]){
        SellerChangeViewController *changeVC = [[SellerChangeViewController alloc] init];
        changeVC.title = title;
        changeVC.orderID = self.orderID;
        changeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:changeVC animated:YES];
    }else if ([title isEqualToString:@"发货"]){
        
        SellerSendAlertView *sendView = [[SellerSendAlertView alloc] init];
        
        sendView.orderID = self.orderID;
        __weak typeof(sendView) weakSend = sendView;

        sendView.commitBlock = ^(NSString *shipStyle, NSString *shipOrder){
            // 送货请求，如果成功返回YES 失败返回NO
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"id":self.orderID,
                                   @"waybill_number":shipOrder, // 运单号
                                   @"transportation":shipStyle
                                   };
            [self getRequestWithPath:API_Delivery params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
                weakSend.successNote.hidden = NO;
                if ([successJson[@"code"] intValue] == 1) {
                    weakSend.successNote.text = @"订单发货成功";
                    [weakSend dismiss];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    weakSend.successNote.text = @"订单发货失败";
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        [sendView show];
        
    }else if ([title isEqualToString:@"查看评价"]){
        
        SellerAcceptedRateViewController *rateVC = [[SellerAcceptedRateViewController alloc] init];
        rateVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rateVC animated:YES];
    }else if ([title isEqualToString:@"未评价"]){
        DLog(@"%@", title);
    }else if ([title isEqualToString:@"查看详情"]){
        
    }else if ([title isEqualToString:@"在线客服"]){
        [self clickServiceBtnAction];
    }
}

@end
