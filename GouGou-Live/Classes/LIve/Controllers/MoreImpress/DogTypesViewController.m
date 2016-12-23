//
//  DogTypesViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogTypesViewController.h"
#import "LiveTableView.h"   // 直播列表
#import "LiveFilteView.h"   // 类型按钮View
#import "DogSizeFilter.h"
#import "DogAgeFilter.h"
#import "DogPriceFilter.h"
#import "LivingViewController.h"
#import "DogTypesView.h"
#import "MoreImpressViewController.h"
#import "NoneFocusView.h"

@interface DogTypesViewController ()<UIScrollViewDelegate>

/** 底部ScrollView */
@property (strong,nonatomic) UIScrollView *bottomScrollView;

/** 类型按钮 */
@property (strong,nonatomic) LiveFilteView *filteButtonView;

/** 直播列表 */
@property (strong,nonatomic) LiveTableView *liveTableView;
///** 狗狗类型View */
//@property (strong,nonatomic) DogTypesView *typesView;

/** 没搜到直播 */
@property (strong, nonatomic) NoneFocusView *noneView;

@end

@implementation DogTypesViewController
- (void)getRequestImpressionLiveList {
    NSDictionary *dict = @{
                           @"impression":@([_dogType.ID intValue])
                           };
    [self getRequestWithPath:API_Live_retrieve params:dict success:^(id successJson) {
        [self.liveTableView.dataPlist removeAllObjects];
        [self.liveTableView.dogInfos removeAllObjects];
        [self.bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.liveTableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.liveTableView.hidden = NO;
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
                    }else{
                        height += 357;
                        
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                        }
                    }
                    [liveMutableArr addObject:model];

                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
                        
                        CGRect rect = self.liveTableView.frame;
                        rect.size.height = height;
                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.liveTableView.frame = rect;
                        self.liveTableView.dogInfos = dogInfos;
                        self.liveTableView.dataPlist = liveMutableArr;
                        [self.liveTableView reloadData];
                        //                    [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //                    [self hideHud]
            [self.liveTableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)getRequestFilterLiveListWithSize:(DogCategoryModel *)size {
    NSDictionary *dict = @{
                           @"im_id":@([_dogType.ID intValue]),
                           @"size":@([size.ID intValue]),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Live_retrieve params:dict success:^(id successJson) {
        [self.liveTableView.dataPlist removeAllObjects];
        [self.liveTableView.dogInfos removeAllObjects];
        [self.bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.liveTableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.liveTableView.hidden = NO;
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
                        
                        CGRect rect = self.liveTableView.frame;
                        rect.size.height = height;
                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.liveTableView.frame = rect;
                        self.liveTableView.dogInfos = dogInfos;
                        self.liveTableView.dataPlist = liveMutableArr;
                        [self.liveTableView reloadData];
                        //                    [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //                    [self hideHud]
            [self.liveTableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinAge:(DogCategoryModel *)minAge MaxAge:(DogCategoryModel *)maxAge  {
    NSDictionary *dict = @{
                           //                           @"size":@([size.ID intValue])
                           @"im_id":@([_dogType.ID intValue]),
                           @"start_age":@(minAge.time),
                           @"end_age":@(maxAge.time),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Live_list_new_im params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.liveTableView.dataPlist removeAllObjects];
        [self.liveTableView.dogInfos removeAllObjects];
        [self.bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.liveTableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.liveTableView.hidden = NO;
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
                        
                        CGRect rect = self.liveTableView.frame;
                        rect.size.height = height;
                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.liveTableView.frame = rect;
                        self.liveTableView.dogInfos = dogInfos;
                        self.liveTableView.dataPlist = liveMutableArr;
                        [self.liveTableView reloadData];
                        //                    [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //                    [self hideHud]
            [self.liveTableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinPrice:(DogCategoryModel *)minPrice MaxPrice:(DogCategoryModel *)maxPrice  {
    NSDictionary *dict = @{
                           //                           @"size":@([size.ID intValue])
                           @"im_id":@([_dogType.ID intValue]),
                           @"start_price":@(minPrice.time),
                           @"end_price":@(maxPrice.time),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Live_list_new_im params:dict success:^(id successJson) {
        
        [self.liveTableView.dataPlist removeAllObjects];
        [self.liveTableView.dogInfos removeAllObjects];
        [self.bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.liveTableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
            self.liveTableView.hidden = NO;
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
                        
                        CGRect rect = self.liveTableView.frame;
                        rect.size.height = height;
                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
                        self.liveTableView.frame = rect;
                        self.liveTableView.dogInfos = dogInfos;
                        self.liveTableView.dataPlist = liveMutableArr;
                        [self.liveTableView reloadData];
                        //                    [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //                    [self hideHud]
            [self.liveTableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {

    [self setNavBarItem];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.filteButtonView];
    [self.view addSubview:self.bottomScrollView];
    [self.bottomScrollView addSubview:self.liveTableView];
    [self addViews];
    
    self.bottomScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getRequestImpressionLiveList];
        [self.bottomScrollView.mj_header endRefreshing];
    }];
    
}
- (void)addViews {

    __weak typeof(self) weakself = self;
    [_filteButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.view.top);
        make.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
    }];
    
    [_bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.filteButtonView.bottom).offset(5);
        make.left.right.bottom.equalTo(weakself.view);
    }];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes =  @{
                                                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],                         NSFontAttributeName:[UIFont systemFontOfSize:18]                              };
    [self getRequestImpressionLiveList];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes =  @{
                                                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],                         NSFontAttributeName:[UIFont systemFontOfSize:18]                              };
    
}

- (UIScrollView *)bottomScrollView {
    
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] init];
        _bottomScrollView.contentSize = CGSizeMake(0, 1000);
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        _bottomScrollView.delegate = self;
    }
    return _bottomScrollView;
}
// 筛选按钮
- (LiveFilteView *)filteButtonView {
    if (!_filteButtonView) {
        _filteButtonView = [[LiveFilteView alloc] init];
        _filteButtonView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _filteButtonView.sizeBlock = ^(){
            
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
                DLog(@"%@", sizeModel);
                weakSelf.noneView.hidden = YES;
                [weakSelf getRequestFilterLiveListWithSize:sizeModel];
            };
        };
        _filteButtonView.ageBlock = ^(){
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
        
        _filteButtonView.priceBlock = ^(){
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
    return _filteButtonView;
}

// 直播列表
- (LiveTableView *)liveTableView {
    if (!_liveTableView) {
        _liveTableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 1000) style:(UITableViewStylePlain)];
        
        _liveTableView.bounces = NO;
        
        __weak typeof(self) weakSelf = self;
        _liveTableView.cellBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
            
            LivingViewController *livingVC = [[LivingViewController alloc] init];
            livingVC.liveID = model.liveId;
            livingVC.liverName = model.merchantName;
            livingVC.doginfos = dogInfos;
            livingVC.chatRoomID = model.chatroom;
            livingVC.state = model.status;
            livingVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:livingVC animated:YES];
            
        };
    }
    return _liveTableView;
}

- (NoneFocusView *)noneView {
    if (!_noneView) {
        _noneView = [[NoneFocusView alloc] initWithFrame:CGRectMake(0, 154, SCREEN_WIDTH, SCREEN_HEIGHT - 154)];
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        __weak typeof(self) weakSelf = self;
        _noneView.requestBlock = ^(NSString *text){
            weakSelf.noneView.hidden = YES;
            [weakSelf getRequestImpressionLiveList];
        };
    }
    return _noneView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
