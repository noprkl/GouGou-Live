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
#import "StarsView.h"

#import "OrderDetailModel.h"
#import "NSString+CertificateImage.h"

// 每行个数
#define rowImgCount 5
// 图片总数
#define ImgTotalCount 7

@interface GotoAssessViewController ()<UITextFieldDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
{
    CGFloat W;//图片view高度
}
/** 商家名称 */
@property (strong,nonatomic) SellNameView *nickNameView;
/** 狗狗详情 */
@property (strong,nonatomic) SellerDogCardView *dogCardView;
/** 交易满意度 */
@property (strong,nonatomic) StarsView *starview;
/** 放置TextFiled的view */
@property (strong,nonatomic) UIView *empyView;
/** 评论 */
@property (strong,nonatomic) UITextField *commentTextFiled;
@property(nonatomic, strong) AddPictureView *photoView; /**< 添加图片 */
@property(nonatomic, strong) NSMutableArray *photoArr; /**< 图片地址数组 */
/** 匿名评价 */
@property (strong,nonatomic) AnonymityAssessView *aninymityView;
/** 提交评价 */
@property (strong,nonatomic) UIButton * handinAssess;

@property (nonatomic, strong) OrderDetailModel *detailModel; /**< 详情信息 */

@property (nonatomic, assign) BOOL isReal; /**< 是否匿名评价 */

@end

@implementation GotoAssessViewController

#pragma mark - 网络请求
- (void)OrderAssessRequest {
   
    // 匿名
    NSInteger isReal = 1;
    if (!_isReal) {
        isReal = 0;
    }
    
    if (self.photoView.dataArr.count != 0) {
        for (NSInteger i = 0; i < self.photoView.dataArr.count; i ++) {
            NSString *base64 = [NSString imageBase64WithDataURL:self.photoView.dataArr[0]];
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"img":base64
                                   };
            [self postRequestWithPath:API_UploadImg params:dict success:^(id successJson) {
                if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                    [self.photoArr addObject:successJson[@"data"]];
                    
                    if (self.photoArr.count == self.photoView.dataArr.count) {
                        // 图片base64字符串
                        NSString *str = [self.photoArr componentsJoinedByString:@"|"];
                        DLog(@"%@", str);
                        NSDictionary *dict = @{//
                                               @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                               @"order_id":_orderID,
                                               @"point":@(self.starview.startCount),
                                               @"has_photo":@(1),
                                               @"is_anomy":@(isReal),
                                               @"img":str,
                                               @"comment":self.commentTextFiled.text
                                               };
                        DLog(@"%@", dict);
                        [self postRequestWithPath:API_Order_evaluation params:dict success:^(id successJson) {
                            DLog(@"%@",successJson);
                            [self showAlert:successJson[@"message"]];
                        } error:^(NSError *error) {
                            DLog(@"%@",error);
                        }];
                    }
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
        
    }else {
        NSDictionary *dict = @{//
                               @"user_id":@([[UserInfos sharedUser].ID intValue]),
                               @"order_id":_orderID,
                               @"point":@(self.starview.startCount),
                               @"has_photo":@(0),
                               @"is_anomy":@(isReal),
                               @"img":@"",
                               @"comment":self.commentTextFiled.text
                               };
        DLog(@"%@", dict);
        [self postRequestWithPath:API_Order_evaluation params:dict success:^(id successJson) {
            DLog(@"%@",successJson);
            [self showAlert:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"添加成功"]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        } error:^(NSError *error) {
            DLog(@"%@",error);
        }];
    }
}
- (void)getOrderDetailWithOrderID:(NSString *)orderId {
    NSDictionary *dict = @{
                           @"id":orderId
                           };
    [self getRequestWithPath:API_Order_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.detailModel = [OrderDetailModel mj_objectWithKeyValues:successJson[@"data"]];
        
        self.nickNameView.currentTime = self.detailModel.createTime;
        self.nickNameView.buynessName = self.detailModel.userName;
        self.nickNameView.buynessImg = self.detailModel.userImgUrl;
        
        // 狗狗详情
        if (self.detailModel.pathSmall.length != 0) {
            
            NSString *urlString = [IMAGE_HOST stringByAppendingString:self.detailModel.pathSmall];
            [self.dogCardView.dogImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
        }
        self.dogCardView.dogNameLabel.text = self.detailModel.name;
        self.dogCardView.dogAgeLabel.text = self.detailModel.ageName;
        self.dogCardView.dogSizeLabel.text = self.detailModel.sizeName;
        self.dogCardView.dogColorLabel.text = self.detailModel.colorName;
        self.dogCardView.dogKindLabel.text = self.detailModel.kindName;
        self.dogCardView.oldPriceLabel.attributedText = [NSAttributedString getCenterLineWithString:self.detailModel.priceOld];
        self.dogCardView.nowPriceLabel.text = self.detailModel.price;
        
        } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self getOrderDetailWithOrderID:_orderID];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
}

- (void)initUI {

    self.title = @"我要评价";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    _isReal = NO;
    [self.view addSubview:self.nickNameView];
    [self.view addSubview:self.dogCardView];
    [self.view addSubview:self.starview];
    [self.view addSubview:self.empyView];
    [self.empyView addSubview:self.commentTextFiled];
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
    
    [_starview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(weakself.view);
        make.top.equalTo(weakself.dogCardView.bottom);
        make.height.equalTo(44);
        
    }];
    
    [_empyView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.starview.bottom).offset(1);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
        
    }];
    
    [_commentTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.empyView.left).offset(10);
        make.right.equalTo(weakself.empyView.right).offset(-10);
        make.centerY.equalTo(weakself.empyView.centerY);
    }];
    
