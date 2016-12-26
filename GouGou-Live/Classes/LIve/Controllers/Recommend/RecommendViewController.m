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

#import "LivingViewController.h"
#import "LiveViewCellModel.h"

#import "NoneFocusView.h"
#import "BannerModel.h"
@interface RecommendViewController ()<UIScrollViewDelegate, SDCycleScrollViewDelegate>

/** 底部scrollview */
@property (strong, nonatomic) UIScrollView *baseScrollView;

@property(nonatomic, strong) NoneNetWorkingView *noneNetView; /**< 无网 */

/** 轮播视图 */
@property (strong, nonatomic) SDCycleScrollView *cycleScrollView;
/** 轮播图片的URL数组 */
@property (strong, nonatomic) NSArray *urlArray;

/** 筛选按钮 */
@property (strong, nonatomic) LiveFilteView *filtView;
/** 列表 */
@property (strong, nonatomic) LiveTableView *tableView;
/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataSource;
/** 直播列表 */
@property (nonatomic, strong) NSMutableArray *liveListArray;

@property(nonatomic, strong) UILabel *noneLiveLabel; /**< 没有直播 */

@property (nonatomic, strong) NSMutableArray *dogInfos; /**< 狗狗信息 */

/** 没搜到直播 */
@property (strong, nonatomic) NoneFocusView *noneView;

@end


@implementation RecommendViewController

