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

@interface DogTypesViewController ()<UIScrollViewDelegate>

/** 底部ScrollView */
@property (strong,nonatomic) UIScrollView *bottomScrollView;

/** 类型按钮 */
@property (strong,nonatomic) LiveFilteView *filteButtonView;

/** 直播列表 */
@property (strong,nonatomic) LiveTableView *liveTableView;
///** 狗狗类型View */
//@property (strong,nonatomic) DogTypesView *typesView;

@end

@implementation DogTypesViewController

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
        _liveTableView.cellBlock = ^(LiveViewCellModel *model){
            
            LivingViewController *livingVC = [[LivingViewController alloc] init];
            livingVC.liveID = model.liveId;
            livingVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:livingVC animated:YES];
            
        };
    }
    return _liveTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
