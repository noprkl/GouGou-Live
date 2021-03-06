//
//  FavoriteViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FavoriteViewController.h"
#import "TowButtonView.h"
#import "MyFavoriteTableView.h"
#import "DogDetailInfoModel.h"
#import "FavoriteDogDetailVc.h"
#import "FavoriteLivePlayerVc.h"
#import "PlayBackModel.h"
#import "FavoriteDogDetailVc.h"
#import "NoneDateView.h"

@interface FavoriteViewController ()
{
    int page;
}
/** 两个button View */
@property (strong,nonatomic) TowButtonView *towBtnView;
/** 喜欢的直播 */
@property (strong,nonatomic) MyFavoriteTableView *favotiteLiveTable;
/** 喜欢的狗狗 */
@property (strong,nonatomic) MyFavoriteTableView *favoriteDogTable;
/** 底部scrollView */
//@property (strong,nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NoneDateView *noneLiveDateView; /**< 没有直播数据 */
@property (nonatomic, strong) NoneDateView *noneDogDateView; /**< 没有狗狗数据 */

@end

@implementation FavoriteViewController
#pragma mark
#pragma mark - 网络请求
// 我的喜欢-狗狗
- (void)GetRequestFavoriteDog{
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID intValue]),
                           @"page":@(page),
                           @"pageSize":@(10)
                           };
    [self showHudInView:self.view hint:@"刷新..."];
    [self getRequestWithPath:API_My_like_product params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (page == 1) {
            
            [self.favoriteDogTable setContentOffset:CGPointMake(0, 0) animated:YES];
            self.noneDogDateView.hidden = YES;
            [self.favoriteDogTable.mj_footer resetNoMoreData];
            if (successJson[@"data"][@"info"]) {
                self.favoriteDogTable.favoriteDogArray = [DogDetailInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
                [self.favoriteDogTable reloadData];
            }else {
                self.noneDogDateView.hidden = NO;
            }
            [self hideHud];

        }else{
            NSArray *array = [DogDetailInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
            
            [self.favoriteDogTable.favoriteDogArray addObjectsFromArray:array];
            [self.favoriteDogTable reloadData];
            if (array.count < 10) {
                [self.favoriteDogTable.mj_footer endRefreshingWithNoMoreData];
                page -= 1;
            }else{
                [self.favoriteDogTable.mj_footer endRefreshing];
            }
            [self hideHud];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 我的喜欢-直播
- (void)GetRequestFavoriteLive {
    NSDictionary * dict = @{
                            @"user_id":@([[UserInfos sharedUser].ID intValue])
                            };
    [self showHudInView:self.view hint:@"刷新..."];
    [self getRequestWithPath:API_User_like params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        
        if (page == 1) {
            [self.favotiteLiveTable setContentOffset:CGPointMake(0, 0) animated:YES];
            self.noneDogDateView.hidden = YES;
            
            if (successJson[@"data"][@"data"]) {
                self.favotiteLiveTable.favoriteLiveArray = [PlayBackModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
                [self.favotiteLiveTable reloadData];
            }else{
                self.noneLiveDateView.hidden = NO;
            }
            [self hideHud];

        }else{
            NSArray *array = [PlayBackModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            
            [self.favotiteLiveTable.favoriteDogArray addObjectsFromArray:array];
            [self.favotiteLiveTable reloadData];
            if (array.count < 10) {
                [self.favotiteLiveTable.mj_footer endRefreshingWithNoMoreData];
                page -= 1;
            }else{
                [self.favotiteLiveTable.mj_footer endRefreshing];
            }
            [self hideHud];
        }

    } error:^(NSError *error) {
        DLog(@"%@",error);
        
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 请求狗狗数据
    page = 1;
    [self GetRequestFavoriteLive];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的喜欢";
    
    self.edgesForExtendedLayout = 64;
    
    [self addControllers];
    
    [self setNavBarItem];
    
    self.favotiteLiveTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [self GetRequestFavoriteLive];
        // 取消下拉刷新
        [self.favotiteLiveTable.mj_header endRefreshing];
    }];
    self.favotiteLiveTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self GetRequestFavoriteLive];
    }];
    
    self.favoriteDogTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 请求数据
        page = 1;
        [self GetRequestFavoriteDog];
        // 取消下拉刷新
        [self.favoriteDogTable.mj_header endRefreshing];
    }];
    self.favoriteDogTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self GetRequestFavoriteDog];
    }];
}
#pragma mark
#pragma mark - 约束
- (void)addControllers {
    
    [self.view addSubview:self.towBtnView];
    [self.view addSubview:self.favotiteLiveTable];
    [self.view addSubview:self.favoriteDogTable];
    
    [self.favotiteLiveTable addSubview:self.noneLiveDateView];
    [self.favoriteDogTable addSubview:self.noneDogDateView];
    
    self.noneLiveDateView.frame = self.favotiteLiveTable.bounds;
    self.noneDogDateView.frame = self.favoriteDogTable.bounds;
    __weak typeof(self) weakself = self;
    
    [_towBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (TowButtonView *)towBtnView {

    if (!_towBtnView) {
        _towBtnView = [[TowButtonView alloc] init];
        [_towBtnView.liveBtn addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
        
        [_towBtnView.dogBtn addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _towBtnView;
}

- (MyFavoriteTableView *)favotiteLiveTable {

    if (!_favotiteLiveTable) {
        _favotiteLiveTable = [[MyFavoriteTableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
        _favotiteLiveTable.isLive = YES;
        _favotiteLiveTable.tableFooterView = [[UIView alloc] init];
        __weak typeof(self) weakSelf = self;
        _favotiteLiveTable.deleLiveBlock = ^(NSString *liveID){
            NSDictionary *dict = @{//删除直播
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"product_id":liveID ,
                                   @"type":@(2),
                                   @"state":@(2)
                                   };
            [weakSelf getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [weakSelf showAlert:successJson[@"message"]];
                page = 1;
                [weakSelf GetRequestFavoriteLive];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        
        };
        _favotiteLiveTable.clickLiveBlock = ^(NSString *liveID){
            // 回放界面
            FavoriteLivePlayerVc *playerVc = [[FavoriteLivePlayerVc alloc] init];
            playerVc.liveID = liveID;
            playerVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:playerVc animated:YES];
//            LivePlayerBackVc *playVc = [[LivePlayerBackVc alloc] init];
//            playVc.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:playVc animated:YES];
            
        };
    }
    return _favotiteLiveTable;
}

- (MyFavoriteTableView *)favoriteDogTable {

    if (!_favoriteDogTable) {
        _favoriteDogTable = [[MyFavoriteTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
        _favoriteDogTable.isLive = NO;
        _favoriteDogTable.tableFooterView = [[UIView alloc] init];
        __weak typeof(self) weakSelf = self;
        _favoriteDogTable.deleDogBlock = ^(NSString *dogID){
            NSDictionary *dict = @{//删除狗狗
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"product_id":@([dogID integerValue]),
                                   @"type":@(2),
                                   @"state":@(1)
                                   };
            DLog(@"%@", dict);
            [weakSelf getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [weakSelf showAlert:successJson[@"message"]];
                if (successJson) {
                    page = 1;
                    [weakSelf GetRequestFavoriteDog];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
        _favoriteDogTable.clickDogBlock = ^(NSString *dogID){
            // 狗狗详情
            FavoriteDogDetailVc *dogDetailVc = [[FavoriteDogDetailVc alloc] init];
            dogDetailVc.dogID = dogID;
            dogDetailVc.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:dogDetailVc animated:YES];
        };
    }
    return _favoriteDogTable;
}

- (void)changeTableFrame:(UIButton *)button {

    if (button == _towBtnView.liveBtn) {
        
        button.selected = YES;
        _towBtnView.dogBtn.selected = NO;
        button.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _towBtnView.dogBtn.backgroundColor = [UIColor whiteColor];
        [_towBtnView.dogBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = _favotiteLiveTable.frame;
            tableRect1.origin.x = 0;
            _favotiteLiveTable.frame = tableRect1;
            
            CGRect tableRect2 = _favoriteDogTable.frame;
            tableRect2.origin.x = SCREEN_WIDTH;
            _favoriteDogTable.frame = tableRect2;
            
        }];
        page =1;
        [self GetRequestFavoriteLive];
    }else {
        
        button.selected = YES;
        _towBtnView.liveBtn.selected = NO;
        button.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _towBtnView.liveBtn.backgroundColor = [UIColor whiteColor];
        [_towBtnView.liveBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = _favotiteLiveTable.frame;
            tableRect1.origin.x = -SCREEN_WIDTH;
            _favotiteLiveTable.frame = tableRect1;
            
            CGRect tableRect2 = _favoriteDogTable.frame;
            tableRect2.origin.x = 0;
            _favoriteDogTable.frame = tableRect2;
        }];
        page =1;
        [self GetRequestFavoriteDog];
    }
}

- (NoneDateView *)noneLiveDateView {
    if (!_noneLiveDateView) {
        _noneLiveDateView = [[NoneDateView alloc] initWithFrame:self.view.bounds];
        _noneLiveDateView.noteStr = @"没有喜欢的直播！";
        _noneLiveDateView.hidden = YES;
        _noneLiveDateView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _noneLiveDateView;
}- (NoneDateView *)noneDogDateView {
    if (!_noneDogDateView) {
        _noneDogDateView = [[NoneDateView alloc] initWithFrame:self.view.bounds];
        _noneDogDateView.noteStr = @"没有喜欢的狗狗！";
        _noneDogDateView.hidden = YES;
        _noneDogDateView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _noneDogDateView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
