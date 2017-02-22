//
//  DogTypesViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogTypesViewController.h"
#import "LiveViewCell.h"   // 直播列表
#import "LiveViewCellModel.h"
#import "LiveListDogInfoModel.h"
#import "LiveFilteView.h"   // 类型按钮View
#import "DogSizeFilter.h"
#import "DogAgeFilter.h"
#import "DogPriceFilter.h"
#import "LivingViewController.h"
#import "DogTypesView.h"
#import "MoreImpressViewController.h"
#import "NonoDogTypesView.h"
#import "PlayBackViewController.h"

@interface DogTypesViewController ()<UITableViewDataSource, UITableViewDelegate>

/** 底部ScrollView */
//@property (strong,nonatomic) UIScrollView *bottomScrollView;

/** 类型按钮 */
@property (strong,nonatomic) LiveFilteView *filteButtonView;

/** 直播列表 */
//@property (strong,nonatomic) LiveTableView *liveTableView;
///** 狗狗类型View */
//@property (strong,nonatomic) DogTypesView *typesView;

/** 没搜到直播 */
@property (strong, nonatomic) NonoDogTypesView *noneView;

@property (nonatomic, strong) UITableView *tableView; /**< 表格 */
@property (nonatomic, strong) NSMutableArray *liveListArray;
@property (nonatomic, strong) NSMutableDictionary *dogInfos; /**< 狗狗信息 */

@end

static NSString *cellid = @"RecommentCellid";

@implementation DogTypesViewController
- (void)loadView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    self.view = view;
}

