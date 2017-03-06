//
//  SellerCreateDogMessageViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//
#define ImgCount 6
#define kMaxLength 8
#define kNoteLength 40

#import "SellerCreateDogMessageViewController.h"
#import "AddUpdataImagesView.h" // 添加狗狗图片

#import "AddDogAgeAlertView.h" // 年龄
#import "DogSizeFilter.h" // 体型
#import "SellerAddImpressViewController.h" //印象
#import "AddDogColorAlertView.h" // 狗狗颜色
#import "SellerShipTemplateView.h" // 运费模板
#import "SellerShipTemplateModel.h"

#import "SellerSearchDogtypeViewController.h" // 狗狗品种
#import "NSString+CertificateImage.h"

@interface SellerCreateDogMessageViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UIButton *sureBtn; /**< 确认按钮 */

@property(nonatomic, strong) UITextField *nameText; /**< 名字编辑 */

@property(nonatomic, strong) UIButton *noneNameBtn; /**< 未起名按钮 */

@property(nonatomic, strong) UITextField *priceText; /**< 一口价 */

@property (nonatomic, assign) CGFloat price; /**< 价格 */

@property(nonatomic, strong) UILabel *deposit; /**< 定价 */

@property(nonatomic, strong) UITextField *noteText; /**< 补充 */

@property(nonatomic, strong) UILabel *countLabel; /**< 字数 */
@property(nonatomic, strong) UILabel *shipLabel; /**< 模板名字 */
@property(nonatomic, strong) SellerShipTemplateModel *shipModel; /**< 模板名字 */
@property(nonatomic, assign) BOOL isHaveDian; /**< 小数点 */

@property(nonatomic, assign) BOOL isFirstZero; /**< 首位为0 */

@property(nonatomic, strong) UILabel *ageLabel; /**< 年龄 */
@property(nonatomic, assign) NSInteger age; /**< 年龄 */
@property(nonatomic, strong) UILabel *sizeLabel; /**< 体型 */
@property(nonatomic, strong) DogCategoryModel *sizeModel; /**< 体型 */
@property(nonatomic, strong) UILabel *colorLabel; /**< 颜色 */
@property(nonatomic, strong) DogCategoryModel *colorModel; /**< 颜色 */
@property(nonatomic, strong) UILabel *typeLabel; /**< 品种 */
@property(nonatomic, strong) DogCategoryModel *typeModel; /**< 品种 */
@property(nonatomic, strong) UILabel *impressLabel; /**< 印象 */
@property(nonatomic, strong) NSMutableArray *impressModels; /**< 印象数组 */

@property(nonatomic, strong) NSMutableArray *photoArr; /**< 图片数组 */

@property(nonatomic, strong) NSMutableArray *photoUrl; /**< 图片地址 */

@end

static NSString *cellid = @"SellerCreateDogMessage";

