//
//  CertificateViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "CertificateViewController.h"
#import "IdentityIfonView.h"
#import "IdentityPictureCell.h"

static NSString * identityCell = @"identitiCellID";

@interface CertificateViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 身份信息 */
@property (strong,nonatomic) IdentityIfonView *identityInfoView;
/** 身份验证tableView */
@property (strong,nonatomic) UITableView *identityTableView;
/** 接收姓名 */
@property (strong,nonatomic) UITextField *acceptName;
/** 接收身份证号 */
@property (strong,nonatomic) UITextField *acceptIdebtity;

@end

@implementation CertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItemLeft];
}
- (void)setNavBarItemLeft {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)initUI {

    self.title = @"实名认证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(handinCertificate)];

    [self.view addSubview:self.identityInfoView];
    [self.view addSubview:self.identityTableView];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
}

- (IdentityIfonView *)identityInfoView {

    if (!_identityInfoView) {
        _identityInfoView = [[IdentityIfonView alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 88)];
        
    }
    return _identityInfoView;
}

- (UITableView *)identityTableView {

    if (!_identityTableView) {
        _identityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 130, SCREEN_WIDTH, SCREEN_HEIGHT - 130) style:UITableViewStylePlain];
        _identityTableView.delegate = self;
        _identityTableView.dataSource = self;
        [_identityTableView registerClass:[IdentityPictureCell class] forCellReuseIdentifier:identityCell];
    }
    return _identityTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 428;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    IdentityPictureCell * cell = [tableView dequeueReusableCellWithIdentifier:identityCell];
    
    if (indexPath.row == 0) {
        [cell identityWithPromptlabel:@"请上传身份证正面标签" instanceImage:[UIImage imageNamed:@"组-12"] instanceLabe:@"(示例)清晰正面照" identityImage:[UIImage imageNamed:@"图层-53-拷贝-2"] identityLabel:@"清晰正面照"];
    } else if (indexPath.row == 1) {
        
        [cell identityWithPromptlabel:@"请上传身份证背面标签" instanceImage:[UIImage imageNamed:@"组-11"] instanceLabe:@"(示例)清晰背面照" identityImage:[UIImage imageNamed:@"图层-53-拷贝-2"] identityLabel:@"清晰背面照"];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    cell.addIdentityBlock = ^() {
    
        [self pushToAddPhoto];
    };
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}

- (void)handinCertificate {

    __weak typeof(self) weakself = self;
    
    self.identityInfoView.nameTextBlock = ^(UITextField *textfiled){
        
        weakself.acceptName = textfiled;
        
    };

    self.identityInfoView.identiityTextBlock = ^(UITextField * textfiled) {
    
        weakself.acceptIdebtity = textfiled;
        
    };
    
    if (self.acceptName.text.length == 0) {
        
        [self showAlert:@"姓名不能为空"];
        
    } else if (![self.acceptName.text isChinese]) {
        
        [self showAlert:@"姓名必须为中文"];
        
    } else if (self.acceptName.text.length > 4){
        
        [self showAlert:@"姓名最多四个汉字"];
    } else {
    
        BOOL flag = [[NSString alloc] judgeIdentityStringValid:self.acceptIdebtity.text];
        
        if (!flag) {
            
            [self showAlert:@"您输入的身份证格式不正确"];
        } else {
            
            [self requestNameAndIdentiry];
        }
    }
    
}



#pragma 网络请求
- (void)requestNameAndIdentiry {

#warning 验证身份
    
}
#pragma 提交认证跳转
- (void)pushToAddPhoto {
    
    //    UIImagePickerController * pickVC = [[UIImagePickerController alloc] init];
    //
    //    [self.navigationController pushViewController:pickVC animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
