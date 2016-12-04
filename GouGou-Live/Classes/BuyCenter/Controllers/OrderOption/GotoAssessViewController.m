//
//  GotoAssessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  去评价（订单操作）
#import "GotoAssessViewController.h"
#import "SellNameView.h"
#import "SellerDogCardView.h"
#import "SatisfiedAssessView.h"
#import "AddPhotosView.h"
#import "AnonymityAssessView.h"


@interface GotoAssessViewController ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
/** 商家名称 */
@property (strong,nonatomic) SellNameView *nickNameView;
/** 狗狗详情 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 交易满意度 */
@property (strong,nonatomic) SatisfiedAssessView *satisfiedView;
/** 放置TextFiled的view */
@property (strong,nonatomic) UIView *empyView;
/** 评论 */
@property (strong,nonatomic) UITextField *textfiled;
/** 添加图片 */
@property (strong,nonatomic) AddPhotosView *addPhotoView;
/** 匿名评价 */
@property (strong,nonatomic) AnonymityAssessView *aninymityView;
/** 提交评价 */
@property (strong,nonatomic) UIButton * handinAssess;

@end

@implementation GotoAssessViewController

#pragma mark - 网络请求
- (void)getOrderAssessRequest {

    NSDictionary *dict = @{@"user_id":@(11),
                           @"order_id":@(12),
                           @"point":@(10),
                           @"has_photo":@(10),
                           @"is_anomy":@(10),
                           @"img":@"nil",
                           @"comment":@"yes"
                           };
    
    [self postRequestWithPath:API_Order_evaluation params:dict success:^(id successJson) {
        DLog(@"%@",successJson[@"code"]);
        
    } error:^(NSError *error) {
        DLog(@"%@",error);
    }];
    
}
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self getOrderAssessRequest];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"我要评价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    [self.view addSubview:self.nickNameView];
    [self.view addSubview:self.dogCardView];
    [self.view addSubview:self.satisfiedView];
    [self.view addSubview:self.empyView];
    [self.empyView addSubview:self.textfiled];
    [self.view addSubview:self.addPhotoView];
    [self.view addSubview:self.aninymityView];
    [self.view addSubview:self.handinAssess];
    
    [self addControllers];
}

#pragma mark
#pragma mark - 约束
- (void)addControllers {
    
    __weak typeof(self) weakself = self;
    
    [_nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.top.right.equalTo(weakself.view);
        make.height.equalTo(44);
        
    }];
    
    [_dogCardView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.nickNameView.bottom);
        make.height.equalTo(110);
    }];
    
    [_satisfiedView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.dogCardView.bottom);
        make.height.equalTo(44);
    }];
    
    [_empyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.satisfiedView.bottom).offset(1);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
        
    }];
    
    [_textfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.empyView.top).offset(10);
        make.left.equalTo(weakself.empyView.left).offset(10);
        make.centerY.equalTo(weakself.empyView.centerY);
    }];
    
    [_addPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.empyView.bottom).offset(1);
        make.height.equalTo(100);
    }];
    
    [_aninymityView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.addPhotoView.bottom).offset(1);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
    }];
    
    [_handinAssess mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.bottom.equalTo(weakself.view);
        make.height.equalTo(44);
        
    }];
}

#pragma mark
#pragma mark - 初始化
- (SellNameView *)nickNameView {

    if (!_nickNameView) {
        _nickNameView = [[SellNameView alloc] init];
        _nickNameView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _nickNameView;
}

- (SellerDogCardView *)dogCardView {

    if (!_dogCardView) {
        _dogCardView = [[SellerDogCardView alloc] init];
        _dogCardView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _dogCardView;
}

- (SatisfiedAssessView *)satisfiedView {

    if (!_satisfiedView) {
        _satisfiedView = [[SatisfiedAssessView alloc] init];
        _satisfiedView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _satisfiedView;
}

- (UITextField *)textfiled {

    if (!_textfiled) {
        _textfiled = [[UITextField alloc] init];
        _textfiled.font = [UIFont systemFontOfSize:14];
        _textfiled.placeholder = @"评论两句呗";
        _textfiled.delegate = self;
    }
    return _textfiled;
}

- (UIView *)empyView {

    if (!_empyView) {
        _empyView = [[UIView alloc] init];
        _empyView.backgroundColor = [UIColor colorWithHexString: @"#ffffff"];
        
    }
    return _empyView;
}

- (AddPhotosView *)addPhotoView {

    if (!_addPhotoView) {
        _addPhotoView = [[AddPhotosView alloc] init];
        _addPhotoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        __weak typeof(self) weakself = self;
        __weak typeof(_addPhotoView) addPhotoView = _addPhotoView;
    
        _addPhotoView.addPhotoBlock = ^(UIButton *button) {
        
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            
            addPhotoView.pickers = picker;
            
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
               
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                // 设置代理
                picker.delegate = weakself;
                
                 picker.allowsEditing = YES;
                //模态显示界面
                
                [weakself presentViewController:picker animated:YES completion:^{
                
                
                
                }];
            }
//
        };
        
    }
    return _addPhotoView;
}

- (AnonymityAssessView *)aninymityView {

    if (!_aninymityView) {
        _aninymityView = [[AnonymityAssessView alloc] init];
        _aninymityView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    }
    return _aninymityView;
}
- (UIButton *)handinAssess {
    
    if (!_handinAssess) {
        
        _handinAssess = [UIButton buttonWithType:UIButtonTypeSystem];
        [_handinAssess setTintColor:[UIColor colorWithHexString:@"#ffffff"]];
        [_handinAssess setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_handinAssess setTitle:@"提交评价" forState:UIControlStateNormal];
        _handinAssess.titleLabel.font = [UIFont systemFontOfSize:16];
        _handinAssess.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_handinAssess addTarget:self action:@selector(clickHandinAssess:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _handinAssess;
}

- (void)clickHandinAssess:(UIButton *)button {

    
}

#pragma mark
#pragma mark - TextFiled代理

- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    
    return YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
