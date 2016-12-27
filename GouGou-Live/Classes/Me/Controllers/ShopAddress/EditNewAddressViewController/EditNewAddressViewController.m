//
//  EditNewAddressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditNewAddressViewController.h"
#import "AddressChooseView.h"
#import "MyShopProvinceModel.h"
#import "MyShopAdressModel.h"

@interface EditNewAddressViewController ()<UITextFieldDelegate>

/** 收货人名字 */
@property (weak, nonatomic) IBOutlet UITextField *userNameTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

/** 所在省市区 */
@property (weak, nonatomic) IBOutlet UITextField *areaChooseTextfiled;
@property (weak, nonatomic) IBOutlet UITextField *roadTextField;

/** 邮编 */
@property (weak, nonatomic) IBOutlet UITextField *postalcodeTextfiled;
/** 详细地址 */
@property (weak, nonatomic) IBOutlet UITextField *detailAddressTextfiled;

@property(nonatomic, strong) NSString *provice; /**< 省 */
@property(nonatomic, strong) NSString *city; /**< 市 */
@property(nonatomic, strong) NSString *district; /**< 县 */

@property(nonatomic, strong) NSArray *proviceDataArr; /**< 省数据 */
@property(nonatomic, strong) NSArray *cityDataArr; /**< 市数据 */
@property(nonatomic, strong) NSArray *desticDataArr; /**< 县数据 */

@end

@implementation EditNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}

