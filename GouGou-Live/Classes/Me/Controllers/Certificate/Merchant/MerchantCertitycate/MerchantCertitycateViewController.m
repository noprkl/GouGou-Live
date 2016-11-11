//
//  MerchantCertitycateViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MerchantCertitycateViewController.h"
#import "AddressChooseView.h" // 城市选择
#import "PhotoView.h"

static NSString * MedrchantCell = @"MedrchantCell";

@interface MerchantCertitycateViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
/** tableView */
@property (strong,nonatomic) UITableView *MedrCertiInfoTable;
/** 数据 */
@property (strong,nonatomic) NSArray *dataArray;
/** 接受商品名称 */
@property (strong,nonatomic) UITextField *infoTextfiled;
/** 接受邀请码 */
@property (strong,nonatomic) UITextField *phoneNumTextfiled;
/** 照片 */
@property (strong,nonatomic) PhotoView *photoView;

@end

@implementation MerchantCertitycateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNav];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
}

- (void)initUI {
    
    [self.view addSubview:self.MedrCertiInfoTable];
    [self.view addSubview:self.photoView];
    self.title = @"商家认证";
}

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@[@"商品名称"], @[@"省、市、区",@"详细地址"], @[@"邀请码(填写邀请人电话号码会加快审核速度)"]];
    }
    return _dataArray;
}

- (PhotoView *)photoView {

    if (!_photoView) {
        _photoView = [[PhotoView alloc] initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, 197)];
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _photoView;
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
    textField.delegate = self;
    
    
    if (indexPath.section == 0 ) {
        // 接受商品名称
        self.infoTextfiled = textField;
        
        textField.font = [UIFont systemFontOfSize:16];
        
    } else if (indexPath.section == 1) {
        
        textField.font = [UIFont systemFontOfSize:16];
        if (indexPath.row == 0) {
            
            // 添加弹出城市选择
            [textField addTarget:self action:@selector(chooseArea:) forControlEvents:UIControlEventTouchDown];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else  {
            // 取消第一响应
            [textField canResignFirstResponder];
        }
    } else {
        // 接受邀请码
        self.phoneNumTextfiled = textField;
        textField.font = [UIFont systemFontOfSize:14];
    }
    
    [cell.contentView addSubview:textField];
    
    
    return cell;
}
// 城市选择
- (void)chooseArea:(UITextField *)textfile {
    
    AddressChooseView * choose = [[AddressChooseView alloc] init];
    
    [choose show];
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

    return YES;
}

// 点击提交认证
- (void)clickHandinCertitycate {
    
    BOOL flag =  [NSString valiMobile:self.phoneNumTextfiled.text];
    if (!flag) {
        
        [self showAlert:@"输入的不是电话号码"];
    } else {
    
    
    }
    
}

#pragma mark
#pragma mark - 导航栏设置
- (void)setNav {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(clickHandinCertitycate)];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
