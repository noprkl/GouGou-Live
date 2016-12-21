//
//  PersonalPageController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PersonalPageController.h"
#import "MyPageHeaderView.h"
#import "MyPageDescView.h"
#import "PlayBackView.h"
#import "DogTypeCellModel.h"
#import "MyPagePictureView.h"
#import "PromptView.h"
#import "FavoriteLivePlayerVc.h"
#import "CertificateViewController.h"
#import "MerchantViewController.h"

#import "ManagePictureaViewController.h"

#import "MyAlbumsModel.h" // 相册model
#import "FocusAndFansModel.h"
#import "PicturesViewController.h" // 照片列表

@interface PersonalPageController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) NSArray *fansArray; /**< 粉丝数 */

@property(nonatomic, strong) NSArray *commentArr; /**< 评论数 */

@property(nonatomic, strong) NSMutableArray *dogCardArr; /**< 临时数据 */

@property(nonatomic, strong) NSArray *picturesArr; /**< 临时数据 */
@property (nonatomic, assign) NSInteger pleasureCount; /**< 用户满意度 */

@end

static NSString *cellid = @"cellid";
static NSString *cellid0 = @"cellid0";
static NSString *cellid1 = @"cellid1";
static NSString *cellid2 = @"cellid2";
static NSString *cellid3 = @"cellid3";
static NSString *cellid4 = @"cellid4";

@implementation PersonalPageController

