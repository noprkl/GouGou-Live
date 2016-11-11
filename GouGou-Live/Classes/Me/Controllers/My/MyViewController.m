//
//  MyViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyViewController.h"
#import "MyUnLoginView.h"
#import "MyMessageView.h"

#import "LoginViewController.h"

#import "MyFansViewController.h"
#import "MyFocusViewController.h"
#import "MyPageViewController.h"



@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray  *dataSource;

/** 控制器名字 */
@property (strong, nonatomic) NSArray *controllerNames;

/** headBtn */
@property (strong, nonatomic) UIButton *myButton;



@end

@implementation MyViewController

#pragma mark
#pragma mark - 网络请求
// 用户账单
- (void)postGetUserAsset:(NSDictionary *)data {

    DLog(@"%@",data[@"id"]);
    
//    NSDictionary *dict = @{
//                           @"uid":@([data[@"id"] integerValue]),
//                           @"page":@0
//                           };
//    
//    [self postRequestWithPath:API_UserAsset params:dict success:^(id successJson) {
//        DLog(@"%@",successJson);
//   
//    } error:^(NSError *error) {
//       
//        DLog(@"%@", error);
//    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
   
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];

//    self.navigationController.navigationBarHidden = NO;
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoginSuccessData:) name:@"LoginSuccess" object:nil];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getLoginSuccessData:) name:@"CodeLoginSuccess" object:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setAlpha:1];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)initUI {

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
}

- (void)getLoginSuccessData:(NSNotification *)notification {

    DLog(@"%@",notification.userInfo);
    
    [self postGetUserAsset:notification.userInfo];
}

#pragma mark
#pragma mark - 代理
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = @[@[@"账号", @"我的订单", @"收货地址"], @[@"我的喜欢", @"观看历史"], @[@"实名认证", @"商家认证"], @[@"设置"]];
    }
    return _dataSource;
}

- (NSArray *)controllerNames {

    if (!_controllerNames) {
        _controllerNames = @[@[@"AccountViewController", @"OrderGoodsViewController", @"ShopAddressViewController"], @[@"FavoriteViewController", @"WatchHistoryViewController"], @[@"CertificateViewController", @"MerchantViewController"],@[@"SettingViewController"]];
    }
    return _controllerNames;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
//        return 150;
        return 250;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"myCellId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    
    cell.detailTextLabel.attributedText = [[NSAttributedString alloc] initWithString:self.dataSource[indexPath.section][indexPath.row] attributes:@{
                                                                                                                                                   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                                                                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:self.dataSource[indexPath.section][indexPath.row] attributes:@{
                                                                                                                                              NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                                                                                                                              NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = self.dataSource[indexPath.section][indexPath.row];
    
    NSString *controllerName = self.controllerNames[indexPath.section][indexPath.row];
    
    UIViewController *VC = [[NSClassFromString(controllerName) alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    VC.title = cellText;
    
    
    [self.navigationController pushViewController:VC animated:YES];
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        //判断登录与否
//        MyUnLoginView *unLoginView = [[MyUnLoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
//        unLoginView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
//        __weak typeof(self) weakSelf = self;
//        unLoginView.loginBlcok = ^(){
//            LoginViewController *VC = [[LoginViewController alloc] init];
//            
//            VC.hidesBottomBarWhenPushed = YES;
//            
//            [weakSelf.navigationController pushViewController:VC animated:YES];
//        };

//        return unLoginView;
        MyMessageView *messageView = [[MyMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
        messageView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
        __weak typeof(self) weakSelf = self;

        // 实名认证
        messageView.liveBlcok = ^(UIButton *btn){
            
        };
        
        // 关注
        messageView.focusBlcok = ^(){
            MyFocusViewController *myfocus = [[MyFocusViewController alloc] init];
            myfocus.hidesBottomBarWhenPushed = YES;
            
            [weakSelf.navigationController pushViewController:myfocus animated:YES];
        };
        // 粉丝
        messageView.fansBlcok = ^(){
            MyFansViewController *myFansVC = [[MyFansViewController alloc] init];
            myFansVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:myFansVC animated:YES];
        };
        // 我的主页
        messageView.myPageBlcok = ^(){
            MyPageViewController *myPage = [[MyPageViewController alloc] init];
            myPage.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:myPage animated:YES];
        };
        
        return messageView;
    }
    return nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
