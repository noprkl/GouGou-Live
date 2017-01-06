//
//  SellerAddShipTemplateViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAddShipTemplateViewController.h"
#import "SellerAdressModel.h"
#import "ChosedAdressView.h"
#import "SellerChoseAdressViewController.h" // 选择地址

@interface SellerAddShipTemplateViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UITextField *templateName; /**< 模板名字 */

@property (nonatomic, strong) NSString *templateStr; /**< 名字 */

@property(nonatomic, strong) SellerAdressModel *adressModel; /**< 传过来的数据 */

//@property(nonatomic, assign) BOOL isAdress; /**< 是地址 */

@property(nonatomic, strong) UISwitch *freeCost; /**< 免费 */

@property(nonatomic, strong) UISwitch *shipCost; /**< 默认运费开关 */

@property (nonatomic, strong) UITextField *costTextField; /**< 默认金钱 */


@property(nonatomic, strong) UISwitch *realCost; /**< 按实结算 */

@property (nonatomic, strong) NSString *cost; /**< 花费 */
@property (nonatomic, assign) NSInteger type; /**< 运费类型 */
@end

static NSString *cellid = @"SellerAddShipTemplate";

@implementation SellerAddShipTemplateViewController
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    self.title = @"运费管理";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(saveBtnAction)];
        [self.view addSubview:self.tableView];
   // 默认免运费
    _cost = @"0";
    _type = 1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShopAdressFromAdress:) name:@"ChoseSendAdress" object:nil];
}

- (void)getShopAdressFromAdress:(NSNotification *)adress {
    
    SellerAdressModel *model = adress.userInfo[@"ChoseSendAdress"];
    if (model.merchantTel.length != 0) {
//        [self.view addSubview:self.tableView];
        self.adressModel = model;
        [self.tableView reloadData];
    }
}

