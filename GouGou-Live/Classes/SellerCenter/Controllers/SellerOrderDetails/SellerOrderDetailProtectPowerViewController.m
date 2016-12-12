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
#import "SellerSendViewController.h"
#import "SellerProtectModel.h"

@interface SellerOrderDetailProtectPowerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */

@property(nonatomic, strong) SellerProtectModel *orderInfo; /**< 订单信息 */

@end

static NSString *cellid = @"SellerOrderDetailProtectPowerCell";

@implementation SellerOrderDetailProtectPowerViewController
#pragma mark - 网络请求
- (void)getProtectPowerRequest {
    
    NSDictionary * dict = @{@"user_id":@(TestID),
                            @"page":@(1),
                            @"pageSize":@(10)
                            };
    
    [self getRequestWithPath:API_Activist params:dict success:^(id successJson) {
        
        self.orderInfo = [SellerProtectModel mj_objectWithKeyValues:successJson[@"data"][@"info"]];
        
        [self.tableView reloadData];
        DLog(@"%@",successJson[@"data"]);
        
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
}

#pragma mark
#pragma mark - 生命周期
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
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerProtectPowerStateView *stateView = [[SellerProtectPowerStateView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            if ([self.orderInfo.status intValue] == 1) {
                stateView.stateMessage = @"维权中";
            }else  if ([self.orderInfo.status intValue] == 2) {
                stateView.stateMessage = @"维权成功";
            }else  if ([self.orderInfo.status intValue] == 3) {
                stateView.stateMessage = @"维权失败";
            }
            stateView.noteStr = self.orderInfo.closeTime;
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
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerProtectPLogisticsInfoView *logisticsInfoView = [[SellerProtectPLogisticsInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
            [cell.contentView addSubview:logisticsInfoView];
            return cell;

        }
            break;
        case 2:
        {
            static NSString *cellid = @"cellid2";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            backView.backgroundColor = [UIColor whiteColor];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 44)];
            label.text = [NSString stringWithFormat:@"买家名称：%@", self.orderInfo.userNickName];
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
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerOrderDetailMorePriceView *morePriceView = [[SellerOrderDetailMorePriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
            morePriceView.allPriceCount.text = self.orderInfo.priceOld;
            morePriceView.favorablePriceCount.text = self.orderInfo.price;
            morePriceView.realPriceCount.text = [NSString stringWithFormat:@"%d", [self.orderInfo.priceOld intValue] - [self.orderInfo.price intValue]];
            morePriceView.templatePriceCount.text = self.orderInfo.traficRealFee;
            morePriceView.finalMoneyCount.text = self.orderInfo.productRealBalance;
            morePriceView.depositCount.text = self.orderInfo.productRealDeposit;
            
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
            }            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            
            SellerProtectApplyRefundView *applyRefundView = [[SellerProtectApplyRefundView alloc] initWithFrame:CGRectMake(kDogImageWidth, 0, 356 , 200)];
            
            NSArray *imsArr = [self.orderInfo.photoPath componentsSeparatedByString:@","];
            applyRefundView.pictureArr = imsArr;
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
        SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
        viewController.title = EaseTest_Chat1;
         viewController.chatID = EaseTest_Chat3;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