#pragma mark
#pragma mark - 网络请求
- (void)getRequestLiveList {

    NSDictionary *dict = @{
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Live_new_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView.dataPlist removeAllObjects];
        [self.tableView.dogInfos removeAllObjects];
        [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if (successJson[@"data"][@"num"] == 0) { // 如果为0刷新
            [self.tableView reloadData];
        }
        self.tableView.hidden = NO;

//        [self showHudInView:self.view hint:@"刷新中"];
        /** 所有信息 */
        NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
        /** 直播信息 */
        NSMutableArray *liveMutableArr = [NSMutableArray array];
        /** 狗狗信息 */
        NSMutableArray *dogInfos = [NSMutableArray array];
        // 高度
       __block CGFloat height = 0;
        // 请求狗狗信息
        for (NSInteger i = 0; i < liveArr.count; i ++) {
            
            LiveViewCellModel *model = liveArr[i];
            NSDictionary *dict = @{
                                   @"live_id":model.liveId
                                   };
            [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                if (model.pNum == 0) {
                    height += 240;
                    [dogInfos addObject:@[]];
                }else{
                    height += 357;
                    if (successJson[@"data"]) {
                        [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                    }
                }
                [liveMutableArr addObject:model];

                if (dogInfos.count == liveArr.count && liveMutableArr.count == liveArr.count) {
                    CGRect rect = self.tableView.frame;
                    rect.size.height = height;
                    self.baseScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                    self.tableView.frame = rect;
                    self.tableView.dogInfos = dogInfos;
                    self.tableView.dataPlist = liveMutableArr;
                    [self.tableView reloadData];
                    [self hideHud];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
        //                    [self hideHud]
//        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestBanner {
    [self getRequestWithPath:API_Banner params:nil success:^(id successJson) {
        DLog(@"%@", successJson);
        self.urlArray = [BannerModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        
        [self.baseScrollView addSubview:self.cycleScrollView];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithSize:(DogCategoryModel *)size {
    NSDictionary *dict = @{
                           @"size":@([size.ID intValue])
                           };
    [self getRequestWithPath:API_Live_retrieve params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView.dataPlist removeAllObjects];
        [self.tableView.dogInfos removeAllObjects];
        [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            /** 直播信息 */
            NSMutableArray *liveMutableArr = [NSMutableArray array];
            /** 狗狗信息 */
            NSMutableArray *dogInfos = [NSMutableArray array];
            // 高度
            __block CGFloat height = 0;
            // 请求狗狗信息
            for (NSInteger i = 0; i < liveArr.count; i ++) {
                
                LiveViewCellModel *model = liveArr[i];
                NSDictionary *dict = @{
                                       @"live_id":model.liveId
                                       };
                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                    //                DLog(@"%@", successJson);
                    if (model.pNum == 0) {
                        height += 240;
                        [dogInfos addObject:@[]];
                        [liveMutableArr addObject:model];
                        
                    }else{
                        height += 357;
                        
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                            [liveMutableArr addObject:model];
                        }
                    }
                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
                        
                        CGRect rect = self.tableView.frame;
                        rect.size.height = height;
                        self.baseScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.tableView.frame = rect;
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
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinAge:(DogCategoryModel *)minAge MaxAge:(DogCategoryModel *)maxAge  {
    NSDictionary *dict = @{
//                           @"size":@([size.ID intValue])
                           @"t":@(minAge.time),
                           @"e":@(maxAge.time),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Age_screening params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView.dataPlist removeAllObjects];
        [self.tableView.dogInfos removeAllObjects];
        [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            /** 直播信息 */
            NSMutableArray *liveMutableArr = [NSMutableArray array];
            /** 狗狗信息 */
            NSMutableArray *dogInfos = [NSMutableArray array];
            // 高度
            __block CGFloat height = 0;
            // 请求狗狗信息
            for (NSInteger i = 0; i < liveArr.count; i ++) {
                
                LiveViewCellModel *model = liveArr[i];
                NSDictionary *dict = @{
                                       @"live_id":model.liveId
                                       };
                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                    //                DLog(@"%@", successJson);
                    if (model.pNum == 0) {
                        height += 240;
                        [dogInfos addObject:@[]];
                        [liveMutableArr addObject:model];
                        
                    }else{
                        height += 357;
                        
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                            [liveMutableArr addObject:model];
                        }
                    }
                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
                        
                        CGRect rect = self.tableView.frame;
                        rect.size.height = height;
                        self.baseScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.tableView.frame = rect;
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
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinPrice:(DogCategoryModel *)minPrice MaxPrice:(DogCategoryModel *)maxPrice  {
    NSDictionary *dict = @{
                           //                           @"size":@([size.ID intValue])
                           @"t":@([minPrice.ID intValue]),
                           @"e":@([maxPrice.ID intValue]),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Age_screening params:dict success:^(id successJson) {
        
        [self.tableView.dataPlist removeAllObjects];
        [self.tableView.dogInfos removeAllObjects];
        [self.baseScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            /** 直播信息 */
            NSMutableArray *liveMutableArr = [NSMutableArray array];
            /** 狗狗信息 */
            NSMutableArray *dogInfos = [NSMutableArray array];
            // 高度
            __block CGFloat height = 0;
            // 请求狗狗信息
            for (NSInteger i = 0; i < liveArr.count; i ++) {
                
                LiveViewCellModel *model = liveArr[i];
                NSDictionary *dict = @{
                                       @"live_id":model.liveId
                                       };
                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                    //                DLog(@"%@", successJson);
                    if (model.pNum == 0) {
                        height += 240;
                        [dogInfos addObject:@[]];
                        [liveMutableArr addObject:model];
                        
                    }else{
                        height += 357;
                        
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                            [liveMutableArr addObject:model];
                        }
                    }
                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
                        
                        CGRect rect = self.tableView.frame;
                        rect.size.height = height;
                        self.baseScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.tableView.frame = rect;
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
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self getRequestLiveList];
    [self getRequestBanner];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    
    
    //    [self.view addSubview:self.noneNetView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.view addSubview:self.baseScrollView];
    [self.view addSubview:self.noneView];
//    [self.baseScrollView addSubview:self.cycleScrollView];
    [self.baseScrollView addSubview:self.tableView];
    [self.baseScrollView addSubview:self.filtView];
    
    self.edgesForExtendedLayout = 0;
    
    
    // 上下拉刷新
    self.baseScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.noneView.hidden = YES;
        [self getRequestLiveList];
        [self.baseScrollView.mj_header endRefreshing];
    }];
    self.baseScrollView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        [self getRequestLiveList];
        [self.baseScrollView.mj_footer endRefreshing];
    }];
}


#pragma mark
#pragma mark - 懒加载
- (UIScrollView *)baseScrollView {
    
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 110)];
        _baseScrollView.contentSize = CGSizeMake(0, 1000);
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.showsVerticalScrollIndicator = NO;
        _baseScrollView.delegate = self;
    }
    return _baseScrollView;
}

// 轮播视图
- (SDCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 110) delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        
        // 滚动时间
        _cycleScrollView.autoScrollTimeInterval = 3;
        
        // 动画
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolAlimentCenter;

        // 位置
        _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        
        // 颜色
        _cycleScrollView.pageDotColor = [UIColor colorWithHexString:@"#ffffff"];
        // 选中颜色
        _cycleScrollView.currentPageDotColor = [UIColor colorWithHexString:@"ffa11a"];
        NSMutableArray *bannerArr = [NSMutableArray array];
        for (BannerModel *model in self.urlArray) {
            [bannerArr addObject:model.img];
        }
        self.cycleScrollView.imageURLStringsGroup = bannerArr;
        // 图片路径
        _cycleScrollView.imageURLStringsGroup = bannerArr;
        
    }
    return _cycleScrollView;
}
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

// 筛选按钮
- (LiveFilteView *)filtView {
    if (!_filtView) {
        _filtView = [[LiveFilteView alloc] initWithFrame:CGRectMake(0, 110, SCREEN_WIDTH, 44)];
        _filtView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _filtView.sizeBlock = ^(){
            
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
        _filtView.ageBlock = ^(){
            DogAgeFilter *ageView = [[DogAgeFilter alloc] init];
            NSDictionary *dict = @{
                                   @"type":@(1)
                                   };
            [weakSelf getRequestWithPath:API_Category params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
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
        
        _filtView.priceBlock = ^(){
            DogPriceFilter *priceView = [[DogPriceFilter alloc] init];
            NSDictionary *dict = @{
                                   @"type":@(8)
                                   };
            [weakSelf getRequestWithPath:API_Category params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                priceView.dataPlist = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
            [priceView show];
            
            priceView.priceRangeBlock = ^(DogCategoryModel *minModel, DogCategoryModel *maxModel) {
                [weakSelf getRequestFilterLiveListWithMinPrice:minModel MaxPrice:maxModel];
            };
        };
    }
    return _filtView;
}

- (NSMutableArray *)dogInfos {
    if (!_dogInfos) {
        _dogInfos = [NSMutableArray array];
    }
    return _dogInfos;
}
// 直播列表
- (LiveTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 154, SCREEN_WIDTH,1000) style:(UITableViewStylePlain)];

        _tableView.bounces = NO;

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
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NoneFocusView *)noneView {
    if (!_noneView) {
        _noneView = [[NoneFocusView alloc] initWithFrame:CGRectMake(0, 154, SCREEN_WIDTH, SCREEN_HEIGHT - 154)];
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        __weak typeof(self) weakSelf = self;
        _noneView.requestBlock = ^(NSString *text){
            weakSelf.noneView.hidden = YES;
            [weakSelf getRequestLiveList];
        };
    }
    return _noneView;
}
#pragma mark
#pragma mark - 代理方法

// 底部scrollview代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGRect rect = self.filtView.frame;
    if (scrollView.contentOffset.y > 110) {
        rect.origin.y = scrollView.contentOffset.y;
    }else{
        rect.origin.y = 110;
    }
    self.filtView.frame = rect;
    
}

// 轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    // 点击图片回调
    BannerModel *model = self.urlArray[index];
    DLog(@"%@", model.url);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
