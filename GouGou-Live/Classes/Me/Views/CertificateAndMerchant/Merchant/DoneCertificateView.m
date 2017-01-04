//
//  DoneCertificateView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DoneCertificateView.h"
#import "AddressChooseView.h" // 城市选择
#import "UIView+Toast.h"

static NSString * MedrchantCell = @"MedrchantCell";

@interface DoneCertificateView ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
/** tableView */
@property (strong,nonatomic) UITableView *MedrCertiInfoTable;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;

@property (nonatomic, strong) UILabel *label; /**< <#注释#> */

@end

@implementation DoneCertificateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.MedrCertiInfoTable];
    }
    return self;
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@[@"商家名称"], @[@"省、市、区",@"详细地址"], @[@"邀请码(填写邀请人电话号码会加快审核速度)"]];
    }
    return _dataArray;
}

- (UITableView *)MedrCertiInfoTable {
    
    if (!_MedrCertiInfoTable) {
        
        _MedrCertiInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260) style:UITableViewStylePlain];
        
        _MedrCertiInfoTable.delegate = self;
        _MedrCertiInfoTable.dataSource = self;
        _MedrCertiInfoTable.bounces = NO;
        
        _MedrCertiInfoTable.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        [_MedrCertiInfoTable registerClass:[UITableViewCell class] forCellReuseIdentifier:MedrchantCell];
        
    }
    return _MedrCertiInfoTable;
}
#pragma mark
#pragma mark - tableView代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        return 55;
    }
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        // 头部View
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 55)];
        view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        // 灰色区域View
        UIView * viewSmall = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        
        viewSmall.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        // 横线
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 55, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        // 经营地址label
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH, 44)];
        label.text = @"经营地址";
        label.textColor = [UIColor colorWithHexString:@"#000000"];
        label.font = [UIFont systemFontOfSize:16];
        
        [view addSubview:viewSmall];
        [viewSmall addSubview:label];
        [view addSubview:lineView];
        
        return view;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MedrchantCell];
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
            textField.placeholder = self.dataArray[indexPath.section][indexPath.row];
            textField.font = [UIFont systemFontOfSize:16];
            // 接受商品名称
            self.infoTextfiled = textField;
            textField.delegate = self;

            textField.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:textField];
        }
    }
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
//            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
//            textField.placeholder = self.dataArray[indexPath.section][indexPath.row];
//            textField.font = [UIFont systemFontOfSize:16];
//            // 添加弹出城市选择
//            self.areasTextField = textField;
////            [tex]
//            [textField addTarget:self action:@selector(editAreaTextAction:) forControlEvents:(UIControlEventAllEvents)];
//            textField.delegate = self;
//           
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            [cell.contentView addSubview:textField];
//            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//            [btn setTitle:@"省、市、区" forState:(UIControlStateNormal)];
//            btn.frame = CGRectMake(10, 0, 300, 44);
//            [btn addTarget:self action:@selector(ClickCityBtnAction:) forControlEvents:(UIControlEventTouchDown)];
//            btn.titleLabel.font = [UIFont systemFontOfSize:16];
//            [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
//            [cell.contentView addSubview:btn];
            cell.textLabel.text = @" 省、市、区";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            self.label = cell.textLabel;
        }
        if (indexPath.row == 1){
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
            textField.placeholder = self.dataArray[indexPath.section][indexPath.row];
            self.adressTextField = textField;
            textField.font = [UIFont systemFontOfSize:16];
            textField.delegate = self;
            textField.font = [UIFont systemFontOfSize:16];
            [cell.contentView addSubview:textField];
        }
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
            textField.placeholder = self.dataArray[indexPath.section][indexPath.row];
            // 接受邀请码
            self.phoneNumTextfiled = textField;
            textField.delegate = self;
            
            textField.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:textField];
        }
    }
    return cell;
}

#pragma mark
#pragma mark - textfiled代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumTextfiled) {
        BOOL flag = [NSString validateNumber:string];
        if (range.location < 11 && flag) {
            return YES;
        }
        return NO;
    }
//    if (textField == self.areasTextField) {
//        [textField resignFirstResponder];
//        [self.areasTextField resignFirstResponder];
//        [self.adressTextField resignFirstResponder];
//        [self.phoneNumTextfiled resignFirstResponder];
//        [self.infoTextfiled resignFirstResponder];
//        return NO;
//    }
    return YES;
}
#pragma mark - textfiled方法
- (void)editAreaTextAction:(UITextField *)textField {
    [textField resignFirstResponder];
    
}
- (void)ClickCityBtnAction:(UIButton *)btn {
    [self.adressTextField resignFirstResponder];
    [self.phoneNumTextfiled resignFirstResponder];
    [self.infoTextfiled resignFirstResponder];
//    if (_areasBlock) {
//        _areasBlock(btn);
//    }
}
#pragma mark - TextFiled代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField == self.areasTextField) {
//        [textField resignFirstResponder];    
//    }
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    if (textField == self.areasTextField) {
//
//        [self.areasTextField resignFirstResponder];
//        [self.adressTextField resignFirstResponder];
//        [self.phoneNumTextfiled resignFirstResponder];
//        [self.infoTextfiled resignFirstResponder];
//            
//        if (_areasBlock) {
//            [self.areasTextField resignFirstResponder];
//            [self.adressTextField resignFirstResponder];
//            [self.phoneNumTextfiled resignFirstResponder];
//            [self.infoTextfiled resignFirstResponder];
//            _areasBlock();
//        }
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 && indexPath.row == 0) {
        if (_areasBlock) {
            _areasBlock(self.label);
        }
    }
}

- (void)showMessage:(NSString *)string {
    [self makeToast:string duration:2 position:nil];
}

@end
