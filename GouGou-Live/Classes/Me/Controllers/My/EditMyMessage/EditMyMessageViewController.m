//
//  EditMyMessageViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EditMyMessageViewController.h"
#import "DeletePrommtView.h"
#import "DogSizeFilter.h"
#import "EditNikeNameAlert.h"


@interface EditMyMessageViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *topTableView; /**< 顶部TableView */

@property(nonatomic, strong) NSArray *topDataArr; /**< 顶部数据源 */

@property(nonatomic, strong) UITableView *bottomTableView; /**< 底部TableView */
@property(nonatomic, strong) NSArray *botttomDataArr; /**< 底部数据源 */

@property(nonatomic, strong) NSMutableArray *accessosys; /**< witch数组 */

@property(nonatomic, strong) EditNikeNameAlert *editAlert; /**< 编辑框 */

@end

static NSString *cellid = @"cellid";

@implementation EditMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}

- (void)initUI {
    self.title = @"个人资料";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    self.edgesForExtendedLayout = 0;
    
    [self.view addSubview:self.topTableView];
    [self.view addSubview:self.bottomTableView];
    [self makeConstraint];
}
- (void)makeConstraint {
    [self.topTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(220);
    }];
    [self.bottomTableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(176);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)topDataArr {
    if (!_topDataArr) {
        _topDataArr = @[@"头像", @"昵称", @"个性签名", @"手机号"];
    }
    return _topDataArr;
}

- (NSArray *)botttomDataArr {
    if (!_botttomDataArr) {
        _botttomDataArr = @[@"微信", @"腾讯", @"新浪"];
    }
    return _botttomDataArr;
}

- (UITableView *)topTableView {
    if (!_topTableView) {
        _topTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _topTableView.delegate = self;
        _topTableView.dataSource = self;
        [_topTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _topTableView;
}

- (UITableView *)bottomTableView {
    if (!_bottomTableView) {
        _bottomTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _bottomTableView.delegate = self;
        _bottomTableView.dataSource = self;
        [_bottomTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _bottomTableView;
}
- (NSMutableArray *)accessosys {
    if (!_accessosys) {
        _accessosys = [NSMutableArray array];
    }
    return _accessosys;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.topTableView) {
        return self.topDataArr.count;
    }else if (tableView == self.bottomTableView){
        return self.botttomDataArr.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.topTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row == 0) {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 90, (88 - 60) / 2, 60, 60)];
            imageView.image = [UIImage imageNamed:@"头像"];
            [cell.contentView addSubview:imageView];
            
        }else if (indexPath.row == 3) {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.detailTextLabel.text = self.topDataArr[indexPath.row];
            
        }else {
            cell.textLabel.text = self.topDataArr[indexPath.row];
            
            cell.detailTextLabel.text = self.topDataArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        return cell;

    }else if (tableView == self.bottomTableView){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.textLabel.text = self.botttomDataArr[indexPath.row];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        UISwitch *switchBtn = [[UISwitch alloc] init];
        switchBtn.tag = 50 + indexPath.row;
        [switchBtn addTarget:self action:@selector(clickSwitchAction:) forControlEvents:(UIControlEventValueChanged)];
        cell.accessoryView = switchBtn;
        [self.accessosys addObject:switchBtn];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.topTableView) {
        return 0;
        
    }else if (tableView == self.bottomTableView){
        return 44;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.topTableView) {
        if (indexPath.row == 0) {
            return 88;
        }
        return 44;
    }else if (tableView == self.bottomTableView){
        return 44;
    }else{
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.topTableView) {
        switch (indexPath.row) {
            case 0:
            {
                DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
                sizeView.dataArr = @[@"更换头像",@"从相册选择", @"拍照", @"取消"];
                [sizeView show];
                
                //            __weak typeof(sizeView) weakView = sizeView;
                
                sizeView.sizeCellBlock = ^(NSString *type){
                    DLog(@"%@", type);
                };

            }
                break;
            
            case 1:
            {
                EditNikeNameAlert *editNikeAlert = [[EditNikeNameAlert alloc] init];
                [editNikeAlert show];
                
                editNikeAlert.sureBlock = ^(NSString *text){
                    if (![text isEqualToString:@""]) {
                        DLog(@"%@", text);
                    }
                };
                self.editAlert = editNikeAlert;
            }
                break;
            case 2:
            {
                EditNikeNameAlert *editSignAlert = [[EditNikeNameAlert alloc] init];
                
                [editSignAlert show];
                editSignAlert.sureBlock = ^(NSString *text){
                    if (![text isEqualToString:@""]) {
                        DLog(@"%@", text);
                    }
                };
                editSignAlert.title = @"请输入个性签名";
                editSignAlert.placeHolder = @"这个人很懒，他什么也没留下";
                editSignAlert.noteString = @"";
                self.editAlert = editSignAlert;
            }
                break;
            default:
                break;
        }
    }else if (tableView == self.bottomTableView){
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == self.bottomTableView) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        label.text = @"账号绑定";
        label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.font = [UIFont systemFontOfSize:16];
        return label;
    }
    return nil;
}
#pragma mark
#pragma mark - Action
- (void)clickSwitchAction:(UISwitch *)swit {

    NSInteger index = swit.tag - 50;
    UISwitch *switc = (UISwitch *)self.accessosys[index];
    
    if (index == 0) {
        BOOL isButtonOn = [switc isOn];
        if (isButtonOn) {
            DLog(@"微信绑定");
        }else {
           
            DeletePrommtView *WXprommt = [[DeletePrommtView alloc] init];
            WXprommt.message = @"你确定解绑微信？";
            [WXprommt show];
            WXprommt.sureDeleteBtnBlock = ^(UIButton *btn){
                DLog(@"微信解绑");
            };
            WXprommt.cancelBlock = ^(){
                switc.on = YES;
                DLog(@"不解除");
            };
            
        }
    }else if (index == 1){
        BOOL isButtonOn = [switc isOn];
        if (isButtonOn) {
            DLog(@"腾讯绑定");
        }else {
            DeletePrommtView *Tencetprommt = [[DeletePrommtView alloc] init];
            Tencetprommt.message = @"你确定解绑腾讯？";
            [Tencetprommt show];
            Tencetprommt.sureDeleteBtnBlock = ^(UIButton *btn){
                DLog(@"腾讯解绑");
            };
            Tencetprommt.cancelBlock = ^(){
                switc.on = YES;
                DLog(@"不解除");
            };
        }

    }else if (index == 2){
        BOOL isButtonOn = [switc isOn];
        if (isButtonOn) {
            DLog(@"新浪绑定");
        }else {
            DeletePrommtView *Sinaprommt = [[DeletePrommtView alloc] init];
            Sinaprommt.message = @"你确定解绑新浪？";
            [Sinaprommt show];
            Sinaprommt.sureDeleteBtnBlock = ^(UIButton *btn){
                DLog(@"新浪解绑");
            };
            Sinaprommt.cancelBlock = ^(){
                switc.on = YES;
                DLog(@"不解除");
            };
        }

    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end