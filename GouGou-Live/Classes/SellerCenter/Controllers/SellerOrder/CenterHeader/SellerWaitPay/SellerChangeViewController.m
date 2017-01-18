//
//  SellerChangeViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerChangeViewController.h"
#import "PromptView.h" // 弹窗
#import "SellerChangeShipCostView.h" // 修改运费
#import "SellerChangePriceAlertView.h" // 修改价格
#import "ForgetPayPsdViewController.h"// 忘记支付密码
#import "SellerSendAlertView.h"// 发货

#import "SellerNickNameView.h"
#import "SellerDogCardView.h"
#import "SellerCostView.h"
#import "ChosedAdressView.h"
#import "SellerChangePayView.h"

#import "SellerOrderDetailModel.h"

#import "NSString+MD5Code.h"
#import "SellerAdressModel.h"

@interface SellerChangeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UIButton *sureBtn; /**< 确认按钮 */

@property(nonatomic, strong) NSString *nowCost; /**< 新的值 */

@property(nonatomic, strong) NSString *changeStyle; /**< 修改方式 */

@property(nonatomic, strong) SellerOrderDetailModel *orderInfo; /**< 订单信息 */

@end

static NSString *cellid = @"SellerAcceptRateCell";

@implementation SellerChangeViewController
- (void)getRequestOrderDetail {
    NSDictionary *dict = @{
                           @"id":_orderID
                           };
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.orderInfo = [SellerOrderDetailModel mj_objectWithKeyValues:successJson[@"data"]];
        [self.tableView reloadData];
        [self hideHud];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 进来加载视图
    [self initUI];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    // 弹窗
    [self showAlertView];
}

