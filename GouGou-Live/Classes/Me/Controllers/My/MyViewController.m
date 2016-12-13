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

#import "EditMyMessageViewController.h"
#import "MyFansViewController.h"
#import "MyFocusViewController.h"
#import "MyPageViewController.h"

#import "MerchantViewController.h" //商家认证
#import "CreateLiveViewController.h" // 创建直播
#import "FocusAndFansModel.h" 

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray  *dataSource;

/** 控制器名字 */
@property (strong, nonatomic) NSArray *controllerNames;

/** headBtn */
@property (strong, nonatomic) UIButton *myButton;

@property(nonatomic, strong) NSArray *fansArray; /**< 粉丝数据 */
@property(nonatomic, strong) NSArray *focusArray; /**< 关注数据 */

@property(nonatomic, strong) NSString *userAsset; /**< 用户资产 */

@end

@implementation MyViewController

#pragma mark
#pragma mark - 网络请求
// 用户账单
- (void)postGetUserAsset {
    
    NSDictionary *dict = @{// [[UserInfos sharedUser].ID integerValue]
                           @"uid":@([[UserInfos sharedUser].ID intValue]),
                           };
    
  [self postRequestWithPath:API_UserAsset params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
      if ([successJson[@"message"] isEqualToString:@"请求成功"]) {
           self.userAsset = successJson[@"data"][@"asset"];
      }else {
            self.userAsset = @"0.00";
      }
      [UserInfos sharedUser].userAsset = self.userAsset;
      [self.tableView reloadData];
  } error:^(NSError *error) {

      DLog(@"%@", error);
  }];
}
// 请求粉丝数据
- (void)postRequestGetFans {
    //[[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":@(11)
                           };
    [self getRequestWithPath:API_Fans params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        
        if (successJson) {
//            DLog(@"%@", successJson);
            self.fansArray = [FocusAndFansModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            [UserInfos sharedUser].fansCount = self.fansArray.count;
//            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 请求关注数
- (void)postRequestGetFocus {
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{@"user_id":@(17)
                           };
    [self getRequestWithPath:API_Fan_Information params:dict success:^(id successJson) {

        if (successJson) {
            DLog(@"%@", successJson);
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MyFocus"];
            // 得到关注人的人
            self.focusArray = [FocusAndFansModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
             //把关注的人存到本地
            [[NSUserDefaults standardUserDefaults] setObject:self.focusArray forKey:@"MyFocus"];
            [self.tableView reloadData];
        }

    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    DLog(@"%@", docDir);
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.hidesBottomBarWhenPushed = NO;

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];
    if ([UserInfos getUser]) {
        [self postRequestGetFans];
        [self postRequestGetFocus];
        [self postGetUserAsset];
    }


    if ([[UserInfos sharedUser].ismerchant isEqualToString:@"2"]) {
        _dataSource = @[@[@"账户", @"我的订单", @"收货地址", @"卖家中心"], @[@"我的喜欢", @"观看历史"], @[@"实名认证", @"商家认证"], @[@"设置"]];
    }else{
        _dataSource = @[@[@"账户", @"我的订单", @"收货地址"], @[@"我的喜欢", @"观看历史"], @[@"实名认证", @"商家认证"], @[@"设置"]];
    }
    //[UserInfos getUser] &&
    if ([[UserInfos sharedUser].ismerchant isEqualToString:@"2"]) {
        _controllerNames =  @[@[@"AccountViewController", @"OrderGoodsViewController", @"ShopAddressViewController", @"SellerCenterViewController"], @[@"FavoriteViewController", @"WatchHistoryViewController"], @[@"CertificateViewController", @"MerchantViewController"],@[@"SettingViewController"]];
    }else{
        _controllerNames =  @[@[@"AccountViewController", @"OrderGoodsViewController", @"ShopAddressViewController"], @[@"FavoriteViewController", @"WatchHistoryViewController"], @[@"CertificateViewController", @"MerchantViewController"],@[@"SettingViewController"]];
    }
    
    [self.tableView reloadData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)initUI {

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    self.tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark
#pragma mark - 代理
- (NSArray *)fansArray {
    if (!_fansArray) {
        _fansArray = [NSArray array];
    }
    return _fansArray;
}
- (NSArray *)focusArray {
    if (!_focusArray) {
        _focusArray = [NSArray array];
    }
    return _focusArray;
}
- (NSArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}

- (NSArray *)controllerNames {

    if (!_controllerNames) {
        _controllerNames = [NSArray array];
    }
    return _controllerNames;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        //判断登录与否
        
        if ([UserInfos getUser]) {
          return 240;
        }else{
        return 150;
        }
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"myCellId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    NSString *cellText = self.dataSource[indexPath.section][indexPath.row];
    cell.textLabel.text = cellText;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    if ([UserInfos getUser]) { // 如果已经登录
        
        if ([cellText isEqualToString:@"账户"]) {
            
            cell.detailTextLabel.text = self.userAsset;
        }
        if ([cellText isEqualToString:@"实名认证"]) { //  1.未认证 2.审核 3.已认证 4.认证失败
            if ([[UserInfos sharedUser].isreal isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"未认证";
            }else if ([[UserInfos sharedUser].isreal isEqualToString:@"2"]){
                cell.detailTextLabel.text = @"审核中";
            }else if ([[UserInfos sharedUser].isreal isEqualToString:@"3"]){
                cell.detailTextLabel.text = @"已认证";
            }else if ([[UserInfos sharedUser].isreal isEqualToString:@"4"]){
                cell.detailTextLabel.text = @"认证失败";
            }
        }
        if ([cellText isEqualToString:@"商家认证"]) { // 1：非商家 2：商家 3：审核中 4: 审核失败
            if ([[UserInfos sharedUser].ismerchant isEqualToString:@"1"]) {
                cell.detailTextLabel.text = @"非商家";
            }else if ([[UserInfos sharedUser].ismerchant isEqualToString:@"2"]){
                cell.detailTextLabel.text = @"商家";
            }else if ([[UserInfos sharedUser].ismerchant isEqualToString:@"3"]){
                cell.detailTextLabel.text = @"审核中";
            }else if ([[UserInfos sharedUser].ismerchant isEqualToString:@"4"]){
                cell.detailTextLabel.text = @"审核失败";
            }
        }
        
    }else{  // 未登录
        if ([cellText isEqualToString:@"账户"]) {
            cell.detailTextLabel.text = @"0.00";
        }
        if ([cellText isEqualToString:@"实名认证"]) {
            cell.detailTextLabel.text = @"未认证";
        }
        if ([cellText isEqualToString:@"商家认证"]) {
            cell.detailTextLabel.text = @"未认证";
        }
    }
    
    return cell;
}
// cell富文本
- (NSAttributedString *)getCellTextWithString:(NSString *)string {
  NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                         NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                                                         NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    return attribute;
}
// detail富文本
- (NSAttributedString *)getDetailTextWithString:(NSString *)string {
    NSAttributedString *attribute = [[NSAttributedString alloc] initWithString:string attributes:@{
                                                                                                   NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                                                                                   NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    return attribute;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([UserInfos getUser]) { // 如果已经登录
    
        // 如果已经进行商家认证 就选择已商家认证的数据源
        NSString *controllerName = self.controllerNames[indexPath.section][indexPath.row];
        NSString *cellText = self.dataSource[indexPath.section][indexPath.row];

        UIViewController *VC = [[NSClassFromString(controllerName) alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.title = cellText;
        
        [self.navigationController pushViewController:VC animated:YES];

    }else{
        [self showAlert:@"请登录"];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        if ([UserInfos getUser]) {//判断登录与否
        
            MyMessageView *messageView = [[MyMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
            messageView.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
                    __weak typeof(self) weakSelf = self;
            messageView.editBlock = ^(){
                EditMyMessageViewController *editVC = [[EditMyMessageViewController alloc] init];
                editVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:editVC animated:YES];
            };
            
            // 关注
            messageView.focusCount = self.focusArray.count;
            messageView.focusBlcok = ^(){
                MyFocusViewController *myfocus =
                [[MyFocusViewController alloc] init];
                myfocus.hidesBottomBarWhenPushed = YES;
                myfocus.focusArr = self.focusArray;
                [weakSelf.navigationController pushViewController:myfocus animated:YES];
            };
            
            // 粉丝
            messageView.fansCount = [UserInfos sharedUser].fansCount;
            messageView.fansBlcok = ^(){
                MyFansViewController *myFansVC =
                [[MyFansViewController alloc] init];
                myFansVC.fansArr = self.fansArray;
                myFansVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:myFansVC animated:YES];
            };
            
            // 我的主页
            messageView.myPageBlcok = ^(){
                MyPageViewController *myPage =
                [[MyPageViewController alloc] init];
                myPage.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:myPage animated:YES];
            };
            
            // 直播按钮
            messageView.liveBlcok = ^(NSString *btnTitle){
               
                if ([btnTitle isEqualToString:@"需要商家认证才能直播"]) {
                    MerchantViewController *merchahtVC = [[MerchantViewController alloc] init];
                    merchahtVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:merchahtVC animated:YES];
                }else if([btnTitle isEqualToString:@"我要直播"]){
                    CreateLiveViewController *createLiveVC = [[CreateLiveViewController alloc] init];
                    createLiveVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:createLiveVC animated:YES];
                }
            };
            return messageView;
            
        }else{
            MyUnLoginView *unLoginView = [[MyUnLoginView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
            unLoginView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
            __weak typeof(self) weakSelf = self;
            unLoginView.loginBlcok = ^(){
                LoginViewController *VC = [[LoginViewController alloc] init];
                VC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:VC animated:YES];
            };
            
            return unLoginView;
        }
        
    }
    return nil;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