// 相册列表
- (void)getRequestAlbums {
    NSDictionary *dict = @{ // [[UserInfos sharedUser].ID integerValue]
                           @"user_id":@(_personalID)
                           };
    [self getRequestWithPath:API_album params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.picturesArr = [MyAlbumsModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 评价
- (void)getRequestComment {
    NSDictionary *dict = @{
                           @"user_id":@(_personalID),
                           @"page":@(1),
                           @"pageSize":@(5)
                           };
    [self getRequestWithPath:API_My_order_comment params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson[@"data"][@"info"] == [NSNull null]) {
            self.commentArr = @[];
        }else{
            self.commentArr = successJson[@"data"][@"info"];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
// 请求粉丝数据
- (void)postRequestGetFans {
    //[[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{
                           @"user_id":@(_personalID)
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

// 满意度
- (void)getUserPleasure {
    NSDictionary *dict = @{ // [[UserInfos sharedUser].ID integerValue]
                           @"user_id":@(_personalID)
                           };
    [self getRequestWithPath:API_home params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        if ([successJson[@"code"] isEqualToString:@"1"]) {
            // 分数四舍五入
            CGFloat source = [successJson[@"data"] floatValue];
            NSInteger count = source * 10;
            if (count % 10 > 5) {
                self.pleasureCount = count / 10 + 1;
            }else{
                self.pleasureCount = count / 10;
            }
            DLog(@"%ld", self.pleasureCount);
            [self.tableView reloadData];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 回放
- (void)getRequestMyLive {
    NSDictionary *dict = @{@"user_id":@(_personalID)};
    [self getRequestWithPath:API_Seller_live params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.dogCardArr removeAllObjects];
        NSArray *playBackarr = [PlayBackModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
        if (playBackarr.count < 2) {
            [self.dogCardArr addObjectsFromArray:playBackarr];
        }else{
            [self.dogCardArr addObject:playBackarr[0]];
            [self.dogCardArr addObject:playBackarr[1]];
        }
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];
    
    // 请求相册数据
    [self getRequestAlbums];
    // 请求评论数
    [self getRequestComment];
    // 请求满意度
    [self getUserPleasure];
    // 请求
    [self getRequestMyLive];
}

- (void)initUI {
    [self setNavBarItem];
    
    self.title = @"个人主页";
    [self.view addSubview:self.tableView];
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"头部"], @[@"简介"], @[@"实名认证", @"商家认证"],@[@"回放"],@[@"相册"]];
    }
    return _dataArr;
}
- (NSArray *)fansArray {
    if (!_fansArray) {
        _fansArray = [NSArray array];
    }
    return _fansArray;
}
- (NSArray *)commentArr {
    if (!_commentArr) {
        _commentArr = [NSArray array];
    }
    return _commentArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid0];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid1];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid2];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid3];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid4];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *rootCell = [tableView dequeueReusableCellWithIdentifier:cellid];
    rootCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) { // 头部信息
                UITableViewCell *cell0 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid0];
                cell0.selectionStyle = UITableViewCellSelectionStyleNone;
                
                MyPageHeaderView *headerView = [[MyPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
                headerView.fansCount = self.fansArray.count;
                headerView.commentCount = self.commentArr.count;
                headerView.pleasureCount = self.pleasureCount;
                
                headerView.backgroundColor = [UIColor whiteColor];
                [cell0.contentView addSubview:headerView];
                return cell0;
            }
            break;
        case 1:
            if (indexPath.row == 0) { // 简介
                UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid2];
                cell1.selectionStyle = UITableViewCellSelectionStyleNone;
                
                MyPageDescView *descView = [[MyPageDescView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 73))];
                descView.isHidEdit = YES;
                descView.backgroundColor = [UIColor whiteColor];
                [cell1.contentView addSubview:descView];
                return cell1;
            }
            break;
        case 2:
        {
            UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid2];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.row == 0) { // 实名认证
                cell2.textLabel.text = @"实名认证";
                cell2.textLabel.font = [UIFont systemFontOfSize:16];
                cell2.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 44))];
                label.backgroundColor = [UIColor whiteColor];
                if ([UserInfos sharedUser].username.length == 0) {
                    label.text = @"未实名";
                }else{
                    label.text = [UserInfos sharedUser].username;
                }
                label.font = [UIFont systemFontOfSize:14];
                label.textColor = [UIColor colorWithHexString:@"#333333"];
                [cell2.contentView addSubview:label];
                
            }else if (indexPath.row == 1){ // 商家认证
                cell2.textLabel.text = @"商家认证";
                cell2.textLabel.font = [UIFont systemFontOfSize:16];
                cell2.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 44))];
                label.backgroundColor = [UIColor whiteColor];
                
                if ([UserInfos sharedUser].username.length == 0) {
                    label.text = @"未认证";
                }else{
                    label.text = @"已认证";
                }
                label.font = [UIFont systemFontOfSize:14];
                label.textColor = [UIColor colorWithHexString:@"#333333"];
                [cell2.contentView addSubview:label];
            }
            return cell2;
        }
            break;
        case 3:
            if (indexPath.row == 0) {
                UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid3];
                cell3.selectionStyle = UITableViewCellSelectionStyleNone;
                
                CGFloat playbackViewHeight = 0;
                
                if (self.dogCardArr.count == 0) {
                    playbackViewHeight = 33 + 30;;
                }else{
                    playbackViewHeight = self.dogCardArr.count * 125 + 43;
                }
                
                PlayBackView *playbackView = [[PlayBackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, playbackViewHeight) style:(UITableViewStylePlain)];
                playbackView.AVArray = self.dogCardArr;
                playbackView.playBackBlock = ^(PlayBackModel *model){
                    FavoriteLivePlayerVc *playerVc = [[FavoriteLivePlayerVc alloc] init];
                    //                                playerVc.liveID = liveID;
                    playerVc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:playerVc animated:YES];
                };
                playbackView.backgroundColor = [UIColor whiteColor];
                //                [cell addSubview:playbackView];
                [cell3.contentView addSubview:playbackView];
                return cell3;
            }
            break;
        case 4:
            if (indexPath.row == 0) {
                UITableViewCell *cell4 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid4];
                cell4.selectionStyle = UITableViewCellSelectionStyleNone;
                
                NSInteger count = self.picturesArr.count;
                CGFloat W = 0;
                if (count == 1) {
                    count = 2;
                    W = (SCREEN_WIDTH - (count + 1) * 10) / count;
                }else if (count > 1){
                    
                    W = (SCREEN_WIDTH - (count + 1) * 10) / count;
                }
                
                MyPagePictureView *picture = [[MyPagePictureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40 + W + 45)];
                //                picture.maxCount = 3;
                picture.isHidManage = YES;
                picture.dataPlist = self.picturesArr;
                picture.backgroundColor = [UIColor whiteColor];
                [cell4.contentView addSubview:picture];
                
                __weak typeof(self) weakSelf = self;
                picture.pictureBlock = ^(MyAlbumsModel *model){
                    PicturesViewController *pictureVC = [[PicturesViewController alloc] init];
                    pictureVC.model = model;
                    pictureVC.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:pictureVC animated:YES];
                };
                return cell4;
            }
            break;
        default:
            break;
    }
    return rootCell;
}
- (void)test1 {
    DLog(@"test");
}
- (NSMutableArray *)dogCardArr {
    if (!_dogCardArr) {
        _dogCardArr = [NSMutableArray array];
    }
    return _dogCardArr;
}
- (NSArray *)picturesArr {
    if (!_picturesArr) {
        _picturesArr = [NSArray array];
        //        _picturesArr = @[@"品种", @"品种"];
    }
    return _picturesArr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 73;
            break;
        case 2:
            return 44;
            break;
        case 3:
        {
            CGFloat playbackViewHeight = 0;
            if (self.dogCardArr.count == 0) {
                playbackViewHeight = 33 + 30;;
            }else{
                playbackViewHeight = self.dogCardArr.count * 125 + 50;
            }
            return playbackViewHeight;
        }
            break;
        case 4:
        {
            NSInteger count = self.picturesArr.count;
            CGFloat W = 0;
            if (count == 1) {
                count = 2;
                W = (SCREEN_WIDTH - (count + 1) * 10) / count + 50;
            }else if (count > 1){
                
                W = (SCREEN_WIDTH - (count + 1) * 10) / count + 50;
            }
            
            return W + 50;
        }
            break;
        default:
            break;
    }
    return 0;
}
#pragma mark
#pragma mark - Action
- (void)clickRealBtnAction {
    CertificateViewController *certifi = [[CertificateViewController alloc] init];
    certifi.hidesBottomBarWhenPushed = YES;
    certifi.title = @"实名认证";
    [self.navigationController pushViewController:certifi animated:YES];
}

- (void)clickMerchantBtnAction {
    MerchantViewController *merchant = [[MerchantViewController alloc] init];
    merchant.hidesBottomBarWhenPushed = YES;
    merchant.title = @"商家认证";
    [self.navigationController pushViewController:merchant animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end