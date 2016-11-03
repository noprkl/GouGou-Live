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
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.filteButtonView];
    [self.view addSubview:self.bottomScrollView];
    [self.bottomScrollView addSubview:self.liveTableView];
    [self addViews];
    [self setNav];


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
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
    
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
        _filteButtonView.sizeBlock = ^(){
            
            DogSizeFilter *sizeView = [[DogSizeFilter alloc] init];
            [sizeView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            
            sizeView.sizeCellBlock = ^(NSString *size){
                DLog(@"%@", size);
            };
            
        };
        _filteButtonView.ageBlock = ^(){
            DogAgeFilter *ageView = [[DogAgeFilter alloc] init];
            ageView.dataPlist = @[@"不限", @"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月", @"1岁", @"2岁", @"3岁", @"4岁", @"5岁", @"6岁", @"7岁", @"以上"];
            [ageView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            
            ageView.ageRangeBlock = ^(NSString *minString, NSString *maxString){
                
                DLog(@"%@--%@", minString, maxString);
            };
            
        };
        _filteButtonView.priceBlock = ^(){
            DogPriceFilter *priceView = [[DogPriceFilter alloc] init];
            priceView.dataPlist = @[@"不限", @"50", @"100", @"150", @"200", @"300", @"400", @"500", @"1000", @"2000", @"5000", @"1万", @"以上"];
            [priceView show];
            
            //            __weak typeof(sizeView) weakView = sizeView;
            
            priceView.priceRangeBlock = ^(NSString *minString, NSString *maxString){
                
                DLog(@"%@--%@", minString, maxString);
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
        _liveTableView.cellBlock = ^(){
            
            LivingViewController *livingVC = [[LivingViewController alloc] init];
            
            livingVC.hidesBottomBarWhenPushed = YES;
            [weakSelf.navigationController pushViewController:livingVC animated:YES];
            
        };
    }
    return _liveTableView;
}

- (void)setNav {

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    self.navigationController.navigationBar.titleTextAttributes =  @{
                                                                     NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],
                                                                     NSFontAttributeName:[UIFont systemFontOfSize:18]
                                                                     };
}

- (void)backAction {

    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