- (void)initUI{
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.sureBtn];
   
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.bottom.equalTo(self.sureBtn.top);
    }];
    self.changeStyle = self.title;
    
    [self getRequestOrderDetail];
    [self focusKeyboardShow];
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
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        
        [_sureBtn setTitle:@"确认修改" forState:(UIControlStateNormal)];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_sureBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        [_sureBtn addTarget:self action:@selector(clickSureBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureBtn;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.backgroundView = [[UIView alloc] init];
    cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
        {
            SellerNickNameView *nickView = [[SellerNickNameView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            
        // 设置订单状态
        NSString *state = @"";
        
        if ([self.orderInfo.status isEqualToString:@"2"]) {
            state = @"待付定金";
        }else if ([self.orderInfo.status isEqualToString:@"3"]) {
            state = @"待付尾款";
        }else if ([self.orderInfo.status isEqualToString:@"5"]) {
            state = @"待付全款";
        }
        nickView.stateMessage = state;
        
        nickView.dateLabel.text = [NSString stringFromDateString:self.orderInfo.closeTime];
        nickView.nickName.text = self.orderInfo.buyUserName;
            [cell.contentView addSubview:nickView];
//            return cell;
        }
            break;
        case 1:
        {
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
        }
            break;
        case 2:
        {
            SellerCostView *costView = [[SellerCostView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            costView.moneyMessage = self.orderInfo.productPrice;
            costView.freightMoney = self.orderInfo.traficFee;
        if ([self.orderInfo.status isEqualToString:@"2"]) {
            
            NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", self.orderInfo.productBalance];
            NSString *depositMoney = [NSString stringWithFormat:@"定金：￥%@", self.orderInfo.productDeposit];
            costView.messages = @[finalMoney, depositMoney];
        }else if ([self.orderInfo.status isEqualToString:@"3"]) {
            NSString *finalMoney = [NSString stringWithFormat:@"尾款：￥%@", self.orderInfo.productBalance];
            costView.messages = @[finalMoney];
        }else if ([self.orderInfo.status isEqualToString:@"5"]) {
            NSString *allMoney = [NSString stringWithFormat:@"全款：￥%@", self.orderInfo.productPrice];
            costView.messages = @[allMoney];
        }

            [cell.contentView addSubview:costView];

        }
            break;
        case 3:
        {
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
        }
            break;
        case 4:
        {
            SellerChangePayView *changePay = [[SellerChangePayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
        if ([self.orderInfo.status isEqualToString:@"2"]) {// 定金
            changePay.realMoney = self.orderInfo.productDeposit;
            changePay.realMoneyNote = @"实付定金";
            changePay.changeStyle = @"修改定金";
            changePay.price = self.orderInfo.productDeposit;
            changePay.oldPrice = self.orderInfo.priceOld;
            changePay.placeHolder = self.orderInfo.productDeposit;
        }else if ([self.orderInfo.status isEqualToString:@"3"]) {//尾款
            changePay.realMoney = self.orderInfo.productBalance;
            changePay.placeHolder = self.orderInfo.productBalance;
            changePay.price = self.orderInfo.productPrice;
            changePay.oldPrice = self.orderInfo.priceOld;
        }else if ([self.orderInfo.status isEqualToString:@"5"]) {// 全款
            changePay.realMoney = self.orderInfo.productPrice;
            changePay.realMoneyNote = @"实付金额";
            changePay.changeStyle = @"修改金额";
            changePay.price = self.orderInfo.productPrice;
            changePay.oldPrice = self.orderInfo.priceOld;
            changePay.placeHolder = self.orderInfo.productPrice;
        }

        changePay.editBlock = ^(NSString *cost){
            self.nowCost = cost;    
        };
            [cell.contentView addSubview:changePay];
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
            return 45;
            break;
        case 1:
            return 98;
            break;
        case 2:
            return 55;
            break;
        case 3:
            return 98;
            break;
        case 4:
            return 125;
            break;
        default:
            break;
    }
    return 230;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}
// 输入密码
- (void)showAlertView {
    // 封装蒙版的View
    __block  PromptView * prompt = [[PromptView alloc] initWithFrame:self.view.bounds];
    prompt.title = @"请输入交易密码";
    
    __weak typeof(self) weakself = self;
    // 点击提示框确认按钮请求支付密码
    __weak typeof(prompt) weakPrompt = prompt;
    prompt.clickSureBtnBlock = ^(NSString *text){
        
        // 验证密码
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                               @"pay_password":[NSString md5WithString:text]
                               };
        [self postRequestWithPath:API_Validation_pwd params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            weakPrompt.noteStr = successJson[@"message"];
            if ([successJson[@"message"] isEqualToString:@"验证成功"]) {
                // 密码成功
                [weakPrompt dismiss];
                [self showChangeCostAlert];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    };

    // 取消
    prompt.cancelBlock = ^(){
        [weakself.navigationController popViewControllerAnimated:YES];
        prompt = nil;
        [prompt dismiss];
        
    };
    // 忘记密码
    prompt.forgetBlock = ^(){
        ForgetPayPsdViewController *forgetVc = [[ForgetPayPsdViewController alloc] init];
        forgetVc.hidesBottomBarWhenPushed = YES;
        [weakself.navigationController pushViewController:forgetVc animated:YES];
    };
    // 显示蒙版
    [prompt show];
}
// 输入金钱
- (void)showChangeCostAlert {
    // 判断是哪一种修改 运费还是价格
    if ([self.changeStyle isEqualToString:@"修改运费"]) {
        SellerChangeShipCostView *costView = [[SellerChangeShipCostView alloc] init];
        costView.orderID = self.orderInfo.orderId;

        costView.commitBlock = ^(NSString *newCost){
            self.nowCost = newCost;
            [self clickSureBtnAction];
        };
        [costView show];
        
    }else if ([self.changeStyle isEqualToString:@"修改价格"]){
        SellerChangePriceAlertView *priceView = [[SellerChangePriceAlertView alloc] init];
        priceView.orderID = self.orderInfo.orderId;
        
        if ([self.orderInfo.status isEqualToString:@"2"]) {// 定金
            priceView.realMoney = self.orderInfo.price;
            priceView.realMoneyNote = @"实付定金";
            priceView.changeStyle = @"修改定金";
            priceView.price = self.orderInfo.price;
            priceView.oldPrice = self.orderInfo.priceOld;
            priceView.placeHolder = self.orderInfo.price;
        }else if ([self.orderInfo.status isEqualToString:@"3"]) {//尾款
            priceView.realMoney = self.orderInfo.productBalance;
            priceView.placeHolder = self.orderInfo.price;
            priceView.price = self.orderInfo.price;
            priceView.oldPrice = self.orderInfo.priceOld;
        }else if ([self.orderInfo.status isEqualToString:@"5"]) {// 全款
            priceView.realMoney = self.orderInfo.price;
            priceView.realMoneyNote = @"实付金额";
            priceView.changeStyle = @"修改金额";
            priceView.price = self.orderInfo.price;
            priceView.oldPrice = self.orderInfo.priceOld;
            priceView.placeHolder = self.orderInfo.price;
        }

        priceView.commitBlock = ^(NSString *newPrice){
            DLog(@"%@", newPrice);
            self.nowCost = newPrice;
            [self clickSureBtnAction];
        };
        [priceView show];
    }
}
// 修改
- (void)clickSureBtnAction {
    // 判断是哪一种修改 运费还是价格
    if ([self.changeStyle isEqualToString:@"修改运费"]) {
        // 请求
//        NSDictionary *dict = @{
//                               @"id":_orderID,
//                               @"user_id":[UserInfos sharedUser].ID,
//                               @"price":self.nowCost
//                               };
       
    }else if ([self.changeStyle isEqualToString:@"修改价格"]){
        // 请求
//        * @param  string  $id    订单id
//        * @param  string  $user_id 用户ID
//        * @param  string  $price 价格
//        * @param  string  $type 类型 1 定金 2 尾款 3 全款
        NSInteger type = 0;
        if ([self.orderInfo.status isEqualToString:@"2"]) {// 定金
            type = 1;
        }else if ([self.orderInfo.status isEqualToString:@"3"]) {//尾款
            type = 2;
        }else if ([self.orderInfo.status isEqualToString:@"5"]) {// 全款
            type = 3;
        }
        
        NSDictionary *dict = @{
                               @"id":_orderID,
                               @"user_id":[UserInfos sharedUser].ID,
                               @"price":self.nowCost,
                               @"type":@(type)
                               };
        DLog(@"%@", dict);
        [self getRequestWithPath:API_Order_up params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            [self getRequestOrderDetail];
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}

#pragma mark
#pragma mark - 监听键盘
- (void)focusKeyboardShow {
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sureBtn.top).offset(-h + 50);
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.top);
        }];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.tableView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.width.top.equalTo(self.view);
            make.bottom.equalTo(self.sureBtn.top);
        }];
    }];
}

@end