@implementation SellerCreateDogMessageViewController
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI{
    self.title = @"新建狗狗";
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.tableView];
    
    [self.sureBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.sureBtn.top);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editingDogName:) name:@"UITextFieldTextDidChangeNotification" object:self.nameText];
    self.price = 0;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDogImpression:) name:@"DogImpress" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDogType:) name:@"DogType" object:nil];
}
- (void)changeDogType:(NSNotification *)notification {
    self.typeModel = (DogCategoryModel *)notification.userInfo[@"Type"];
    DLog(@"%@", notification.userInfo[@"Type"]);
    self.typeLabel.attributedText = [self getCellTextWith:self.typeModel.name];
}
- (void)changeDogImpression:(NSNotification *)notification {

    DLog(@"%@", notification.userInfo[@"Impress"]);
    [self.impressModels removeAllObjects];
    self.impressModels = [notification.userInfo[@"Impress"] mutableCopy];
    DLog(@"%@", self.impressModels);
    NSMutableString *impress = [NSMutableString string];

    for (NSInteger i = 0; i < self.impressModels.count; i ++) {
        DogCategoryModel *model = self.impressModels[i];
        [impress appendFormat:@"#%@# ", model.name];
    }
    
    self.impressLabel.attributedText = [self getCellTextWith:impress];
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithArray:@[@"狗狗名字（最多8个汉字）", @"年龄", @"体型", @"品种", @"颜色", @"¥ 一口价", @"¥ 定金", @"印象", @"补充", @"运费设置"]];
    }
    return _dataArr;
}
- (NSMutableArray *)impressModels {
    if (!_impressModels) {
        _impressModels = [NSMutableArray array];
    }
    return _impressModels;
}
- (NSMutableArray *)photoArr {
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}
- (NSMutableArray *)photoUrl {
    if (!_photoUrl) {
        _photoUrl = [NSMutableArray array];
    }
    return _photoUrl;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.bounces = NO;
    }
    return _tableView;
}
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _sureBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [_sureBtn setTitle:@"确认添加" forState:(UIControlStateNormal)];
        [_sureBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_sureBtn addTarget:self action:@selector(clickSureButtonAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _sureBtn;
}
- (void)clickSureButtonAction {
    [self textFieldShouldReturn:self.nameText];
    [self textFieldShouldReturn:self.priceText];
    [self textFieldShouldReturn:self.noteText];
    if (self.nameText.text.length == 0) {
        self.nameText.text = @"(未起名)";
    }
    if (self.age == 0) {
        [self showAlert:@"请选择狗狗年龄"];
    }else {
        if (self.sizeModel.name.length == 0) {
            [self showAlert:@"请选择狗狗体型"];
        }else {
            if (self.typeModel.name.length == 0) {
                [self showAlert:@"请选择狗狗品种"];
            }else {
                if (self.colorModel.name.length == 0) {
                    [self showAlert:@"请选择狗狗颜色"];
                }else {
                    if (self.price == 0) {
                        [self showAlert:@"请输入狗狗价格"];
                    }else {
                        
                        if ([self.impressModels count] == 0) {
                            [self showAlert:@"请选择狗狗印象"];
                        }else {
                            if (self.photoArr.count == 0) {
                                [self showAlert:@"请添加狗狗图片"];
                            }else {
                                if ([self.noteText.text isEqualToString:@"补充"] || self
                                    .noteText.text.length == 0) {
                                    [self showAlert:@"请输入补充内容"];
                                }else{
                                    if (self.shipModel.name.length == 0) {
                                        [self showAlert:@"请选择运费模板"];
                                    }else{
                                        //                                self.sureBtn.enabled = NO;
                                        
                                        // 印象id字符串
                                        NSMutableArray *impresArr = [NSMutableArray array];
                                        for (NSInteger i = 0; i < self.impressModels.count; i ++) {
                                            DogCategoryModel *model = self.impressModels[i];
                                            [impresArr addObject:model.ID];
                                        }
                                        NSString *idStr = [impresArr componentsJoinedByString:@"|"];
                                        // 图片地址
                                        [self.photoUrl removeAllObjects];
                                        for (NSInteger i = 0; i < self.photoArr.count; i ++) {
                                            NSString *base64 = [NSString imageBase64WithDataURL:self.photoArr[i] withSize:CGSizeMake(SCREEN_WIDTH / 2, SCREEN_WIDTH / 2)];
                                            NSDictionary *dict = @{
                                                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                                                   @"img":base64
                                                                   };
                                            
                                            [self postRequestWithPath:API_UploadImg params:dict success:^(id successJson) {
                                                if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                                                    
                                                    [self.photoUrl addObject:successJson[@"data"]];
                                                    // 提交商品
                                                    if (self.photoUrl.count == self.photoArr.count) {
                                                        NSString *imgStr = [self.photoUrl componentsJoinedByString:@"|"];
                                                        NSDictionary *dict = @{
                                                                               @"create_user":[UserInfos sharedUser].ID,
                                                                               @"name":self.nameText.text,
                                                                               @"color_id":self.colorModel.ID,
                                                                               @"kind_id":self.typeModel.ID,
                                                                               @"size_id":self.sizeModel.ID,
                                                                               @"age_time":@(self.age),
                                                                               @"age_name":self.ageLabel.text,
                                                                               @"price_old":self.priceText.text,
                                                                               @"price":self.priceText.text,
                                                                               @"deposit":self.deposit.text,
                                                                               @"comment":self.noteText.text,
                                                                               @"impresssion_id":idStr,
                                                                               @"path_big":imgStr,
                                                                               @"trafic_template":@(self.shipModel.ID)                                                                           };
                                                        DLog(@"%@",dict);
                                                        [self postRequestWithPath:API_Add_product params:dict success:^(id successJson) {
                                                            DLog(@"%@", successJson);
                                                            [self showAlert:successJson[@"message"]];
                                                            DLog(@"%@", self.photoArr);
                                                            if ([successJson[@"message"] isEqualToString:@"添加成功"]) {
                                                                [self.navigationController popViewControllerAnimated:YES];
                                                            }else if ([successJson[@"message"] isEqualToString:@"参数不能为空"]){
                                                                //                                                        self.sureBtn.enabled = YES;
                                                            }
                                                        } error:^(NSError *error) {
                                                            DLog(@"%@", error);
                                                        }];
                                                    }
                                                }
                                                
                                                DLog(@"%@", successJson);
                                            } error:^(NSError *error) {
                                                DLog(@"%@", error);
                                            }];
                                        }
                                    }
                                }
                            }
                        }
                    }   
                }
            }
        }
    }
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"";
            UIButton *noneNameBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [noneNameBtn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
            [noneNameBtn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
            // 偏移量
            [noneNameBtn setTitleEdgeInsets:(UIEdgeInsetsMake(0, 0, 0, -10))];
            
            [noneNameBtn setTitle:@"还未起名" forState:(UIControlStateNormal)];
            [noneNameBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:(UIControlStateNormal)];
            noneNameBtn.titleLabel.font = [UIFont systemFontOfSize:14];
            [noneNameBtn addTarget:self action:@selector(clickNoneNameBtnAction:) forControlEvents:(UIControlEventTouchDown)];
            noneNameBtn.frame = CGRectMake(0, 0, 100, 44);
            [cell.contentView addSubview:noneNameBtn];
            self.noneNameBtn = noneNameBtn;
            
            UITextField *nameText = [[UITextField alloc] initWithFrame:CGRectMake(110, 11 / 2, 200, 33)];
            nameText.placeholder = self.dataArr[0];
            nameText.font = [UIFont systemFontOfSize:14];
            nameText.delegate = self;
            self.nameText = nameText;
            [cell.contentView addSubview:nameText];
        }
            break;
            case 1:
        {
            UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 44)];
            ageLabel.attributedText = [self getCellTextWith:self.dataArr[1]];
            
            self.ageLabel = ageLabel;
            [cell.contentView addSubview:ageLabel];
        }
            break;
        case 2:
        {
            UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 44)];
            sizeLabel.attributedText = [self getCellTextWith:self.dataArr[2]];
            
            self.sizeLabel = sizeLabel;
            [cell.contentView addSubview:sizeLabel];
        }
            break;
        case 3:
        {
            
            UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 44)];
            typeLabel.attributedText = [self getCellTextWith:self.dataArr[3]];
            
            self.typeLabel = typeLabel;
            [cell.contentView addSubview:typeLabel];
        }
            break;
        case 4:
        {
            UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 44)];
            colorLabel.attributedText = [self getCellTextWith:self.dataArr[4]];
            
            self.colorLabel = colorLabel;
            [cell.contentView addSubview:colorLabel];
        }
            break;

        case 5:
        {
            // 一口价
            cell.textLabel.text = @"";
            
            UITextField *pricetext = [[UITextField alloc] initWithFrame:CGRectMake(13, 11 / 2, 200, 44)];
            pricetext.attributedPlaceholder = [self getAttributeWith:self.dataArr[5]];
            pricetext.font = [UIFont systemFontOfSize:14];
            pricetext.delegate = self;
            pricetext.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            self.priceText = pricetext;
            [pricetext addTarget:self action:@selector(pricetextEditAction:) forControlEvents:(UIControlEventEditingChanged)];

            [cell.contentView addSubview:pricetext];
            
        }
            break;
        case 6:
        {
            // 定金
            cell.textLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
            UILabel *deposit = [[UILabel alloc] initWithFrame:CGRectMake(13, 0, 80, 44)];
            deposit.text  = self.dataArr[6];
            deposit.font = [UIFont systemFontOfSize:14];
            deposit.textColor = [UIColor colorWithHexString:@"#000000"];
            self.deposit = deposit;
            [cell.contentView addSubview:deposit];

            // 定金提示
            UILabel *depositabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 11 / 2, 200, 33)];
            depositabel.text = @"默认为总价的10%";
            depositabel.font = [UIFont systemFontOfSize:12];
            depositabel.textColor = [UIColor colorWithHexString:@"#999999"];
            [cell.contentView addSubview:depositabel];
            
        }
            break;
        case 7:
        {
            UILabel *impressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 44)];
            impressLabel.attributedText = [self getCellTextWith:self.dataArr[7]];
            
            self.impressLabel = impressLabel;
            [cell.contentView addSubview:impressLabel];
        }
            break;

        case 8:
        {
            // 补充
            cell.textLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
            UITextField *noteText = [[UITextField alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 40 - 15, 44)];
            
            noteText.attributedPlaceholder = [self getAttributeWith:self.dataArr[8]];
            noteText.font = [UIFont systemFontOfSize:14];
            noteText.delegate = self;
            [noteText addTarget:self action:@selector(noteTextEditAction:) forControlEvents:(UIControlEventEditingChanged)];
            self.noteText = noteText;
            [cell.contentView addSubview:noteText];
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, 13, 40, 15)];
            label.font = [UIFont systemFontOfSize:12];
            label.textColor = [UIColor colorWithHexString:@"#999999"];
            
            label.text = @"0/40";
            self.countLabel = label;
            [cell.contentView addSubview:label];
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
        case 9:
        {
            cell.textLabel.text = @"运费模板";
            cell.textLabel.font = [UIFont systemFontOfSize:14];

            cell.detailTextLabel.text = @"模板-运费";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
            self.shipLabel = cell.detailTextLabel;
        }
            break;
        default:
            break;
    }
    return cell;
}
#pragma mark - 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        
            break;
        case 1:
        {
            [self textFieldShouldReturn:self.nameText];
            [self textFieldShouldReturn:self.priceText];
            [self textFieldShouldReturn:self.noteText];
            AddDogAgeAlertView *ageView = [[AddDogAgeAlertView alloc] init];
            [ageView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            
            ageView.ageBlock = ^(NSInteger age){
                self.ageLabel.attributedText = [self getCellTextWith:[NSString getAgeFormInt:age]];
                self.age = age;
                DLog(@"%@", [NSString getAgeFormInt:age]);
                DLog(@"%ld", age);
            };
        }
            break;
        case 2:
        {
            [self textFieldShouldReturn:self.nameText];
            [self textFieldShouldReturn:self.priceText];
            [self textFieldShouldReturn:self.noteText];
            
            DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
            sizeView.title = @"体型";
            
            NSDictionary *dict = @{
                                   @"type":@(4)
                                   };
                       [self getRequestWithPath:API_Category params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                           if (successJson) {
                              
                               sizeView.dataArr = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                               
                               [sizeView show];
                           }

            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];

            
            //            __weak typeof(sizeView) weakView = sizeView;
            sizeView.bottomBlock = ^(DogCategoryModel *size){
                DLog(@"%@", size);
                self.sizeLabel.attributedText = [self getCellTextWith:size.name];
                self.sizeModel = size;
            };
        }
            break;
        case 3:
        {
            // 狗狗品种
            SellerSearchDogtypeViewController *dogTypeVC = [[SellerSearchDogtypeViewController alloc] init];
            
            dogTypeVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:dogTypeVC animated:YES];
        }
            break;
        case 4:
        {
            [self textFieldShouldReturn:self.nameText];
            [self textFieldShouldReturn:self.priceText];
            [self textFieldShouldReturn:self.noteText];
            AddDogColorAlertView *colorView = [[AddDogColorAlertView alloc] init];
            
            NSDictionary *dict = @{
                                   @"type":@(2)
                                   };
            [self getRequestWithPath:API_Category params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                colorView.dataPlist = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            colorView.colorBlock = ^(DogCategoryModel *color){
                self.colorLabel.attributedText = [self getCellTextWith:color.name];
                self.colorModel = color;
            };
            [colorView show];
        }
            break;
        case 7:
        {
            [self textFieldShouldReturn:self.nameText];
            [self textFieldShouldReturn:self.priceText];
            [self textFieldShouldReturn:self.noteText];
            
            SellerAddImpressViewController *impressVC = [[SellerAddImpressViewController alloc] init];
            
            [self.navigationController pushViewController:impressVC animated:YES];
        }
            break;
        case 9:
        {
        [self textFieldShouldReturn:self.nameText];
        [self textFieldShouldReturn:self.priceText];
        [self textFieldShouldReturn:self.noteText];
        
        
            SellerShipTemplateView *shipTemplateView = [[SellerShipTemplateView alloc] init];

            //请求运费模板
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"page":@1,
                                   @"pageSize":@10
                                   };
            [self getRequestWithPath:API_List_freight params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                shipTemplateView.detailPlist = [SellerShipTemplateModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
                [shipTemplateView show];
                [shipTemplateView reloadData];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        
            shipTemplateView.sureBlock = ^(SellerShipTemplateModel *templateType){
                DLog(@"%@", templateType);
                NSString *cost = @"";
                if (templateType.type == 0) { //模板类型 0运费模版 1免运费 2按时计算
                    cost = templateType.money;
                }else  if(templateType.type == 1) {
                    cost = @"免运费";
                }else if(templateType.type == 2) {
                    cost = @"按实结算";
                }
                self.shipLabel.text = cost;
                self.shipModel = templateType;
            };
        }
            break;
        default:
            break;
    }
}
#pragma mark - 头尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        __block CGFloat W = 0;
        if (ImgCount <= kMaxImgCount) {
            W = (SCREEN_WIDTH - (ImgCount + 1) * 10) / ImgCount;
        }else{
            W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
        }
        AddUpdataImagesView *photoView = [[AddUpdataImagesView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, W + 20)];
        photoView.maxCount = ImgCount;
        
        __weak typeof(self) weakSelf = self;
        __weak typeof(photoView) weakPhoto = photoView;
        photoView.addBlock = ^(){
            
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.isSelectOriginalPhoto = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;

            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    [weakPhoto.dataArr addObject:photos[0]];
                    
                    [weakPhoto.collectionView reloadData];
                    weakSelf.photoArr = weakPhoto.dataArr;
                    CGFloat row = weakPhoto.dataArr.count / kMaxImgCount;
                    CGRect rect = weakPhoto.frame;
                    rect.size.height = (row + 1) * (W + 10) + 10;
                    weakPhoto.frame = rect;
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        photoView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        return photoView;
    }
    return nil;
}
#pragma mark - 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
#pragma mark
#pragma mark - Action
- (void)clickNoneNameBtnAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    // 设置编辑隐藏
    self.nameText.hidden = btn.selected;
}
- (void)pricetextEditAction:(UITextField *)textField{
    if ([textField.text floatValue] > 30000) {
        textField.text = @"30000";
    }
    if ([textField.text isEqualToString:@""]) {
        self.deposit.text = @"¥ 定价";
    }else{
        self.deposit.text = [NSString stringWithFormat:@"%0.2lf", [textField.text floatValue] / 10];
    }
    if (textField.text.length == 0) {
        self.price = 0;
    }else{
        self.price = [textField.text floatValue];
    }
}
- (void)noteTextEditAction:(UITextField *)textField {
    if (textField.text.length >= 40) {
        self.countLabel.text = @"40/40";
    }else{
        self.countLabel.text = [NSString stringWithFormat:@"%lu/40", textField.text.length];
    }
}
#pragma mark
#pragma mark - UItextField代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
        
    if (textField == self.priceText) {
        
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            _isHaveDian = NO;
        }
        if ([textField.text rangeOfString:@"0"].location==NSNotFound) {
            _isFirstZero = NO;
        }
        
        if ([string length]>0)
        {
            unichar single=[string characterAtIndex:0];//当前输入的字符
            if ((single >='0' && single<='9') || single=='.')//数据格式正确
            {
                
                if([textField.text length]==0){
                    if(single == '.'){
                        //首字母不能为小数点
                        return NO;
                    }
                    if (single == '0') {
                        _isFirstZero = YES;
                        return YES;
                    }
                }
                
                if (single=='.'){
                    if(!_isHaveDian)//text中还没有小数点
                    {
                        _isHaveDian=YES;
                        return YES;
                    }else{
                        return NO;
                    }
                }else if(single=='0'){
                    if ((_isFirstZero&&_isHaveDian)||(!_isFirstZero&&_isHaveDian)) {
                        //首位有0有.（0.01）或首位没0有.（10200.00）可输入两位数的0
                        if([textField.text isEqualToString:@"0.0"]){
                            return NO;
                        }
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt=(int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if (_isFirstZero&&!_isHaveDian){
                        //首位有0没.不能再输入0
                        return NO;
                    }else{
                        return YES;
                    }
                }else{
                    if (_isHaveDian){
                        //存在小数点，保留两位小数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        int tt= (int)(range.location-ran.location);
                        if (tt <= 2){
                            return YES;
                        }else{
                            return NO;
                        }
                    }else if(_isFirstZero&&!_isHaveDian){
                        //首位有0没点
                        return NO;
                    }else{
                        return YES;
                    }
                }
            }else{
                //输入的数据格式不正确
                return NO;
            }
        }else{
            return YES;
        }
    }
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == self.nameText) {
        self.noneNameBtn.hidden = YES;
        CGRect rect = textField.frame;
        rect.origin.x = 10;
        textField.frame = rect;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.tableView.frame;
            rect.origin.y = 0;
            self.tableView.frame= rect;
        }];
    }else {
        //键盘高度
        [UIView animateWithDuration:0.3 animations:^{
            CGRect rect = self.tableView.frame;
            rect.origin.y = (- 264) + 10;
            self.tableView.frame= rect;
        }];
    }
    
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.nameText) {
        if (textField.text.length == 0) {
            self.noneNameBtn.hidden = NO;
            CGRect rect = textField.frame;
            rect.origin.x = 110;
            textField.frame = rect;
        }
    }else{
        
    }
    [UIView animateWithDuration:0.3 animations:^{
        [textField resignFirstResponder];
        CGRect rect = self.tableView.frame;
        rect.origin.y = 0;
        self.tableView.frame= rect;
    }];
    
    return YES;
}
- (void)editingDogName:(NSNotification *)notification {
    UITextField *textField = (UITextField *)notification.object;
    if (textField == self.nameText){
        NSString *toBeString = textField.text;
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > kMaxLength) {
                    textField.text = [toBeString substringToIndex:kMaxLength];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
    }
    if (textField == self.noteText){
        NSString *toBeString = textField.text;
        NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式
        if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
            UITextRange *selectedRange = [textField markedTextRange];
            //获取高亮部分
            UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
            // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (!position) {
                if (toBeString.length > kNoteLength) {
                    textField.text = [toBeString substringToIndex:kNoteLength];
                }
            }
            // 有高亮选择的字符串，则暂不对文字进行统计和限制
            else{
                
            }
        }
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        else{
            if (toBeString.length > kNoteLength) {
                textField.text = [toBeString substringToIndex:kNoteLength];
            }
        }
    }
   
}
- (NSAttributedString *)getAttributeWith:(NSString *)string{
    NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"],
                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                                                                  }];
    return attribut;
}
- (NSAttributedString *)getCellTextWith:(NSString *)string {
  NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"],
                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                                                        }];
    return attribute;
}

- (void)dealloc {
    // 释放通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DogImpress" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"DogType" object:nil];
}
@end
