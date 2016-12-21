//
//  SellerShowViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerShowViewController.h"
#import "SellerMessageView.h"
#import "PlayBackView.h" // 回放
#import "PlayBackModel.h"
#import "MyPagePictureView.h" // 相册

#import "PicturesViewController.h"
#import "FavoriteLivePlayerVc.h"
#import "FocusAndFansModel.h"
@interface SellerShowViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */
@property (nonatomic, strong) NSArray *fansArray; /**< 粉丝数据 */
@property(nonatomic, strong) NSArray *commentArr; /**< 评论数 */

@property(nonatomic, strong) NSMutableArray *dogCardArr; /**< 临时数据 */

@property(nonatomic, strong) NSArray *picturesArr; /**< 临时数据 */
@property (nonatomic, assign) NSInteger pleasureCount; /**< 用户满意度 */

@end

static NSString *cellid1 = @"MyPageViewController1";
static NSString *cellid2 = @"MyPageViewController2";
static NSString *cellid3 = @"MyPageViewController3";

@implementation SellerShowViewController

// 相册列表
- (void)getRequestAlbums {
    NSDictionary *dict = @{
                           @"user_id":_authorId
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
                           @"user_id":_authorId,
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
        [UserInfos sharedUser].commentCount = self.commentArr.count;
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 请求粉丝数据
- (void)postRequestGetFans {
    //[[UserInfos sharedUser].ID integerValue]
    NSDictionary *dict = @{@"user_id":_authorId
                           };
    [self getRequestWithPath:API_Fans params:dict success:^(id successJson) {
        DLog(@"%@", successJson);

        if (successJson[@"data"] == [NSNull null]) {
            self.commentArr = @[];
        }else{
            self.commentArr = successJson[@"data"];
        }
        [UserInfos sharedUser].commentCount = self.commentArr.count;
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 满意度
- (void)getUserPleasure {
    NSDictionary *dict = @{ // [[UserInfos sharedUser].ID integerValue]
                           @"user_id":_authorId
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
    NSDictionary *dict = @{@"user_id":_authorId};
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
- (void)getPersonalDesc {
    
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
    // 请求粉丝数据
    [self postRequestGetFans];
    // 请求满意度
    [self getUserPleasure];
    // 请求回放
    [self getRequestMyLive];

    self.dataArr = @[@"认证信息", @"回放", @"相册"];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
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
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSArray *)commentArr {
    if (!_commentArr) {
        _commentArr = [NSArray array];
    }
    return _commentArr;
}
- (NSArray *)fansArray {
    if (!_fansArray) {
        _fansArray = [NSArray array];
    }
    return _fansArray;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid1];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid2];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid3];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *rootCell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (rootCell == nil) {
        rootCell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellid"];
    }
    rootCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *cell1 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid1];
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;

            SellerMessageView *messageView = [[SellerMessageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 220)];
            messageView.fansCount = self.fansArray.count;
            messageView.commentCount = self.commentArr.count;
            messageView.pleasureCount = self.pleasureCount;
            messageView.userName = self.liverName;
            messageView.userImg = self.liverIcon;
            messageView.backgroundColor = [UIColor whiteColor];
            messageView.focusBlock = ^(UIButton *btn){
                [btn setTitle:@"已关注" forState:(UIControlStateNormal)];
                if ([UserInfos getUser]) {
                    
                    if (btn.selected) {
                        NSDictionary *dict = @{
                                               @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                               @"id":@([_authorId intValue]),
                                               @"type":@(1)
                                               };
                        [self getRequestWithPath:API_Add_fan params:dict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }else{
                        NSDictionary *dict = @{
                                               @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                               @"id":@([_authorId intValue]),
                                               @"type":@(0)
                                               };
                        [self getRequestWithPath:API_Add_fan params:dict success:^(id successJson) {
                            DLog(@"%@", successJson);
                            [self showAlert:successJson[@"message"]];
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    }
                }
            };
            [cell1.contentView addSubview:messageView];
            return cell1;

        }
            break;
        case 1:
        {
            UITableViewCell *cell2 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid2];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            
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
                [cell2.contentView addSubview:playbackView];
            return cell2;
            }
            break;
        case 2:
        {
            UITableViewCell *cell3 = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellid3];
            cell3.selectionStyle = UITableViewCellSelectionStyleNone;
            
            NSInteger count = self.picturesArr.count;
            CGFloat W = 0;
            if (count == 1) {
                count = 2;
                W = (SCREEN_WIDTH - (count + 1) * 10) / count;
            }else if (count > 1){
                
                W = (SCREEN_WIDTH - (count + 1) * 10) / count;
            }
            
            MyPagePictureView *picture = [[MyPagePictureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40 + W + 45)];
            // 设置显示的相册数
            //                picture.maxCount = 3;
            picture.isHidManage = YES;
            picture.dataPlist = self.picturesArr;
            picture.backgroundColor = [UIColor whiteColor];
            [cell3.contentView addSubview:picture];
            
            __weak typeof(self) weakSelf = self;
            
            picture.pictureBlock = ^(MyAlbumsModel *model){
                PicturesViewController *pictureVC = [[PicturesViewController alloc] init];
                pictureVC.model = model;
                pictureVC.hidesBottomBarWhenPushed = YES;
                [weakSelf.navigationController pushViewController:pictureVC animated:YES];
            };
            return cell3;
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
        
//        DogTypeCellModel *cardModel1 = [[DogTypeCellModel alloc] initWithDogIcon:@"banner" focusCount:@"1000" dogDesc:@"纯种拉布拉多犬" anchorName:@"逗逼" showCount:@"5" onSailCount:@"8"];
//        DogTypeCellModel *cardModel2 = [[DogTypeCellModel alloc] initWithDogIcon:@"banner" focusCount:@"1000" dogDesc:@"纯种拉布拉多犬" anchorName:@"逗逼" showCount:@"5" onSailCount:@"8"];
//        
//        _dogCardArr = @[cardModel1, cardModel2];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            return 220;
            break;
       
        case 1:
        {
            CGFloat playbackViewHeight = 0;
            if (self.dogCardArr.count == 0) {
                playbackViewHeight = 33 + 30;;
            }else{
                playbackViewHeight = self.dogCardArr.count * 125 + 50;
            }
            return playbackViewHeight + 10;
        }
            break;
        case 2:
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
