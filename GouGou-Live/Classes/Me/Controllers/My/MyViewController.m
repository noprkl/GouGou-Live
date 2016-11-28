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

@interface MyViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray  *dataSource;

/** 控制器名字 */
@property (strong, nonatomic) NSArray *controllerNames;

/** headBtn */
@property (strong, nonatomic) UIButton *myButton;

@property(nonatomic, strong) NSArray *doneMetchDataSource; /**< 已经商家认证的数据源 */

@property(nonatomic, strong) NSArray *doneMetchcontrollerNames; /**< 已经商家认证的控制器名字 */


@property(nonatomic, strong) NSArray *fansArray; /**< 粉丝数据 */
@property(nonatomic, strong) NSArray *focusArray; /**< 关注数据 */

@end

@implementation MyViewController

#pragma mark
#pragma mark - 网络请求
// 用户账单
- (void)postGetUserAsset {
    
    NSDictionary *dict = @{
                           @"uid":@([[UserInfos sharedUser].ID integerValue]),
                           @"page":@1
                           };
    
  [self postRequestWithPath:API_UserAsset params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
  } error:^(NSError *error) {

      DLog(@"%@", error);
  }];
}
// 请求粉丝数据
- (void)postRequestGetFans {
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{@"user_id":@(11)
                           };
    [self getRequestWithPath:API_Fans params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.fansArray = successJson[@"data"];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 请求关注数
- (void)postRequestGetFocus {
    // [[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{@"user_id":@(11)
                           };
    [self getRequestWithPath:API_Fan_Information params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.focusArray = successJson[@"data"];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
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
    [self postGetUserAsset];
    [self postRequestGetFans];

    
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
- (NSArray *)doneMetchDataSource {
    if (!_doneMetchDataSource) {
        _doneMetchDataSource =  @[@[@"账号", @"我的订单", @"收货地址", @"卖家中心"], @[@"我的喜欢", @"观看历史"], @[@"实名认证", @"商家认证"], @[@"设置"]];
    }
    return _doneMetchDataSource;
}
- (NSArray *)doneMetchcontrollerNames {
    if (!_doneMetchcontrollerNames) {
        _doneMetchcontrollerNames = @[@[@"AccountViewController", @"OrderGoodsViewController", @"ShopAddressViewController", @"SellerCenterViewController"], @[@"FavoriteViewController", @"WatchHistoryViewController"], @[@"CertificateViewController", @"MerchantViewController"],@[@"SettingViewController"]];
    }
    return _doneMetchcontrollerNames;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // 如果已经进行商家认证 就选择已商家认证的数据源
    if ([UserInfos sharedUser].ismerchant) {
        return self.doneMetchDataSource.count;
    }else{
        return self.dataSource.count;
    }
//    return self.doneMetchDataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 如果已经进行商家认证 就选择已商家认证的数据源
    if ([UserInfos sharedUser].ismerchant) {
        return [self.doneMetchDataSource[section] count];
    }else{
        return [self.dataSource[section] count];
    }
//    return [self.doneMetchDataSource[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 31;
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

    // 如果已经登录
    if ([UserInfos getUser]) { // 登录
        if ([UserInfos sharedUser].isreal) { // 实名热证
            if ([UserInfos sharedUser].ismerchant) {
                // 商家认证
                
                NSString *textString = self.doneMetchDataSource[indexPath.section][indexPath.row];
                cell.textLabel.attributedText = [self getCellTextWithString:textString];
                cell.detailTextLabel.text = @"";

                if (indexPath.section == 0) {
                    if (indexPath.row == 0) {
                        // 账号
                        cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"余额"];
                    }
                }
                if (indexPath.section == 2) {
                    if (indexPath.row == 0){
                        // 已实名认证
                        cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"已认证"];
                    }
                    if (indexPath.row == 1){
                        // 已商家认证
                        cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"已认证"];
                    }
                }
            }else{
                // 未商家认证
                NSString *textString = self.dataSource[indexPath.section][indexPath.row];
                cell.textLabel.attributedText = [self getCellTextWithString:textString];
                cell.detailTextLabel.text = @"";
                
                if (indexPath.section == 0) {
                    if (indexPath.row == 0) {
                        // 账号
                        cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"余额"];
                    }
                }
                if (indexPath.section == 2) {
                    if (indexPath.row == 0){
                        // 未实名认证
                        cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"已认证"];
                    }
                    if (indexPath.row == 1){
                        // 未商家认证
                        cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"去认证"];
                    }
                }
            }
        }else{
            // 未实名认证
            NSString *textString = self.dataSource[indexPath.section][indexPath.row];
            cell.textLabel.attributedText = [self getCellTextWithString:textString];
            cell.detailTextLabel.text = @"";
            if (indexPath.section == 0) {
                if (indexPath.row == 0) {
                    // 账号
                    cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"余额"];
                }
            }
            if (indexPath.section == 2) {
                if (indexPath.row == 0){
                    // 实名认证
                    cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"未认证"];
                }
                if (indexPath.row == 1){
                    // 商家认证
                    cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"需实名认证"];
                }
            }
        }
    }else{
        // 未登录cell
        NSString *textString = self.dataSource[indexPath.section][indexPath.row];
        cell.textLabel.attributedText = [self getCellTextWithString:textString];

        cell.detailTextLabel.text = @"";
        if (indexPath.section == 0) {
            // 未登录detaile
            if (indexPath.row == 0) {
                // 账号
                cell.detailTextLabel.text = @"";
            }
        }
        if (indexPath.section == 2) {
            if (indexPath.row == 0){
                // 实名认证
                cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"未认证"];
            }
            if (indexPath.row == 1){
                // 商家认证
                cell.detailTextLabel.attributedText = [self getDetailTextWithString:@"未认证"];
            }
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
    if ([UserInfos getUser]) {
        
        // 如果已经进行商家认证 就选择已商家认证的数据源
        NSString *controllerName;
        NSString *cellText;
        if ([UserInfos sharedUser].ismerchant) {
            cellText = self.dataSource[indexPath.section][indexPath.row];
            
            controllerName = self.controllerNames[indexPath.section][indexPath.row];
        }else{
            cellText = self.doneMetchDataSource[indexPath.section][indexPath.row];
            
            controllerName = self.doneMetchcontrollerNames[indexPath.section][indexPath.row];
        }
        
        // 如果已经进行商家认证 就选择已商家认证的数据源
        
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
            messageView.fansCount = self.fansArray.count;
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
