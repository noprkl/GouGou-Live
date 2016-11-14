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
        _dataArray = @[@[@"商品名称"], @[@"省、市、区",@"详细地址"], @[@"邀请码(填写邀请人电话号码会加快审核速度)"]];
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
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
    textField.placeholder = self.dataArray[indexPath.section][indexPath.row];
    
    
    if (indexPath.section == 0 ) {
        // 接受商品名称
        self.infoTextfiled = textField;
        textField.delegate = self;

        textField.font = [UIFont systemFontOfSize:16];
        
    } else if (indexPath.section == 1) {
        
        textField.font = [UIFont systemFontOfSize:16];
        if (indexPath.row == 0) {
            
            // 添加弹出城市选择
            textField.enabled = NO;
            self.aresTextField = textField;
            textField.delegate = self;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
       
        } else if (indexPath.row == 1){
          
            self.aresTextField = textField;
            textField.delegate = self;
        }
        
    } else {
        // 接受邀请码
        self.phoneNumTextfiled = textField;
        textField.delegate = self;

        textField.font = [UIFont systemFontOfSize:14];
    }
    
    [cell.contentView addSubview:textField];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self.aresTextField resignFirstResponder];
            [self.adressTextField resignFirstResponder];
            [self.phoneNumTextfiled resignFirstResponder];
            [self.infoTextfiled resignFirstResponder];
            
            // 城市选择
            AddressChooseView * choose = [[AddressChooseView alloc] init];
            choose.areaBlock = ^(NSString *province,NSString *city,NSString *area){
                DLog(@"省市区");
            };
            [choose show];
        }
    }
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
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

// 点击提交认证
- (void)clickHandinCertitycate {
    
    BOOL flag =  [NSString valiMobile:self.phoneNumTextfiled.text];
    if (!flag) {
        
        [self showMessage:@"输入的不是电话号码"];
    } else {
        
        
    }
    
}

- (void)showMessage:(NSString *)string {
    [self makeToast:string duration:2 position:nil];
}

@end
