//
//  SellerCreateDogMessageViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerCreateDogMessageViewController.h"
#import "AddDogPictures.h" // 添加狗狗图片

#import "DogAgeFilter.h" // 年龄
#import "DogSizeFilter.h" // 体型
#import "SellerAddImpressViewController.h" //印象
#import "AddDogColorAlertView.h" // 狗狗颜色
#import "SellerShipTemplateView.h" // 运费模板
#import "SellerSearchDogtypeViewController.h" // 狗狗品种

@interface SellerCreateDogMessageViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UIButton *sureBtn; /**< 确认按钮 */

@property(nonatomic, strong) UITextField *nameText; /**< 名字编辑 */

@property(nonatomic, strong) UIButton *noneNameBtn; /**< 未起名按钮 */

@property(nonatomic, strong) UITextField *priceText; /**< 一口价 */

@property(nonatomic, strong) UILabel *deposit; /**< 定价 */

@property(nonatomic, strong) UITextField *noteText; /**< 补充 */

@property(nonatomic, assign) NSInteger count; /**< 字数 */

@property(nonatomic, assign) BOOL isHaveDian; /**< 小数点 */

@property(nonatomic, assign) BOOL isFirstZero; /**< 首位为0 */

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
    
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithArray:@[@"狗狗名字（最多8个汉字）", @"年龄", @"体型", @"品种", @"颜色", @"¥ 一口价", @"¥ 定金", @"印象", @"补充", @"运费设置"]];
    }
    return _dataArr;
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
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:self.dataArr[indexPath.row] attributes:@{
                                                                                                                        NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"],
                                                                                                                        NSFontAttributeName:[UIFont systemFontOfSize:14]
                                                                                                                        }];
    
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
        case 5:
        {
            // 一口价
            cell.textLabel.text = @"";
            
            UITextField *pricetext = [[UITextField alloc] initWithFrame:CGRectMake(13, 11 / 2, 80, 44)];
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
        case 8:
        {
            // 补充
            cell.textLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryNone;
            UITextField *noteText = [[UITextField alloc] initWithFrame:CGRectMake(13, 0, 300, 44)];
            
            noteText.attributedPlaceholder = [self getAttributeWith:self.dataArr[8]];
            noteText.font = [UIFont systemFontOfSize:14];
            noteText.delegate = self;
            [noteText addTarget:self action:@selector(noteTextEditAction:) forControlEvents:(UIControlEventEditingChanged)];
            self.noteText = noteText;
            [cell.contentView addSubview:noteText];
            
            self.count = 0;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld/40", self.count];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
        case 9:
        {
            cell.detailTextLabel.text = @"模板-免费运";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
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
            DogAgeFilter *ageView = [[DogAgeFilter alloc] init];
            ageView.dataPlist = @[@"不限", @"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月", @"1岁", @"2岁", @"3岁", @"4岁", @"5岁", @"6岁", @"7岁", @"以上"];
            [ageView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            
            ageView.ageRangeBlock = ^(NSString *minString, NSString *maxString){
                
                DLog(@"%@--%@", minString, maxString);
            };
        }
            break;
        case 2:
        {
            DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
            sizeView.dataArr = @[@"体型",@"大型犬", @"中型犬", @"小型犬", @"不限", @"确定"];
            [sizeView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            sizeView.bottomBlock = ^(NSString *size){
                DLog(@"%@", size);
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
            AddDogColorAlertView *colorView = [[AddDogColorAlertView alloc] init];
            colorView.colorBlock = ^(NSString *color){
                DLog(@"%@", color);
            };
            [colorView show];
        }
            break;
        case 7:
        {
            SellerAddImpressViewController *impressVC = [[SellerAddImpressViewController alloc] init];
            
            [self.navigationController pushViewController:impressVC animated:YES];
        }
            break;
        case 9:
        {
            SellerShipTemplateView *shipTemplateView = [[SellerShipTemplateView alloc] init];
            shipTemplateView.sureBlock = ^(NSString *templateType){
                DLog(@"%@", templateType);
            };
            shipTemplateView.detailPlist = @[@"免费", @"运费50,按实结算", @"50"];
            [shipTemplateView show];
        }
            break;
        default:
            break;
    }
}
#pragma mark - 头尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        AddDogPictures *addPict = [[AddDogPictures alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        addPict.backgroundColor = [UIColor whiteColor];
        return addPict;
    }
    return nil;
}
#pragma mark - 高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 115;
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
}
- (void)noteTextEditAction:(UITextField *)textField {
    self.count = textField.text.length;
}
#pragma mark
#pragma mark - UItextField代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.nameText ) { // 名字
        
        BOOL isChinese = [string isChinese];
        if (range.location < 8 && isChinese) {
            
            return YES;
        }
        return NO;
    }
    
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
            rect.origin.y = (- 264) + 64;
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
- (NSAttributedString *)getAttributeWith:(NSString *)string{
    NSAttributedString *attribut = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                  NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"],
                                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                                                                  }];
    return attribut;
}

@end