- (void)getRequestImpressionLiveList {
    NSDictionary *dict = @{
                           @"impression":@([_dogType.ID intValue])
                           };
    [self showHudInView:self.view hint:@"正在加载"];
    [self getRequestWithPath:API_Live_retrieve params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"data"][@"num"] isEqualToString:@"0"]) {
            [self hideHud];
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
            [self.tableView reloadData];
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;

            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
            [self loadProductInfo];
        }

        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)getRequestFilterLiveListWithSize:(DogCategoryModel *)size {
    NSDictionary *dict = @{
                           @"im_id":_dogType.ID,
                           @"size":size.ID,
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self showHudInView:self.view hint:@"正在加载"];
    [self getRequestWithPath:API_Live_retrieve params:dict success:^(id successJson) {
//        [self.liveTableView.dataPlist removeAllObjects];
//        [self.liveTableView.dogInfos removeAllObjects];
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        DLog(@"%@", successJson);
        if ([successJson[@"data"][@"num"] isEqualToString:@"0"]) {
             [self hideHud];
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
             [self.tableView reloadData];
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
            [self loadProductInfo];
        }

    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinAge:(DogCategoryModel *)minAge MaxAge:(DogCategoryModel *)maxAge  {
    NSDictionary *dict = @{
                           //                           @"size":@([size.ID intValue])
                           @"im_id":_dogType.ID,
                           @"start_age":@(minAge.time),
                           @"end_age":@(maxAge.time),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    DLog(@"%@", dict);
    [self showHudInView:self.view hint:@"正在加载"];
    [self getRequestWithPath:API_Live_list_new_im params:dict success:^(id successJson) {
//        DLog(@"%@", successJson);
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
         if ([successJson[@"data"][@"num"] isEqualToString:@"0"]) {
             [self hideHud];
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
             [self.tableView reloadData];
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
            [self loadProductInfo];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestFilterLiveListWithMinPrice:(DogCategoryModel *)minPrice MaxPrice:(DogCategoryModel *)maxPrice  {
    NSDictionary *dict = @{
                           //                           @"size":@([size.ID intValue])
                           @"im_id":_dogType.ID,
                           @"start_price":@(minPrice.time),
                           @"end_price":@(maxPrice.time),
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self showHudInView:self.view hint:@"正在加载"];
    [self getRequestWithPath:API_Live_list_new_im params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
        if ([successJson[@"data"][@"num"] isEqualToString:@"0"]) {
            [self hideHud];
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
            [self.tableView reloadData];
        }else{
            self.noneView.hidden = YES;
            self.tableView.hidden = NO;
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            self.liveListArray = [NSMutableArray arrayWithArray:liveArr];
            [self loadProductInfo];

        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)loadProductInfo {
    [self.dogInfos removeAllObjects];
    NSInteger pnum = 0;
   
    for (NSInteger i = 0; i < self.liveListArray.count; i ++) {
        
        LiveViewCellModel *model = self.liveListArray[i];
        if (model.pNum != 0) {
            pnum ++;
        }

        NSDictionary *dict = @{
                               @"live_id":model.liveId
                               };
        [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
//            DLog(@"第几个%ld", i);
//            DLog(@"%@", successJson);
            if (successJson[@"data"]) {
                
                NSArray *dogs = [LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                [_dogInfos setObject:dogs forKey:model.liveId];
            }
            if (_dogInfos.count == pnum) {
                [self hideHud];
                [self.tableView reloadData];
            }
        }error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    
}
- (void)initUI {

    [self setNavBarItem];

    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.filteButtonView];
    [self.filteButtonView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(0);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.height.equalTo(44);
    }];
    [self.view addSubview:self.noneView];
    [self.noneView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filteButtonView.bottom).offset(1);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view.bottom);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.filteButtonView.bottom).offset(1);
        make.left.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    
//    [self.view addSubview:self.bottomScrollView];
//    [self.bottomScrollView addSubview:self.liveTableView];
//    [self addViews];
    
    [self getRequestImpressionLiveList];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getRequestImpressionLiveList];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回-拷贝"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addViews {

//    __weak typeof(self) weakself = self;
//    [_filteButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.top.equalTo(weakself.view.top);
//        make.left.right.equalTo(weakself.view);
//        make.height.equalTo(44);
//    }];
//    
//    [_bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.filteButtonView.bottom).offset(5);
//        make.left.right.bottom.equalTo(weakself.view);
//    }];

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes =  @{
                                                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],                         NSFontAttributeName:[UIFont systemFontOfSize:18]                              };
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.titleTextAttributes =  @{
                                                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],                         NSFontAttributeName:[UIFont systemFontOfSize:18]                              };
    
}

//- (UIScrollView *)bottomScrollView {
//    
//    if (!_bottomScrollView) {
//        _bottomScrollView = [[UIScrollView alloc] init];
//        _bottomScrollView.contentSize = CGSizeMake(0, 1000);
//        _bottomScrollView.showsHorizontalScrollIndicator = NO;
//        _bottomScrollView.delegate = self;
//    }
//    return _bottomScrollView;
//}
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
//- (LiveTableView *)liveTableView {
//    if (!_liveTableView) {
//        _liveTableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 1000) style:(UITableViewStylePlain)];
//        
//        _liveTableView.bounces = NO;
//        
//        __weak typeof(self) weakSelf = self;
//        _liveTableView.cellBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
//            
//            if ([model.status isEqualToString:@"1"]) {
//                LivingViewController *livingVC = [[LivingViewController alloc] init];
//                livingVC.liveID = model.liveId;
//                livingVC.liverId = model.ID;
//                livingVC.liverIcon = model.userImgUrl;
//                livingVC.liverName = model.merchantName;
//                livingVC.doginfos = dogInfos;
//                livingVC.watchCount = model.viewNum;
//                livingVC.chatRoomID = model.chatroom;
//                livingVC.state = model.status;
//                livingVC.isLandscape = NO;
//                livingVC.hidesBottomBarWhenPushed = YES;
//                [weakSelf.navigationController pushViewController:livingVC animated:YES];
//            }
//            if ([model.status isEqualToString:@"3"]) {
//                PlayBackViewController *livingVC = [[PlayBackViewController alloc] init];
//                livingVC.liveID = model.liveId;
//                livingVC.liverId = model.ID;
//                livingVC.liverIcon = model.userImgUrl;
//                livingVC.liverName = model.merchantName;
//                livingVC.doginfos = dogInfos;
//                livingVC.watchCount = model.viewNum;
//                livingVC.chatRoomID = model.chatroom;
//                livingVC.isLandscape = NO;
//                livingVC.hidesBottomBarWhenPushed = YES;
//                [weakSelf.navigationController pushViewController:livingVC animated:YES];
//            }
//            
//        };
//    }
//    return _liveTableView;
//}
   
- (NonoDogTypesView *)noneView {
    if (!_noneView) {
        _noneView = [[NonoDogTypesView alloc] initWithFrame:CGRectMake(0, 154, SCREEN_WIDTH, SCREEN_HEIGHT - 154)];
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        __weak typeof(self) weakSelf = self;
        _noneView.requestBlock = ^(){
            weakSelf.noneView.hidden = YES;
            [weakSelf getRequestImpressionLiveList];
        };
    }
    return _noneView;
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.liveListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    LiveViewCellModel *model = self.liveListArray[indexPath.row];
    cell.liveCellModel = model;
    //    cell.dogInfos = self.dogInfos[indexPath.row];
    if (model.pNum != 0) {
        NSArray *arr = [self.dogInfos valueForKey:model.liveId];
        cell.dogInfos = arr;
        cell.cardBlcok = ^(UIControl *control){};
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
    LiveViewCellModel *model = self.liveListArray[indexPath.row];
    if (model.pNum != 0) {
        return 365;
    }else{
        return 250;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
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
            weakSelf.noneView.hidden = YES;
            [weakSelf getRequestFilterLiveListWithSize:sizeModel];
        };
    };
    filtView.ageBlock = ^(){
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
            weakSelf.noneView.hidden = YES;
            [weakSelf getRequestFilterLiveListWithMinAge:minString MaxAge:maxString];
        };
        
    };
    
    filtView.priceBlock = ^(){
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
            weakSelf.noneView.hidden = YES;
            [weakSelf getRequestFilterLiveListWithMinPrice:minModel MaxPrice:maxModel];
        };
    };
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 250;
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

- (void)test1 {
//    [self.liveTableView.dataPlist removeAllObjects];
//    [self.liveTableView.dogInfos removeAllObjects];
//    [self.bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    if ([successJson[@"code"] isEqualToString:@"0"]) {
//        [self hideHud];
//        self.noneView.hidden = NO;
//        self.liveTableView.hidden = YES;
//        [self.liveTableView reloadData];
//    }else{
//        self.noneView.hidden = YES;
//        self.liveTableView.hidden = NO;
//        /** 所有信息 */
//        NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
//        /** 直播信息 */
//        NSMutableArray *liveMutableArr = [NSMutableArray array];
//        /** 狗狗信息 */
//        NSMutableArray *dogInfos = [NSMutableArray array];
//        // 高度
//        __block CGFloat height = 0;
//        // 请求狗狗信息
//        for (NSInteger i = 0; i < liveArr.count; i ++) {
//            
//            LiveViewCellModel *model = liveArr[i];
//            NSDictionary *dict = @{
//                                   @"live_id":model.liveId
//                                   };
//            [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
//                //                DLog(@"%@", successJson);
//                if (successJson[@"data"]) {
//                    height += 357;
//                    [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
//                }else{
//                    height += 250;
//                    [dogInfos addObject:@[]];
//                }
//                
//                [liveMutableArr addObject:model];
//                
//                if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
//                    
//                    CGRect rect = self.liveTableView.frame;
//                    rect.size.height = height;
//                    self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
//                    self.liveTableView.frame = rect;
//                    self.liveTableView.dogInfos = dogInfos;
//                    self.liveTableView.dataPlist = liveMutableArr;
//                    [self.liveTableView reloadData];
//                    [self hideHud];
//                }
//            } error:^(NSError *error) {
//                DLog(@"%@", error);
//            }];
//        }
//        [self hideHud];
//        [self.liveTableView reloadData];
//    }

}
- (void)test2 {
    //            /** 所有信息 */
    //            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
    //            /** 直播信息 */
    //            NSMutableArray *liveMutableArr = [NSMutableArray array];
    //            /** 狗狗信息 */
    //            NSMutableArray *dogInfos = [NSMutableArray array];
    //            // 高度
    //            __block CGFloat height = 0;
    //            // 请求狗狗信息
    //            for (NSInteger i = 0; i < liveArr.count; i ++) {
    //
    //                LiveViewCellModel *model = liveArr[i];
    //                NSDictionary *dict = @{
    //                                       @"live_id":model.liveId
    //                                       };
    //                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
    //                    //                DLog(@"%@", successJson);
    //                    if (successJson[@"data"]) {
    //                        height += 357;
    //                        [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
    //                    }else{
    //                        height += 250;
    //                        [dogInfos addObject:@[]];
    //                    }
    //
    //                    [liveMutableArr addObject:model];
    //
    //                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
    //
    //                        CGRect rect = self.liveTableView.frame;
    //                        rect.size.height = height;
    //                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
    //                        self.liveTableView.frame = rect;
    //                        self.liveTableView.dogInfos = dogInfos;
    //                        self.liveTableView.dataPlist = liveMutableArr;
    //                        [self.liveTableView reloadData];
    //                        [self hideHud];
    //                    }
    //                } error:^(NSError *error) {
    //                    DLog(@"%@", error);
    //                }];
    //            }
    //            [self hideHud]
    //            [self.liveTableView reloadData];
    //        }
}
- (void)test3 {
    //            /** 所有信息 */
    //            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
    //            /** 直播信息 */
    //            NSMutableArray *liveMutableArr = [NSMutableArray array];
    //            /** 狗狗信息 */
    //            NSMutableArray *dogInfos = [NSMutableArray array];
    //            // 高度
    //            __block CGFloat height = 0;
    //            // 请求狗狗信息
    //            for (NSInteger i = 0; i < liveArr.count; i ++) {
    //
    //                LiveViewCellModel *model = liveArr[i];
    //                NSDictionary *dict = @{
    //                                       @"live_id":model.liveId
    //                                       };
    //                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
    //                    //                DLog(@"%@", successJson);
    //                    if (successJson[@"data"]) {
    //                        height += 357;
    //                        [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
    //                    }else{
    //                        height += 250;
    //                        [dogInfos addObject:@[]];
    //                    }
    //
    //                    [liveMutableArr addObject:model];
    //
    //                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
    //
    //                        CGRect rect = self.liveTableView.frame;
    //                        rect.size.height = height;
    //                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
    //                        self.liveTableView.frame = rect;
    //                        self.liveTableView.dogInfos = dogInfos;
    //                        self.liveTableView.dataPlist = liveMutableArr;
    //                        [self.liveTableView reloadData];
    //                        [self hideHud];
    //                    }
    //                } error:^(NSError *error) {
    //                    DLog(@"%@", error);
    //                }];
    //            }
    //            [self.liveTableView reloadData];
    //            [self hideHud];

}
- (void)test4 {
    //        [self.liveTableView.dataPlist removeAllObjects];
    //        [self.liveTableView.dogInfos removeAllObjects];
    //        [self.bottomScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    //        if ([successJson[@"data"][@"num"] isEqualToString:@"0"]) {
    //            self.noneView.hidden = NO;
    //            self.liveTableView.hidden = YES;
    //             [self.liveTableView reloadData];
    //             [self hideHud];
    //
    //        }else{
    //            self.noneView.hidden = YES;
    //            self.liveTableView.hidden = NO;
    //            /** 所有信息 */
    //            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
    //            /** 直播信息 */
    //            NSMutableArray *liveMutableArr = [NSMutableArray array];
    //            /** 狗狗信息 */
    //            NSMutableArray *dogInfos = [NSMutableArray array];
    //            // 高度
    //            __block CGFloat height = 0;
    //            // 请求狗狗信息
    //            for (NSInteger i = 0; i < liveArr.count; i ++) {
    //
    //                LiveViewCellModel *model = liveArr[i];
    //                NSDictionary *dict = @{
    //                                       @"live_id":model.liveId
    //                                       };
    //                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
    //                    //                DLog(@"%@", successJson);
    //                    if (successJson[@"data"]) {
    //                        height += 357;
    //                        [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
    //                    }else{
    //                        height += 250;
    //                        [dogInfos addObject:@[]];
    //                    }
    //
    //                    [liveMutableArr addObject:model];
    //
    //                    if (dogInfos.count == liveArr.count&&liveMutableArr.count == liveArr.count) {
    //
    //                        CGRect rect = self.liveTableView.frame;
    //                        rect.size.height = height;
    //                        self.bottomScrollView.contentSize = CGSizeMake(0, height + 110 + 64);
    //                        self.liveTableView.frame = rect;
    //                        self.liveTableView.dogInfos = dogInfos;
    //                        self.liveTableView.dataPlist = liveMutableArr;
    //                        [self.liveTableView reloadData];
    //                        [self hideHud];
    //                    }
    //                } error:^(NSError *error) {
    //                    DLog(@"%@", error);
    //                }];
    //            }
    //            [self hideHud];
    //            [self.liveTableView reloadData];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