#pragma mark
#pragma mark - Action 
- (void)saveBtnAction {
    // 保存
    if (self.templateStr.length == 0) {
        [self showAlert:@"请添加模板名称"];
    }else{
        if (self.adressModel.merchantName.length == 0) {
            [self showAlert:@"请选择发货地址"];
        }else{
            if (self.cost.length == 0) {
                [self showAlert:@"请选择一种运费方式"];
            }else{
                
                NSDictionary *dict = @{
                                       @"user_id":[UserInfos sharedUser].ID,
                                       @"name":self.templateStr,
                                       @"money":self.cost,
                                       @"address_id":@(self.adressModel.ID),
                                       @"type":@(self.type)
                                       };
                /**
                 0 运费模版
                 1 免运费
                 2 按时计算
                 */
                [self postRequestWithPath:API_Freight params:dict success:^(id successJson) {
                    [self showAlert:successJson[@"message"]];
                    DLog(@"%@", successJson);
                    if ([successJson[@"message"] isEqualToString:@"成功"]) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
        }
    }
}
// 免费
- (void)priceSwitchBtnAction:(UISwitch *)switchBtn {
    [self.dataArr removeAllObjects];
    
    [_dataArr addObject:self.templateName.text];
    [_dataArr addObject:@"发货地址(必填)"];
    [_dataArr addObject:@"免运费"];
    [_dataArr addObject:@"默认运费价格"];
    [_dataArr addObject:@"按实结算"];
    [self.tableView reloadData];
    
    if (switchBtn.isOn) {
        self.shipCost.on = NO;
        self.realCost.on = NO;
        self.cost = @"0";
        _type = 1;
    }
}
// 默认
- (void)shipCostSwitchBtnAction:(UISwitch *)switchBtn {
    if (switchBtn.isOn) {
        [self.dataArr removeAllObjects];
        [_dataArr addObject:self.templateName.text];
        [_dataArr addObject:@"发货地址(必填)"];
        [_dataArr addObject:@"免运费"];
        [_dataArr addObject:@"默认运费价格"];
        [_dataArr addObject:@""];
        [_dataArr addObject:@"按实结算"];
        [self.tableView reloadData];
        self.realCost.on = NO;
        self.freeCost.on = NO;
        _type = 0;
        _cost = self.templateName.text;
    }else{
        [self.dataArr removeAllObjects];
        [_dataArr addObject:self.templateName.text];
        [_dataArr addObject:@"发货地址(必填)"];
        [_dataArr addObject:@"免运费"];
        [_dataArr addObject:@"默认运费价格"];
        [_dataArr addObject:@"按实结算"];
        [self.tableView reloadData];
    }
}
// 按实结算
- (void)realCostSwitchBtnAction:(UISwitch *)switchBtn {
   
    self.shipCost.on = NO;
    self.freeCost.on = NO;
    [self.dataArr removeAllObjects];
    [_dataArr addObject:self.templateStr];
    [_dataArr addObject:@"发货地址(必填)"];
    [_dataArr addObject:@"免运费"];
    [_dataArr addObject:@"默认运费价格"];
    [_dataArr addObject:@"按实结算"];
    [self.tableView reloadData];
    self.cost = @"0";
    _type = 2;
}
- (void)editShipTemplateAction:(UITextField *)textField {
    _templateStr = textField.text;
}
- (void)editShipCount:(UITextField *)textField {
    self.cost = textField.text;
    _type = 0;
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:10];
        [_dataArr addObject:@"运费模板一(自定义输入名称)"];
        [_dataArr addObject:@"发货地址(必填)"];
        [_dataArr addObject:@"免运费"];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _tableView;
}
- (UISwitch *)freeCost {
    if (!_freeCost) {
        _freeCost = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        _freeCost.on = YES;
        _freeCost.userInteractionEnabled = NO;
        // 注释掉这个就不能点击了
//        [_freeCost addTarget:self action:@selector(priceSwitchBtnAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _freeCost;
}
- (UISwitch *)shipCost {
    if (!_shipCost) {
        _shipCost = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [_shipCost addTarget:self action:@selector(shipCostSwitchBtnAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _shipCost;
}
- (UISwitch *)realCost {
    if (!_realCost) {
        _realCost = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];

        [_realCost addTarget:self action:@selector(realCostSwitchBtnAction:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _realCost;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    
    NSString *cellText = self.dataArr[indexPath.row];
   
    if (indexPath.row == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"templateName"];

        UITextField *templateName = [[UITextField alloc] initWithFrame:CGRectMake(13, (44 - 25) / 2, SCREEN_WIDTH, 25)];
        if (self.templateStr.length != 0) {
            templateName.text = self.templateStr;
        }
        templateName.font = [UIFont systemFontOfSize:14];
        templateName.textColor = [UIColor colorWithHexString:@"#333333"];
        templateName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.dataArr[indexPath.row] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"]}];
        [templateName addTarget:self action:@selector(editShipTemplateAction:) forControlEvents:(UIControlEventEditingChanged)];
        templateName.delegate = self;
        self.templateName = templateName;
        [cell.contentView addSubview:templateName];
        return cell;
    }
    if ([cellText isEqualToString:@"发货地址(必填)"]) {
        if (self.adressModel.merchantTel.length != 0) {
            ChosedAdressView *adressView = [[ChosedAdressView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
            adressView.sellerAdress = self.adressModel;
            [cell.contentView addSubview:adressView];

        }else{
            cell.textLabel.text = self.dataArr[indexPath.row];
        }
    }
    if ([cellText isEqualToString:@"已有发货地址"]) {
        
    }
    if ([cellText isEqualToString:@"免运费"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"freeCost"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        cell.textLabel.text = self.dataArr[indexPath.row];
        
        cell.accessoryView = self.freeCost;
        return cell;
    }
    if ([cellText isEqualToString:@"默认运费价格"]) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"shipCost"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.text = self.dataArr[indexPath.row];
        
        cell.accessoryView = self.shipCost;

        return cell;
    }
    if ([cellText isEqualToString:@""]) {
       UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"shipCostCount"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        UITextField *shipCostCount = [[UITextField alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH, 44)];
        shipCostCount.placeholder = @"输入运费";
        shipCostCount.font = [UIFont systemFontOfSize:16];
        shipCostCount.textColor = [UIColor colorWithHexString:@"#333333"];
        shipCostCount.delegate = self;
        [shipCostCount addTarget:self action:@selector(editShipCount:) forControlEvents:(UIControlEventEditingChanged)];
        [cell.contentView addSubview:shipCostCount];
        return cell;
    }
    if ([cellText isEqualToString:@"按实结算"]) {

        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"realCost"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        
        cell.textLabel.text = self.dataArr[indexPath.row];
        // 按实结算
        cell.accessoryView = self.realCost;
        return cell;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 44;
            break;
        case 1:
            if (self.adressModel.merchantName.length != 0) {
                return 88;
            }else{
                return 44;
            }
            break;
        case 2:
            return 44;
            break;
        case 3:
            return 44;
            break;
        case 4:
            return 44;
            break;
        case 5:
            return 44;
            break;
        case 6:
            return 44;
            break;
        default:
            break;
    }
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    NSString *cellText = self.dataArr[indexPath.row];
    if ([cellText isEqualToString:@"发货地址(必填)"]) {
        SellerChoseAdressViewController *choseAdressVC = [[SellerChoseAdressViewController alloc] init];
        choseAdressVC.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:choseAdressVC animated:YES];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.costTextField) {
        if ([NSString validateNumber:string]) {
            return NO;
        }
        return YES;
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
