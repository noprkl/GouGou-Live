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
@end


@implementation RecommendViewController

#pragma mark
#pragma mark - 网络请求
- (void)getRequestLiveList {

    NSDictionary *dict = @{
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Live_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
//        self.tableView.dataPlist = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        
        CGRect rect = self.tableView.frame;
        rect.size.height = self.tableView.dataPlist.count * 357;
        self.tableView.frame = rect;
        [self.tableView reloadData];
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestLiveList];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)initUI {
    
    self.urlArray = @[@"http://d.hiphotos.baidu.com/image/h%3D200/sign=6008b360f336afc3110c38658318eb85/a1ec08fa513d26973aa9f6fd51fbb2fb4316d81c.jpg", @"http://d.hiphotos.baidu.com/image/h%3D200/sign=6008b360f336afc3110c38658318eb85/a1ec08fa513d26973aa9f6fd51fbb2fb4316d81c.jpg", @"http://d.hiphotos.baidu.com/image/h%3D200/sign=6008b360f336afc3110c38658318eb85/a1ec08fa513d26973aa9f6fd51fbb2fb4316d81c.jpg"];
    //    [self.view addSubview:self.noneNetView];

    [self.view addSubview:self.baseScrollView];
    
    [self.baseScrollView addSubview:self.cycleScrollView];
    [self.baseScrollView addSubview:self.tableView];
   
    [self.baseScrollView addSubview:self.filtView];
    
    self.edgesForExtendedLayout = 0;
    
    [self makeConstraint];
}
// 约束
- (void)makeConstraint {
    

}

#pragma mark
#pragma mark - 懒加载
- (UIScrollView *)baseScrollView {
    
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
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
        
        // 图片路径
        _cycleScrollView.imageURLStringsGroup = self.urlArray;
        
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
                DLog(@"%@", sizeModel);
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
                
            };
        };
    }
    return _filtView;
}

// 直播列表
- (LiveTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 154, SCREEN_WIDTH,1000) style:(UITableViewStylePlain)];

        _tableView.bounces = NO;

        __weak typeof(self) weakSelf = self;
        _tableView.cellBlock = ^(LiveViewCellModel *model){
            
            [weakSelf pushToLivingVc:model];
        };
        _tableView.dogCardBlock = ^(LiveViewCellModel *model){
            [weakSelf pushToLivingVc:model];
        };
    }
    return _tableView;
}
- (void)pushToLivingVc:(LiveViewCellModel *)model{
    DLog(@"%@", model);
    LivingViewController *livingVC = [[LivingViewController alloc] init];
    livingVC.liveID = model.liveId;
    livingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:livingVC animated:YES];
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
#pragma mark
#pragma mark - 代理方法

// 底部scrollview代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
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
    DLog(@"%ld", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
