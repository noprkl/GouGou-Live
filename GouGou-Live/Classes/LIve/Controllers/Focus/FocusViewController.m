//
//  FocusViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FocusViewController.h"
#import "NoneFocusView.h"
#import "NoneNetWorkingView.h"

#import "LiveTableView.h"
#import "LiveViewCell.h" // 自定义cell
#import "LivingViewController.h"
#import "PlayBackViewController.h"

@interface FocusViewController ()

/** 无关注人 */
@property (strong, nonatomic) NoneFocusView *noneView;

@property(nonatomic, strong) NoneNetWorkingView *noneNetView; /**< 无网 */

/** 有人列表 */
@property (strong, nonatomic) LiveTableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation FocusViewController

#pragma mark - 关注的直播列表
- (void)getRequestLiveList {
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID intValue])
                           };
    [self getRequestWithPath:API_Fan_live params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView.dataPlist removeAllObjects];
        [self.tableView.dogInfos removeAllObjects];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            //        [self showHudInView:self.view hint:@"刷新中"];
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            /** 直播信息 */
            NSMutableArray *liveMutableArr = [NSMutableArray array];
            /** 狗狗信息 */
            NSMutableArray *dogInfos = [NSMutableArray array];
            
            // 请求狗狗信息
            for (NSInteger i = 0; i < liveArr.count; i ++) {
                
                LiveViewCellModel *model = liveArr[i];
                NSDictionary *dict = @{
                                       @"live_id":model.liveId
                                       };
                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                    //                DLog(@"%@", successJson);
                    if (model.pNum == 0) {
                        [dogInfos addObject:@[]];
                        DLog(@"%ld", i);
                    }else{
                        DLog(@"%ld", i);
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                        }
                    }
                    [liveMutableArr addObject:model];
                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
                        DLog(@"%ld", i);
                        self.tableView.dogInfos = dogInfos;
                        self.tableView.dataPlist = liveMutableArr;
                        [self.tableView reloadData];
                        //                    [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //                    [self hideHud]
        }
//        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = 64;
    [self getRequestLiveList];
    [self loadFocusView];
}
- (void)loadFocusView {
    
    // 先判断是否有网，然后请求数据 如果没有添加无主播 否则添加 有主播
//    [self.view addSubview:self.noneNetView];
    
    [self.view addSubview:self.noneView];
    
    [self.view addSubview:self.tableView];
}

#pragma mark
#pragma mark - 懒加载
- (NoneFocusView *)noneView {
    if (!_noneView) {
        _noneView = [[NoneFocusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        __weak typeof(self) weakSelf = self;
        _noneView.requestBlock = ^(NSString *text){
            weakSelf.noneNetView.hidden = YES;
//            weakSelf.tableView.hidden = NO;
            [weakSelf.tableView.mj_header beginRefreshingWithCompletionBlock:^{
                [weakSelf getRequestLiveList];
                [weakSelf.tableView.mj_header endRefreshing];
            }];
        };
    }
    return _noneView;
}
- (NoneNetWorkingView *)noneNetView {
    if (!_noneNetView) {
        _noneNetView = [[NoneNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneNetView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _noneNetView;
}
- (LiveTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:(UITableViewStylePlain)];
        
        __weak typeof(self) weakSelf = self;

        _tableView.cellBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
            [weakSelf pushToLivingVc:model products:dogInfos];
        };
        _tableView.dogCardBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
            [weakSelf pushToLivingVc:model products:dogInfos];
        };
    }
    return _tableView;
}
- (void)pushToLivingVc:(LiveViewCellModel *)model products:(NSArray *)dogInfos {
    DLog(@"%@", model);
    if ([model.status isEqualToString:@"1"]) {
        LivingViewController *livingVC = [[LivingViewController alloc] init];
        livingVC.liveID = model.liveId;
        livingVC.liverId = model.ID;
        livingVC.liverIcon = model.userImgUrl;
        livingVC.liverName = model.merchantName;
        livingVC.doginfos = dogInfos;
        livingVC.watchCount = model.viewNum;
        livingVC.chatRoomID = model.chatroom;
        livingVC.state = model.status;
        livingVC.isLandscape = NO;
        livingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:livingVC animated:YES];
    }
    if ([model.status isEqualToString:@"3"]) {
        PlayBackViewController *livingVC = [[PlayBackViewController alloc] init];
        livingVC.liveID = model.liveId;
        livingVC.liverId = model.ID;
        livingVC.liverIcon = model.userImgUrl;
        livingVC.liverName = model.merchantName;
        livingVC.doginfos = dogInfos;
        livingVC.watchCount = model.viewNum;
        livingVC.chatRoomID = model.chatroom;
        livingVC.isLandscape = NO;
        livingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:livingVC animated:YES];
    }
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
