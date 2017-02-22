//
//  RecommendViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "RecommendViewController.h"
#import <SDCycleScrollView.h>
#import "NoneNetWorkingView.h"

#import "LiveTableView.h"
#import "LiveViewCell.h" // 自定义cell
#import "LiveFilteView.h" // 筛选view
// 筛选弹窗
#import "DogSizeFilter.h"
#import "DogAgeFilter.h"
#import "DogPriceFilter.h"

#import "LivingViewController.h"// 直播
#import "PlayBackViewController.h"// 回放
#import "BanaerViewController.h" //banaer图
#import "LiveViewCellModel.h"

#import "NoneFocusView.h"
#import "BannerModel.h"

#import "TalkingViewController.h"

@interface RecommendViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

/** 底部scrollview */
@property (strong, nonatomic) UIScrollView *baseScrollView;

@property(nonatomic, strong) NoneNetWorkingView *noneNetView; /**< 无网 */

/** 轮播图片的URL数组 */
@property (strong, nonatomic) NSArray *urlArray;
/** 轮播图片数据 */
@property (strong, nonatomic) NSArray *banaerArray;

/** 直播列表 */
@property (nonatomic, strong) NSMutableArray *liveListArray;
@property (nonatomic, strong) NSMutableDictionary *dogInfos; /**< 狗狗信息 */

@property(nonatomic, strong) UILabel *noneLiveLabel; /**< 没有直播 */

@property (nonatomic, assign) NSInteger page; /**< 请求页数 */

@property (nonatomic, strong) UITableView *tableView; /**< 表格 */

@end
static NSString *cellid = @"RecommentCellid";