- (void)initUI {

    self.userNameTextfiled.delegate = self;
    self.areaChooseTextfiled.delegate = self;
    self.postalcodeTextfiled.delegate = self;
    self.detailAddressTextfiled.delegate = self;
    self.phoneTextField.delegate = self;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSaveButtonAction)];
    
    [self.areaChooseTextfiled addTarget:self action:@selector(editAreaChooseTextfiled:) forControlEvents:UIControlEventTouchDown];
    
    [self.phoneTextField addTarget:self action:@selector(phoneTextFieldChanged:) forControlEvents:(UIControlEventEditingDidEnd)];
    
    self.userNameTextfiled.text = self.adressModel.userName;
    NSString *adress = [NSString stringWithFormat:@"%@,%@,%@", self.adressModel.userProvince, self.adressModel.userCity, self.adressModel.userDistrict];
    self.phoneTextField.text = self.adressModel.userTel;
    self.areaChooseTextfiled.text = adress;
    self.detailAddressTextfiled.text = self.adressModel.userAddress;
    if (self.adressModel.street.length != 0) {
        self.roadTextField.text = self.adressModel.street;
    }
    if (self.adressModel.code.length != 0) {
        self.postalcodeTextfiled.text = self.adressModel.code;
    }
    DLog(@"%@",self.roadTextField.text);
    DLog(@"%@",self.postalcodeTextfiled.text);
    [self requestGetAreaData];
}
- (void)setAdressModel:(MyShopAdressModel *)adressModel {
    _adressModel = adressModel;
}
- (NSArray *)proviceDataArr {
    if (!_proviceDataArr) {
        _proviceDataArr = [NSArray array];
    }
    return _proviceDataArr;
}
- (NSArray *)cityDataArr {
    if (!_cityDataArr) {
        _cityDataArr = [NSArray array];
    }
    return _cityDataArr;
}
- (NSArray *)desticDataArr {
    if (!_desticDataArr) {
        _desticDataArr = [NSArray array];
    }
    return _desticDataArr;
}
- (void)requestGetAreaData {
    [self getRequestWithPath:API_Province params:@{@"id":@(0)} success:^(id successJson) {
        if (successJson) {
            self.proviceDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        }
//        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self getRequestWithPath:API_Province params:@{@"id":@(1)} success:^(id successJson) {
        if (successJson) {
            self.cityDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        }
//        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self getRequestWithPath:API_Province params:@{@"id":@(36)} success:^(id successJson) {
        if (successJson) {
//            self.desticDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            self.desticDataArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];

        }
//        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark - textfiled内容编辑

- (void)editAreaChooseTextfiled:(UITextField *)sender {
    
    // 取消第一响应者
    [self.userNameTextfiled resignFirstResponder];
    [self.postalcodeTextfiled resignFirstResponder];
    [self.detailAddressTextfiled resignFirstResponder];
    [self.areaChooseTextfiled resignFirstResponder];
    [self.phoneTextField resignFirstResponder];
    [self.roadTextField resignFirstResponder];
}

- (void)phoneTextFieldChanged:(UITextField *)sender {
    // 判断正则
    BOOL flag =  [NSString valiMobile:sender.text];
    if (!flag) {
        
        [self showAlert:@"请输入正确的手机号"];
    }
}

#pragma mark - 点击保存按钮
- (void)clickSaveButtonAction {
    
       // 判断
    if ([self.userNameTextfiled.text isEqualToString:@""]) {
        [self showAlert:@"收货人不能为空"];
    }else if (![self.userNameTextfiled.text isChinese]){
        [self showAlert:@"收货人名字为汉字"];
    }else if (self.userNameTextfiled.text.length > 4){
        [self showAlert:@"最多四个汉字"];
    }else{
        
        if ([self.phoneTextField.text isEqualToString:@""]) {
            [self showAlert:@"手机号不能为空"];
        }else if (![NSString valiMobile:self.phoneTextField.text]){
            [self showAlert:@"手机号输入有误，请重新输入"];
            self.phoneTextField.text = @"";
        
//        if ([self.areaChooseTextfiled.text isEqualToString:@""]) {
//        [self showAlert:@"地址不能为空"];
        }else{
            
            if ([self.areaChooseTextfiled.text isEqualToString:@""]) {
                [self showAlert:@"地址不能为空"];
//            if ([self.phoneTextField.text isEqualToString:@""]) {
//                [self showAlert:@"手机号不能为空"];
//            }else if (![NSString valiMobile:self.phoneTextField.text]){
//                [self showAlert:@"手机号输入有误，请重新输入"];
//                self.phoneTextField.text = @"";
            }else{
                if ([self.detailAddressTextfiled.text isEqualToString:@""]) {
                    [self showAlert:@"详细地址不能为空"];
                }else{
                    NSString *adress = [NSString stringWithFormat:@"%@%@", self.roadTextField.text, self.detailAddressTextfiled.text];
                    NSDictionary *dict = @{
                                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                           @"id":@(_adressModel.ID ),
                                           @"user_name":self.userNameTextfiled.text,
                                           @"user_tel":@([self.phoneTextField.text integerValue]),
                                           @"is_default":@(_adressModel.isDefault),
                                           @"user_province":_adressModel.userProvince,
                                           @"user_city":_adressModel.userCity,
                                           @"user_district":_adressModel.userDistrict,
                                           @"user_address":adress,
                                           @"street":self.roadTextField.text,
                                           @"code":self.postalcodeTextfiled.text
                                           };
                    NSLog(@"%@", dict);

                    [self postRequestWithPath:API_Up_address params:dict success:^(id successJson) {
                        [self showAlert:successJson[@"message"]];
                        if ([successJson[@"message"] isEqualToString:@"修改成功"]) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                              [self.navigationController popViewControllerAnimated:YES];
                            });
                        }

                    } error:^(NSError *error) {
                        DLog(@"%@", error);
                    }];
                }
            }
        }
    }
}
#pragma mark
#pragma mark - TextFiled代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    if (textField == self.userNameTextfiled) {
        if ([NSString isChinese:string]) {
            return YES;
        }
        return NO;

    }
    if (textField == self.areaChooseTextfiled) {
        [textField resignFirstResponder];
        return NO;
    }
    if (textField == self.phoneTextField) {
        
        if (range.location < 11) {
            BOOL flag = [NSString validateNumber:textField.text];
            if (flag) {
                return YES;
            }
            return NO;
        }
        return NO;
    }
    if (textField == self.postalcodeTextfiled) {
        if (range.location < 8) {
            BOOL flag = [NSString validateNumber:textField.text];
            if (flag) {
                return YES;
            }
            return NO;
        }
        return NO;
    }
    if (textField == self.detailAddressTextfiled) {
        if (range.location < 20) {
            
            return YES;
        }
        [self showAlert:@"最多20个字"];
        return NO;
    }
    return NO;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.areaChooseTextfiled) {
        [textField resignFirstResponder];
        
        // 省市区级联
        __block AddressChooseView * choose = [[AddressChooseView alloc] init];
    
        __weak typeof(choose) weakChose = choose;
        choose.provinceArr = [self.proviceDataArr mutableCopy];
        choose.cityArr = [self.cityDataArr mutableCopy];
        choose.desticArr = [self.desticDataArr mutableCopy];
        // 选中第一行 第二行请求
        choose.firstBlock = ^(MyShopProvinceModel *model){
            [self getRequestWithPath:API_Province params:@{@"id":@(model.ID)} success:^(id successJson) {
                [weakChose.cityArr removeAllObjects];
                [weakChose.desticArr removeAllObjects];
                [weakChose.areaPicker reloadAllComponents];
                if (successJson) {
                    weakChose.cityArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                    [weakChose.areaPicker selectRow:0 inComponent:1 animated:YES];
                    [weakChose.areaPicker reloadComponent:1];

                    MyShopProvinceModel *cityModel = weakChose.cityArr[0];
                   
                    // 请求第3行
                    [self getRequestWithPath:API_Province params:@{@"id":@(cityModel.ID)} success:^(id successJson) {
                        [weakChose.desticArr removeAllObjects];
                        [weakChose.areaPicker reloadAllComponents];
                        if (successJson) {
                            weakChose.desticArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                            [weakChose.areaPicker selectRow:0 inComponent:2 animated:YES];
                            [weakChose.areaPicker reloadComponent:2];
                        }
                    } error:^(NSError *error) {
                        DLog(@"%@", error);
                    }];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        // 选中第二行 第三行请求
        choose.secondBlock = ^(MyShopProvinceModel *model){
            
            [self getRequestWithPath:API_Province params:@{@"id":@(model.ID)} success:^(id successJson) {
                if (successJson) {
                    weakChose.desticArr = [MyShopProvinceModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                    [weakChose.areaPicker selectRow:0 inComponent:2 animated:YES];
                    [weakChose.areaPicker reloadComponent:2];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        
        
        choose.areaBlock = ^(NSString *province,NSString *city,NSString *district){
            self.areaChooseTextfiled.text = [NSString stringWithFormat:@"%@,%@,%@",province, city, district];
            
            _adressModel.userProvince = province;
            _adressModel.userCity = city;
            _adressModel.userDistrict = district;
        };
        [choose show];
        
        return NO;
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
