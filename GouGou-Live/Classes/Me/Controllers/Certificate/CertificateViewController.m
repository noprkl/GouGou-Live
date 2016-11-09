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

@end

@implementation CertificateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"实名认证";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交认证" style:UIBarButtonItemStyleDone target:self action:@selector(handinCertificate)];

    [self.view addSubview:self.identityInfoView];
    [self.view addSubview:self.identityTableView];
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

- (void)pushToAddPhoto {

    
}

- (void)handinCertificate {

    __weak typeof(self) weakself = self;
    
    self.identityInfoView.nameTextBlock = ^(UITextField *textfiled){
        
        if (textfiled.text.length == 0) {
            [weakself showAlert:@"姓名不能为空"];
        } else if (![textfiled.text isChinese]) {
        
            [weakself showAlert:@"姓名必须为中文"];
        } else {
        
            
        }
    };
    
    self.identityInfoView.identiityTextBlock = ^(UITextField * textfiled) {
    
       BOOL flag = [[NSString alloc] judgeIdentityStringValid:textfiled.text];
        if (!flag) {
            
            [weakself showAlert:@"您输入的身份证格式不正确"];
        } else {
        
        
        }
        
    };
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
