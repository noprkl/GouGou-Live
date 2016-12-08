//
//  GotoAssessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//  去评价（订单操作）

// 每行个数
#define ImgCount 5
// 图片总数
#define ImgTotalCount 7

#import "GotoAssessViewController.h"
#import "SellNameView.h"
#import "SellerDogCardView.h"
#import "SatisfiedAssessView.h"
#import "AddPhotosView.h"
#import "AnonymityAssessView.h"
#import "AddUpdataImagesView.h"
#import "AddPictureView.h"


@interface GotoAssessViewController ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    CGFloat W;//图片view高度
}
/** 商家名称 */
@property (strong,nonatomic) SellNameView *nickNameView;
/** 狗狗详情 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 交易满意度 */
@property (strong,nonatomic) SatisfiedAssessView *satisfiedView;
/** 放置TextFiled的view */
@property (strong,nonatomic) UIView *empyView;
/** 评论 */
@property (strong,nonatomic) UITextField *commentTextFiled;
///** 添加图片 */
//@property (strong,nonatomic) AddPhotosView *addPhotoView;

//@property(nonatomic, strong) AddUpdataImagesView *photoView; /**< 添加图片 */
@property(nonatomic, strong) AddPictureView *photoView; /**< 添加图片 */
@property(nonatomic, strong) NSMutableArray *photoArr; /**< 图片数组 */

/** 匿名评价 */
@property (strong,nonatomic) AnonymityAssessView *aninymityView;
/** 提交评价 */
@property (strong,nonatomic) UIButton * handinAssess;
/** 照片数量 */
@property (assign,nonatomic) NSInteger imageCount;

@end

@implementation GotoAssessViewController

#pragma mark - 网络请求
- (void)getOrderAssessRequest {

    NSDictionary *dict = @{@"user_id":@(17),
                           @"order_id":@(12),
                           @"point":@(5),
                           @"has_photo":@(2),
                           @"is_anomy":@(1),
                           @"img":@"image",
                           @"comment":@"text"
                           };
    
    [self postRequestWithPath:API_Order_evaluation params:dict success:^(id successJson) {
        DLog(@"%@",successJson[@"code"]);
        DLog(@"%@",successJson[@"message"]);
        
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
    [self.empyView addSubview:self.commentTextFiled];
//    [self.view addSubview:self.addPhotoView];
    [self.view addSubview:self.photoView];
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
    
    [_commentTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.empyView.top).offset(10);
        make.left.equalTo(weakself.empyView.left).offset(10);
        make.centerY.equalTo(weakself.empyView.centerY);
    }];
    
    if (self.photoView.addBlock) {
        
        if (ImgCount <= kMaxImgCount) {
            W = (SCREEN_WIDTH - (ImgTotalCount + 1) * 10) / ImgTotalCount;
        } else{
            W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / ImgCount;
        }
        
        CGFloat row = self.photoView.dataArr.count / ImgCount;
        W = (row + 1) * (W + 10) + 10;
        [self.photoView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentTextFiled.bottom);
            make.left.right.equalTo(self.view);
            make.height.equalTo(W + 20);
        }];
    } else {
        
        [self.photoView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.commentTextFiled.bottom);
            make.left.right.equalTo(self.view);
            make.height.equalTo(1);
        }];
    
    }
    /*
    [_photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.empyView.bottom).offset(1);
        make.height.equalTo(100);
    }];
    */
    [_aninymityView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.photoView.bottom).offset(1);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
    }];
    
//    [_addPhotoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.right.equalTo(weakself.view);
//        make.top.equalTo(weakself.empyView.bottom).offset(1);
//        make.height.equalTo(100);
//    }];
//
//    [_aninymityView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(weakself.addPhotoView.bottom).offset(1);
//        make.left.right.equalTo(weakself.view);
//        make.height.equalTo(44);
//    }];
    
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

- (UITextField *)commentTextFiled {

    if (!_commentTextFiled) {
        _commentTextFiled = [[UITextField alloc] init];
        _commentTextFiled.font = [UIFont systemFontOfSize:14];
        _commentTextFiled.placeholder = @"评论两句呗";
        _commentTextFiled.delegate = self;
    }
    return _commentTextFiled;
}

- (UIView *)empyView {

    if (!_empyView) {
        _empyView = [[UIView alloc] init];
        _empyView.backgroundColor = [UIColor colorWithHexString: @"#ffffff"];
        
    }
    return _empyView;
}
- (NSMutableArray *)photoArr {

    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}
- (AddPictureView *)photoView {
    
    if (!_photoView) {
        _photoView = [[AddPictureView alloc] initWithFrame:CGRectZero];
        _photoView.maxCount = ImgCount;
//        _photoView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        __weak typeof(_photoView) weakPhoto = _photoView;
        _photoView.addBlock = ^(){
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    [weakPhoto.dataArr addObject:photos[0]];
                    
                    [weakPhoto.collectionView reloadData];
                    weakSelf.photoArr = weakPhoto.dataArr;
                    [weakSelf addControllers];
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

        /*
        __block CGFloat W = 0;
        if (ImgCount <= kMaxImgCount) {
            W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / ImgCount;
        }else{
//            W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
            
        }
        _photoView = [[AddPictureView alloc] initWithFrame:CGRectMake(0, 267, SCREEN_WIDTH, W + 20)];
        _photoView.maxCount = ImgCount;
        _photoView.maxRow = ImgTotalCount % ImgCount;
        
        __weak typeof(self) weakSelf = self;
        __weak typeof(_photoView) weakPhoto = _photoView;
        _photoView.addBlock = ^(){
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    [weakPhoto.dataArr addObject:photos[0]];
                    [weakPhoto.collectionView reloadData];
                    CGFloat row = weakPhoto.dataArr.count / ImgTotalCount;
                    CGRect rect = weakPhoto.frame;
                    rect.size.height = (row + 1) * (W + 10) + 10;
                    weakPhoto.frame = rect;
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
    }
         */
    }
    return _photoView;
}

/*
- (AddPhotosView *)addPhotoView {

    if (!_addPhotoView) {
        self.imageCount = 0;
            _addPhotoView = [[AddPhotosView alloc] init];
        
        _addPhotoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        __weak typeof(self) weakself = self;
        __weak typeof(_addPhotoView) addPhotoView = _addPhotoView;
    
        _addPhotoView.addPhotoBlock = ^(UIButton *button) {
        
            weakself.imageCount ++;
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
        };
    }
    return _addPhotoView;
}
*/
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
#pragma mark - 点击提交评价
- (void)clickHandinAssess:(UIButton *)button {

    NSString * contentStr = self.commentTextFiled.text;
    
    BOOL flag = [contentStr isChinese];

    
    if (contentStr.length == 0) {
        
        [self showAlert:@"评价内容不能为空"];
    } else if (!flag) {
    
        [self showAlert:@"评价内容必须中文"];
    } else {
    
        if (self.photoView.dataArr.count == 0) {
            
            [self showAlert:@"上传图片不能为空"];
        } else {
        
//            [self popoverPresentationController];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
}

#pragma mark
#pragma mark - TextFiled代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    return YES;

}
@end
