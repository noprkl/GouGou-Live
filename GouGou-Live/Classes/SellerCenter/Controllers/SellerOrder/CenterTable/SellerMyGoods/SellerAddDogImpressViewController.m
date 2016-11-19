//
//  SellerAddDogImpressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAddDogImpressViewController.h"
#import "AddDogPictures.h" // 添加狗狗图片

#import "DogAgeFilter.h" // 年龄
#import "DogSizeFilter.h" // 体型
#import "AddDogColorAlertView.h" // 狗狗颜色

@interface SellerAddDogImpressViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) UIButton *sureBtn; /**< 确认按钮 */

@end

static NSString *cellid = @"SellerAddDogImpress";

@implementation SellerAddDogImpressViewController
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
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
        _dataArr = @[@"狗狗名字", @"年龄", @"体型", @"品种", @"颜色", @"¥ 一口价", @"¥ 定金", @"印象", @"补充", @"运费设置"];
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
    
    cell.textLabel.text = self.dataArr[indexPath.row];

    // 设置箭头
    if (indexPath.row == 6 || indexPath.row == 8) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    // 文字
    if (indexPath.row == 8) {
        cell.detailTextLabel.text = @"0/40";
    }
    if (indexPath.row == 9) {
        cell.detailTextLabel.text = @"模板-免费运";
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
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
            
        case 4:
        {
            AddDogColorAlertView *colorView = [[AddDogColorAlertView alloc] init];
            colorView.colorBlock = ^(NSString *color){
                DLog(@"%@", color);
            };
            [colorView show];
        }
            break;
            
        default:
            break;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        AddDogPictures *addPict = [[AddDogPictures alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        addPict.backgroundColor = [UIColor whiteColor];
        return addPict;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 115;
}
@end
