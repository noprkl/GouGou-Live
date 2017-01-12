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

#import "SingleChatViewController.h"
#import "SellerAcceptedRateViewController.h"
#import "SellerChangeViewController.h"
#import "SellerProtectDetailModel.h"
#import "SellerSendAlertView.h"

@interface SellerOrderDetailProtectPowerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */
@property(nonatomic, strong) SellerProtectDetailModel *orderInfo; /**< 订单信息 */

@end

static NSString *cellid = @"SellerOrderDetailProtectPowerCell";

@implementation SellerOrderDetailProtectPowerViewController
#pragma mark - 网络请求
- (void)getProtectPowerRequest {
    
    NSDictionary * dict = @{@"id":_orderID
                            };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Activist_limit params:dict success:^(id successJson) {
        DLog(@"%@",successJson);        
        NSArray *arr = [SellerProtectDetailModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        self.orderInfo = [arr lastObject];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getProtectPowerRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    self.title = @"维权详情";
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    switch (indexPath.row) {
        case 0:
        {
            static NSString *cellid = @"cellid0";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerProtectPowerStateView *stateView = [[SellerProtectPowerStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            if ([self.orderInfo.statusWq integerValue] == 1) {
                stateView.stateMessage = @"维权中";
            }else  if ([self.orderInfo.statusWq integerValue] == 2) {
                stateView.stateMessage = @"维权成功";
            }else  if ([self.orderInfo.statusWq integerValue] == 3) {
                stateView.stateMessage = @"维权失败";
            }
        NSString *state = @"";
        if ([self.orderInfo.status integerValue] == 3) {
            state = @"待付尾款";
            NSString *date = [NSString stringFromDateString:self.orderInfo.deposittime];
            state = [NSString stringWithFormat:@"买家于%@付定金,未付尾款", date];
            
        }else if ([self.orderInfo.status integerValue] == 7) {
            state = @"待发货";
            NSString *date;
            if ([self.orderInfo.balancetime integerValue] > 0) {
                date = [NSString stringFromDateString:self.orderInfo.balancetime];

            }else{
                if ( [self.orderInfo.fullTime integerValue] > 0){
                    date = [NSString stringFromDateString:self.orderInfo.fullTime];
                }
            }
                state = [NSString stringWithFormat:@"买家于%@付清款,未发货", date];
            
        }else if ([self.orderInfo.status integerValue] == 8) {
            
            NSString *date = [NSString stringFromDateString:self.orderInfo.deliverytime];
            state = [NSString stringWithFormat:@"卖家于%@发货,未收货", date];
        }else if ([self.orderInfo.status integerValue] == 9) {
            state = @"待评价";
            NSString *date = [NSString stringFromDateString:self.orderInfo.confirmTime];
            state = [NSString stringWithFormat:@"卖家于%@收货,未评价", date];
            
        }else if ([self.orderInfo.status integerValue] == 10) {
            state = @"已评价"; // 评价时间
            NSString *date = [NSString stringFromDateString:self.orderInfo.deliverytime];
            state = [NSString stringWithFormat:@"卖家于%@评价,订单已完成", date];
        }
            stateView.noteStr = state;
            [cell.contentView addSubview:stateView];
            return cell;
        }
            break;
        case 1:
        {
            static NSString *cellid = @"cellid1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerProtectPLogisticsInfoView *logisticsInfoView = [[SellerProtectPLogisticsInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
            if (self.orderInfo.waybillNumber.length == 0) {
                logisticsInfoView.orderCode = @"";
                logisticsInfoView.orderStyle = @"未发货";
            }else{
                logisticsInfoView.orderCode = self.orderInfo.waybillNumber;
                logisticsInfoView.orderStyle = self.orderInfo.transportation;
            }
            [cell.contentView addSubview:logisticsInfoView];
            return cell;
        }
            break;
        case 2:
        {
            static NSString *cellid = @"cellid2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            backView.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 44)];
            label.text = [NSString stringWithFormat:@"买家名称：%@", self.orderInfo.userName];
            label.font = [UIFont systemFontOfSize:16];
            [backView addSubview:label];

            [cell.contentView addSubview:backView];
            return cell;

        }
            break;
        case 3:
        {
            static NSString *cellid = @"cellid3";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        case 4:
        {
            static NSString *cellid = @"cellid4";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerOrderDetailMorePriceView *morePriceView = [[SellerOrderDetailMorePriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        // 商品总价
        morePriceView.allPriceCount.text = [NSString stringWithFormat:@"%.2lf", [self.orderInfo.price floatValue] + [self.orderInfo.traficRealFee floatValue]];
        // 优惠价格
        morePriceView.favorablePriceCount.text = [NSString stringWithFormat:@"%.2lf", [self.orderInfo.price floatValue] + [self.orderInfo.traficFee floatValue] - [self.orderInfo.traficRealFee floatValue] - [self.orderInfo.productRealDeposit floatValue] - [self.orderInfo.productRealBalance floatValue]- [self.orderInfo.productRealPrice floatValue]];
        
        morePriceView.realPriceCount.text = [NSString stringWithFormat:@"%.2lf", [self.orderInfo.productRealBalance floatValue] + [self.orderInfo.productRealDeposit floatValue] + [self.orderInfo.traficRealFee floatValue] + [self.orderInfo.productRealPrice floatValue]];
        // 运费
        morePriceView.templatePriceCount.text = self.orderInfo.traficRealFee.length != 0 ?self.orderInfo.traficRealFee:@"0";
        // 尾款
        morePriceView.finalMoneyCount.text = self.orderInfo.productRealBalance.length !=0 ?self.orderInfo.productRealBalance:@"0";
        // 定金
        morePriceView.depositCount.text = self.orderInfo.productRealDeposit.length !=0 ? self.orderInfo.productRealDeposit:@"0";

            [cell.contentView addSubview:morePriceView];
            return cell;

        }
            break;
        case 5:
        {
            static NSString *cellid = @"cellid5";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            NSArray *imsArr = [self.orderInfo.photoPath componentsSeparatedByString:@"|"];
            DogImageView *imageV = [[DogImageView alloc] init];
            CGFloat height = [imageV getCellHeightWithImages:imsArr];

            SellerProtectApplyRefundView *applyRefundView = [[SellerProtectApplyRefundView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH , height + 90)];
            applyRefundView.pictureArr = imsArr;
            if (self.orderInfo.money.length == 0) {
                applyRefundView.applyRefundCount.text = @"未申请赔偿";
            }else{
                applyRefundView.applyRefundCount.text = self.orderInfo.money;
            }

            applyRefundView.reasonLabel.text = self.orderInfo.comment;
            [cell.contentView addSubview:applyRefundView];
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
            return 54;
            break;
        case 3:
            return 108;
            break;
        case 4:
            return 300;
            break;
        case 5:
        {
            NSArray *imsArr = [self.orderInfo.photoPath componentsSeparatedByString:@"|"];
            DogImageView *imageV = [[DogImageView alloc] init];
            CGFloat height = [imageV getCellHeightWithImages:imsArr];
            return height + 115;
        }

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
        // 跳转至买家
        NSString *chatId = self.orderInfo.buyUserId;
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:chatId conversationType:(EMConversationTypeChat)];
        viewController.title = chatId;
         viewController.chatID = chatId;
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