@implementation RecommendViewController
- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}
#pragma mark
#pragma mark - 网络请求
- (void)getRequestLiveList {

    NSDictionary *dict = @{
                           @"page":@(_page),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self showHudInView:self.view hint:@"加载中"];
    [self getRequestWithPath:API_Live_new_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        if (_page == 1) {// 下拉
            if (!successJson[@"data"][@"data"]) { // 如果没有数据
                [self.liveListArray removeAllObjects];
                [self.dogInfos removeAllObjects];
                [self hideHud];
                [self.tableView reloadData];
            }else {
                /** 所有信息 */
                NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
                self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                [self loadProductInfo];
            }
        }else{            // 上拉
            NSArray *dataarr = successJson[@"data"][@"data"];
            [self.tableView.mj_footer endRefreshingWithCompletionBlock:^{
                [self.tableView.mj_footer endRefreshing];
                if (dataarr.count == 0) {
                    [self showAlert:@"没有更多了"];
                    [self hideHud];
                    self.page = self.page - 1;
                    return ;
                }else{
                    NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:dataarr];
                    self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                    [self loadProductInfo];
                    if (dataarr.count < 10) {
                        [self showAlert:@"没有更多了"];
                        self.page = self.page - 1;
                        return ;
                    }
                }
            }];
        }

    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)loadProductInfo {
    [self.dogInfos removeAllObjects];
    NSInteger pnum = 0;// 加限制，防止数据不够就刷新
    for (NSInteger i = 0; i < self.liveListArray.count; i ++) {
        
        LiveViewCellModel *model = self.liveListArray[i];
        if (model.pNum != 0) {
            pnum ++;
        }
        NSDictionary *dict = @{
                               @"live_id":model.liveId
                               };
        [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
            DLog(@"%@", dict);
            DLog(@"第几个%ld", i);
            DLog(@"%@", successJson);
            if (successJson[@"data"]) {
              
                NSArray *dogs = [LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
//                [_dogInfos setObject:dogs forKey:model.liveId];
                [_dogInfos setValue:dogs forKey:model.liveId];
            }
            if (pnum == _dogInfos.count) {
                DLog(@"%@", _dogInfos);
                [self.tableView reloadData];
                [self hideHud];
            }
        }error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
- (void)getRequestBanner {
    [self getRequestWithPath:API_Banner params:nil success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [BannerModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"info"]];
        self.banaerArray = arr;
        NSMutableArray *bannerArr = [NSMutableArray array];
        for (BannerModel *model in arr) {
            [bannerArr addObject:model.img];
        }
        self.urlArray = bannerArr;
        [self.tableView reloadData];
//        NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
//        [self.tableView reloadSections:index withRowAnimation:(UITableViewRowAnimationNone)];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithSize:(DogCategoryModel *)size {
    NSDictionary *dict = @{
                           @"size":@([size.ID intValue])
                           };
        [self.tableView setContentOffset:CGPointMake(0, 0)];
    [self showHudInView:self.tableView hint:@"加载中"];
    [self getRequestWithPath:API_Live_retrieve params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (_page == 1) {// 下拉
            if (!successJson[@"data"][@"data"]) { // 如果没有数据
                [self.liveListArray removeAllObjects];
                [self.dogInfos removeAllObjects];
                [self hideHud];
                [self.tableView reloadData];
            }else {
                /** 所有信息 */
                NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
                self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                [self loadProductInfo];
            }
        }else{            // 上拉
            NSArray *dataarr = successJson[@"data"][@"data"];
            [self.tableView.mj_footer endRefreshingWithCompletionBlock:^{
                [self.tableView.mj_footer endRefreshing];
                if (dataarr.count == 0) {
                    [self showAlert:@"没有更多了"];
                    [self hideHud];
                    self.page = self.page - 1;
                    return ;
                }else{
                    NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:dataarr];
                    self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                    [self loadProductInfo];
                    if (dataarr.count < 10) {
                        [self showAlert:@"没有更多了"];
                        self.page = self.page - 1;
                        return ;
                    }
                }
            }];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinAge:(DogCategoryModel *)minAge MaxAge:(DogCategoryModel *)maxAge  {
    NSDictionary *dict = @{
                           @"t":@(minAge.time),
                           @"e":@(maxAge.time),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
        [self.tableView setContentOffset:CGPointMake(0, 0)];
    [self showHudInView:self.tableView hint:@"加载中"];
    [self getRequestWithPath:API_Age_screening params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (_page == 1) {// 下拉
            if (!successJson[@"data"][@"data"]) { // 如果没有数据
                [self.liveListArray removeAllObjects];
                [self.dogInfos removeAllObjects];
                [self hideHud];
                [self.tableView reloadData];
            }else {
                /** 所有信息 */
                NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
                self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                [self loadProductInfo];
            }
        }else{            // 上拉
            NSArray *dataarr = successJson[@"data"][@"data"];
            [self.tableView.mj_footer endRefreshingWithCompletionBlock:^{
                [self.tableView.mj_footer endRefreshing];
                if (dataarr.count == 0) {
                    [self showAlert:@"没有更多了"];
                    [self hideHud];
                    self.page = self.page - 1;
                    return ;
                }else{
                    NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:dataarr];
                    self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                    [self loadProductInfo];
                    if (dataarr.count < 10) {
                        [self showAlert:@"没有更多了"];
                        self.page = self.page - 1;
                        return ;
                    }
                }
            }];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinPrice:(DogCategoryModel *)minPrice MaxPrice:(DogCategoryModel *)maxPrice  {
    NSDictionary *dict = @{
                           @"start_price":minPrice.name,
                           @"end_price":maxPrice.name,
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self.tableView setContentOffset:CGPointMake(0, 0)];
    [self showHudInView:self.tableView hint:@"加载中"];
    [self getRequestWithPath:API_Live_list_new_im params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (_page == 1) {// 下拉
            if (!successJson[@"data"][@"data"]) { // 如果没有数据
                [self.liveListArray removeAllObjects];
                [self.dogInfos removeAllObjects];
                [self hideHud];
                [self.tableView reloadData];
            }else {
                /** 所有信息 */
                NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
                self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                [self loadProductInfo];
            }
        }else{            // 上拉
            NSArray *dataarr = successJson[@"data"][@"data"];
            [self.tableView.mj_footer endRefreshingWithCompletionBlock:^{
                [self.tableView.mj_footer endRefreshing];
                if (dataarr.count == 0) {
                    [self showAlert:@"没有更多了"];
                    [self hideHud];
                    self.page = self.page - 1;
                    return ;
                }else{
                    NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:dataarr];
                    self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
                    [self loadProductInfo];
                    if (dataarr.count < 10) {
                        [self showAlert:@"没有更多了"];
                        self.page = self.page - 1;
                        return ;
                    }
                }
            }];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    _page = 1;
    [self getRequestBanner];
    [self getRequestLiveList];
}

- (void)initUI {
    
    self.edgesForExtendedLayout = 0;

    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64));
    }];

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        _page = 1;
        [self getRequestLiveList];
        [self getRequestBanner];
        [self.tableView.mj_header endRefreshing];
    }];
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        _page ++;
        [self getRequestLiveList];
//        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark
#pragma mark - 懒加载

- (NoneNetWorkingView *)noneNetView {
    if (!_noneNetView) {
        _noneNetView = [[NoneNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneNetView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];    }
    return _noneNetView;
}
- (NSArray *)urlArray {
    if (!_urlArray) {
        _urlArray = [NSArray array];
    }
    return _urlArray;
}
- (NSArray *)banaerArray {
    if (!_banaerArray) {
        _banaerArray = [NSArray array];
    }
    return _banaerArray;
}

- (NSMutableDictionary *)dogInfos {
    if (!_dogInfos) {
        _dogInfos = [NSMutableDictionary dictionary];
    }
    return _dogInfos;
}
- (NSMutableArray *)liveListArray {
    if (!_liveListArray) {
        _liveListArray = [NSMutableArray array];
    }
    return _liveListArray;
}
- (void)pushToLivingVc:(LiveViewCellModel *)model products:(NSArray *)dogInfos {
    DLog(@"%@", model.status);
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
    TalkingViewController *talkVc = [[TalkingViewController alloc] initWithConversationChatter:model.chatroom conversationType:(EMConversationTypeChatRoom)];
    talkVc.liverid = model.ID;
    talkVc.roomID = model.chatroom;
    talkVc.isNotification = YES;
    talkVc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:talkVc animated:YES];
}
#pragma mark
#pragma mark - 代理方法

// 轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    // 点击图片回调
    BannerModel *model = self.banaerArray[index];
    if (model.type == 0) { // 页面跳转
        BanaerViewController *banaerVc = [[BanaerViewController alloc] init];
        banaerVc.banaerURL = model.url;
        banaerVc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:banaerVc animated:YES];
    }else{ // 直播跳转
        if (model.status == 1) {
            LivingViewController *livingVC = [[LivingViewController alloc] init];
            livingVC.liveID = model.liveId;
            livingVC.liverId = model.ID;
            livingVC.liverIcon = model.userImgUrl;
            livingVC.liverName = model.merchantName;
            livingVC.watchCount = model.viewNum;
            livingVC.chatRoomID = model.chatroom;
            livingVC.isLandscape = NO;
            livingVC.hidesBottomBarWhenPushed = YES;
            if ([model.pNum integerValue] > 0) {
                NSDictionary *dict = @{
                                       @"live_id":model.liveId
                                       };
                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                    if (successJson[@"data"]) {
                        NSArray *doginfos = [LiveListDogInfoModel   mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                        livingVC.doginfos = doginfos;
                        [self.navigationController pushViewController:livingVC animated:YES];
                    }
                } error:^(NSError *error) {
                    
                }];

            }else{
                livingVC.doginfos = @[];
                [self.navigationController pushViewController:livingVC animated:YES];
            }
            
        }
    }
    DLog(@"%@", model.url);
}

#pragma mark
#pragma mark - 表格
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"LiveViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
// tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return self.liveListArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellid"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        cycleScrollView.imageURLStringsGroup = self.urlArray;
        // 滚动时间
        cycleScrollView.autoScrollTimeInterval = 3;
        // 动画
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolAlimentCenter;
        
        // 位置
        cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        // 颜色
        cycleScrollView.pageDotColor = [UIColor colorWithHexString:@"#ffffff"];
        // 选中颜色
        cycleScrollView.currentPageDotColor = [UIColor colorWithHexString:@"ffa11a"];
        [cell.contentView addSubview:cycleScrollView];
        return cell;
    }else{
        LiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        LiveViewCellModel *model = self.liveListArray[indexPath.row];
        cell.liveCellModel = model;
        //    cell.dogInfos = self.dogInfos[indexPath.row];
        if (model.pNum > 0) {
            NSArray *arr = [self.dogInfos valueForKey:model.liveId];
            cell.dogInfos = arr;
            DLog(@"%@", model.liveId);
            DLog(@"%@", arr);
            
            cell.cardBlcok = ^(UIControl *control){};
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    LiveViewCellModel *model = self.liveListArray[indexPath.row];
    //    cell.dogInfos = self.dogInfos[indexPath.row];
    NSArray *arr = [NSArray array];
    if (model.pNum != 0) {
        arr = [self.dogInfos valueForKey:model.liveId];
    }

    [self pushToLivingVc:model products:arr];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 110;
    }else{
        LiveViewCellModel *model = self.liveListArray[indexPath.row];
        if (model.pNum != 0) {
            return 355;
        }else{
            return 250;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else{
        return 44;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
      LiveFilteView  *filtView = [[LiveFilteView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 44)];
        filtView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        filtView.sizeBlock = ^(){
            
            DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
            sizeView.title = @"体型";
            NSDictionary *dict = @{
                                   @"type":@(4)
                                   };
            [weakSelf getRequestWithPath:API_Category params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                if (successJson) {
                    
                    sizeView.dataArr = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                    
                    [sizeView show];
                }
                
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
            
            //            __weak typeof(sizeView) weakView = sizeView;
            sizeView.bottomBlock = ^(DogCategoryModel *sizeModel){
                [weakSelf getRequestFilterLiveListWithSize:sizeModel];
            };
        };
        filtView.ageBlock = ^(){
            DogAgeFilter *ageView = [[DogAgeFilter alloc] init];
            NSDictionary *dict = @{
                                   @"type":@(1)
                                   };
            [weakSelf getRequestWithPath:API_Category params:dict success:^(id successJson) {
//                DLog(@"%@", successJson);
                ageView.dataPlist = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            [ageView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            
            ageView.ageRangeBlock = ^(DogCategoryModel *minString, DogCategoryModel *maxString){
                [weakSelf getRequestFilterLiveListWithMinAge:minString MaxAge:maxString];
            };
            
        };
        
        filtView.priceBlock = ^(){
            DogPriceFilter *priceView = [[DogPriceFilter alloc] init];
            NSDictionary *dict = @{
                                   @"type":@(8)
                                   };
            [weakSelf getRequestWithPath:API_Category params:dict success:^(id successJson) {
//                DLog(@"%@", successJson);
                priceView.dataPlist = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
            [priceView show];
            
            priceView.priceRangeBlock = ^(DogCategoryModel *minModel, DogCategoryModel *maxModel) {
                [weakSelf getRequestFilterLiveListWithMinPrice:minModel MaxPrice:maxModel];
            };
        };
        return filtView;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)test1 {
    
    //                /** 直播信息 */
    //                NSMutableArray *liveMutableArr = [NSMutableArray arrayWithCapacity:10];
    //                /** 狗狗信息 */
    ////                NSMutableArray *dogInfos = [NSMutableArray arrayWithCapacity:10];
    //                // 高度
    //                // 请求狗狗信息
    //                for (NSInteger i = 0; i < liveArr.count; i ++) {
    //
    //                    LiveViewCellModel *model = liveArr[i];
    //                    NSDictionary *dict = @{
    //                                           @"live_id":model.liveId
    //                                           };
    //                    [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
    //                        DLog(@"%@", successJson);
    //                        if (successJson[@"data"]) {
    //                            NSArray *dogs = [LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
    //                            DLog(@"%@", dogs);
    //                            [_dogInfos setObject:dogs forKey:model.liveId];
    ////                            [_dogInfos insertObject:dogs atIndex:i];
    ////                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
    //                        }
    //                        [liveMutableArr insertObject:model atIndex:i];
    //
    ////                        [liveMutableArr addObject:model];
    //                        if (liveMutableArr.count == liveArr.count) {
    //                            [self hideHud];
    ////                            self.dogInfos = dogInfos;
    //                            self.liveListArray = liveMutableArr;
    //                            [self.tableView reloadData];
    //                        }
    //                    } error:^(NSError *error) {
    //                        DLog(@"%@", error);
    //                    }];
    //                }
}
- (void)test2 {
    //            /** 直播信息 */
    //            NSMutableArray *liveMutableArr = [NSMutableArray arrayWithCapacity:10];
    //            /** 狗狗信息 */
    ////            NSMutableArray *dogInfos = [NSMutableArray arrayWithCapacity:10];
    //
    //            // 请求狗狗信息
    //            for (NSInteger i = 0; i < liveArr.count; i ++) {
    //
    //                LiveViewCellModel *model = liveArr[i];
    //                NSDictionary *dict = @{
    //                                       @"live_id":model.liveId
    //                                       };
    //                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
    //                    DLog(@"%@", successJson);
    //                    if (successJson[@"data"]) {
    ////                        [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
    ////                        [dogInfos insertObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]] atIndex:i];
    //                        NSArray *dogs = [LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
    //                        DLog(@"%@", dogs);
    //                        [_dogInfos setObject:dogs forKey:model.liveId];
    //
    //                    }
    ////                    [liveMutableArr addObject:model];
    //                    [liveMutableArr insertObject:model atIndex:i];
    //                    if (liveMutableArr.count == liveArr.count) {
    //                        [self hideHud];
    ////                        [self.dogInfos addObjectsFromArray:dogInfos];
    //                        [self.liveListArray addObjectsFromArray:liveMutableArr];
    //                        NSIndexSet *index = [NSIndexSet indexSetWithIndex:1];
    //                        [self.tableView reloadSections:index withRowAnimation:(UITableViewRowAnimationNone)];
    //                    }
    //                } error:^(NSError *error) {
    //                    DLog(@"%@", error);
    //                }];
    //            }

}
@end
