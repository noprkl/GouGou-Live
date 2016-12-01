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

#import "SellerNickNameView.h"
#import "SellerDogCardView.h"
#import "SellerCostView.h"
#import "ChosedAdressView.h"
#import "SellerChangePayView.h"

#import "NSString+MD5Code.h"
@interface SellerChangeViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UIButton *sureBtn; /**< 确认按钮 */

@end

static NSString *cellid = @"SellerAcceptRateCell";

@implementation SellerChangeViewController

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
    [self.view addSubview:self.sureBtn];
   
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self.view);
        make.bottom.equalTo(self.sureBtn.top);
    }];
    
    // 进来立即弹窗
    [self showAlertView];
}

// 网络请求
- (void)codePayPsdRequest {
    // 判断是哪一种修改 运费还是价格
    if ([self.changeStyle isEqualToString:@"修改运费"]) {
        SellerChangeShipCostView *costView = [[SellerChangeShipCostView alloc] init];
        costView.commitBlock = ^(NSString *newCost){
            DLog(@"%@", newCost);
        };
        [costView show];
        
    }else if ([self.changeStyle isEqualToString:@"修改价格"]){
        SellerChangePriceAlertView *priceView = [[SellerChangePriceAlertView alloc] init];
        priceView.commitBlock = ^(NSString *newPrice){
            DLog(@"%@", newPrice);
        };
        [priceView show];
    }
}
- (void)setChangeStyle:(NSString *)changeStyle {
    _changeStyle = changeStyle;
    self.title = changeStyle;
}
- (void)clickSureBtnAction {
    DLog(@"sure");
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
//                UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SellerNickName"];
//            cell.backgroundView = [[UIView alloc] init];
//            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            SellerNickNameView *nickView = [[SellerNickNameView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            nickView.stateMessage = @"已付定金";
            [cell.contentView addSubview:nickView];
//            return cell;
        }
            break;
        case 1:
        {
//            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SellerDogCard"];
//            cell.backgroundView = [[UIView alloc] init];
//            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            SellerDogCardView *dogCadView = [[SellerDogCardView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98)];
            
            [cell.contentView addSubview:dogCadView];
//            return cell;
        }
            break;
        case 2:
        {
//            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SellerCost"];
//            cell.backgroundView = [[UIView alloc] init];
//            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            SellerCostView *costView = [[SellerCostView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            costView.messages = @[@"尾款：950", @"定金：500"];
            [cell.contentView addSubview:costView];
//            return cell;
        }
            break;
        case 3:
        {
//            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"ChosedAdress"];
//            cell.backgroundView = [[UIView alloc] init];
//            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            ChosedAdressView *adressView = [[ChosedAdressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
            adressView.isHid = YES;
            [cell.contentView addSubview:adressView];

            //            return cell;

        }
            break;
        case 4:
        {
//            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SellerChangePay"];
//            cell.backgroundView = [[UIView alloc] init];
//            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            SellerChangePayView *changePay = [[SellerChangePayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 125)];
            changePay.editBlock = ^(){
                
            };
            [cell.contentView addSubview:changePay];
          
//            return cell;
            
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
    DLog(@"%ld", indexPath.row);
}
- (void)showAlertView {
    // 封装蒙版的View
    __block  PromptView * prompt = [[PromptView alloc] initWithFrame:self.view.bounds];
    prompt.title = @"请输入交易密码";
    
    __weak typeof(self) weakself = self;
    // 提示框textfiled设置代理
    prompt.playpsdBlock = ^(UITextField *textfiled) {
        
    };
    
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
                // 申请成功
                [weakPrompt dismiss];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
        
    };

    prompt.cancelBlock = ^(){
        [weakself.navigationController popViewControllerAnimated:YES];
        prompt = nil;
        [prompt dismiss];
        
        
    };
    // 显示蒙版
//    [prompt show];
}
@end