//    if (self.photoView.addBlock) {
    
        if (ImgTotalCount <= rowImgCount) {
            W = (SCREEN_WIDTH - (ImgTotalCount + 1) * 10) / ImgTotalCount;
        } else{
            W = (SCREEN_WIDTH - (rowImgCount + 1) * 10) / rowImgCount;
        }
        
        CGFloat row = self.photoView.dataArr.count / rowImgCount;
        W = (row + 1) * (W + 10) + 10;
        [self.photoView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.empyView.bottom).offset(1);
            make.left.right.equalTo(self.view);
            make.height.equalTo(W + 20);
        }];
        
//    }
    
    if(self.photoView.dataArr.count  < rowImgCount) {
       
        DLog(@"%ld",self.photoView.pictureCounts);
        if (ImgTotalCount <= rowImgCount) {
            W = (SCREEN_WIDTH - (ImgTotalCount + 1) * 10) / ImgTotalCount;
        } else{
            W = (SCREEN_WIDTH - (rowImgCount + 1) * 10) / rowImgCount;
        }
        CGFloat row = self.photoView.dataArr.count / rowImgCount;
        W = (row + 1) * (W + 10) + 10;
        [self.photoView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.empyView.bottom).offset(1);
            make.left.right.equalTo(self.view);
            make.height.equalTo(W + 20);
        }];
    
    }

    [_aninymityView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.photoView.bottom).offset(1);
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

- (StarsView *)starview {

    if (!_starview) {
        _starview = [[StarsView alloc] initWithStarSize:CGSizeMake(15, 15) space:5 numberOfStar:5];
        _starview.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _starview.score = 0;
    }

    return _starview;
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
        _photoView.maxCount = ImgTotalCount;
        __weak typeof(self) weakSelf = self;
        __weak typeof(_photoView) weakPhoto = _photoView;
        
        _photoView.addBlock = ^(){
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            weakPhoto.pictureCounts++;
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    [weakPhoto.dataArr addObject:photos[0]];
                    weakPhoto.pictureCounts = weakPhoto.dataArr.count;
                    [weakPhoto.collectionView reloadData];
                    [weakSelf addControllers];
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        _photoView.deleteBlock = ^() {
        
            [weakSelf addControllers];
        };
        _photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    }
    return _photoView;
}

- (AnonymityAssessView *)aninymityView {

    if (!_aninymityView) {
        _aninymityView = [[AnonymityAssessView alloc] init];
        _aninymityView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _aninymityView.realBlock = ^(BOOL isReal){
            _isReal = isReal;
        };
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
    
    if (self.starview.startCount == 0) {
            [self showAlert:@"您确定评分为0吗?"];
        }
        
    NSString * contentStr = self.commentTextFiled.text;
    
    if (contentStr.length == 0) {
        
        [self showAlert:@"评价内容不能为空"];
        
    } else {
        if (self.photoView.dataArr.count == 0) {
            
            [self showAlert:@"上传图片不能为空"];
        } else {
            DLog(@"%ld",self.starview.startCount);
            [self OrderAssessRequest];
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
