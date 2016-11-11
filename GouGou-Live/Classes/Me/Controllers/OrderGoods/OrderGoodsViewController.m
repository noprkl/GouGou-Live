//
//  OrderGoodsViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "OrderGoodsViewController.h"
#import "TopButonView.h"

//static NSString * allGoodsCell = @"allGoodsCellID";

@interface OrderGoodsViewController ()<UIScrollViewDelegate>
/** 顶部View */
@property (strong,nonatomic) TopButonView *topView;
/** 底部滚动视图 */
@property (strong,nonatomic) UIScrollView *boomScrollView;
/** 子控制器 */
@property (strong,nonatomic) NSMutableArray *childVC;
/** 子控制器名字 */
@property (strong,nonatomic) NSArray *titleName;
/** 上一个控制器 */
@property(nonatomic, strong) UIViewController *lastVC;

@end

@implementation OrderGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.boomScrollView];
    
    [self addChildViewController];
}

#pragma mark
#pragma mark - 初始化
- (NSMutableArray *)childVC {

    if (!_childVC) {
        _childVC = [NSMutableArray array];
    }
    return _childVC;
}

- (UIScrollView *)boomScrollView {
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _boomScrollView.scrollEnabled = NO;
        _boomScrollView.pagingEnabled = YES;
        _boomScrollView.showsVerticalScrollIndicator = NO;
    }
    return _boomScrollView;
}
- (TopButonView *)topView {

    if (!_topView) {
        _topView  = [[TopButonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
        __weak typeof(self) weakself = self;

        _topView.difStateBlock = ^(NSInteger tag) {
        
            NSInteger flag = tag - 200 ;
            if (flag == 1) {
                
                CGPoint center = CGPointMake(1 * SCREEN_WIDTH, weakself.boomScrollView.contentOffset.y);
                
                [weakself.boomScrollView setContentOffset:center animated:YES];
            } else if (flag == 2) {
            
                CGPoint center = CGPointMake(2 * SCREEN_WIDTH, weakself.boomScrollView.contentOffset.y);
                
                [weakself.boomScrollView setContentOffset:center animated:YES];
            
            } else if (flag == 3) {
                
                CGPoint center = CGPointMake(flag * SCREEN_WIDTH, weakself.boomScrollView.contentOffset.y);
                
                [weakself.boomScrollView setContentOffset:center animated:YES];
                
            } else if (flag == 4) {
                
                CGPoint center = CGPointMake(flag * SCREEN_WIDTH, weakself.boomScrollView.contentOffset.y);
                
                [weakself.boomScrollView setContentOffset:center animated:YES];
                
            } else if (flag == 5) {
                
                CGPoint center = CGPointMake(flag * SCREEN_WIDTH, weakself.boomScrollView.contentOffset.y);
                
                [weakself.boomScrollView setContentOffset:center animated:YES];
                
            } else if (flag == 6) {
                
                CGPoint center = CGPointMake(flag * SCREEN_WIDTH, weakself.boomScrollView.contentOffset.y);
                
                [weakself.boomScrollView setContentOffset:center animated:YES];
                
            }
        };
    }
    return _topView;
}

- (void)addChildViewController {
    
    NSArray *childVCNames = @[@"AllOrderGoodsViewController", @"WaitPayingViewController", @"WaitConsignmentViewController", @"WatiConsigneeViewController",@"WaitAssessViewController",@"ProtectPowerViewController"];
    
    for (NSInteger i = 0; i < childVCNames.count; i ++) {
        UIViewController *vc = [[NSClassFromString(childVCNames[i]) alloc] init];
        
        [self addChildViewController:vc];
        [self.childVC addObject:vc];
    }
    
    // 将子控制器的view 加载到MainVC的ScrollView上  这里用的是加载时的屏幕宽
    self.boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.titleName.count, 0);
    
    // 设置contentView加载时的位置
    self.boomScrollView.contentOffset = CGPointMake(0, 0);
    
    // 减速结束加载控制器视图 代理
    self.boomScrollView.delegate = self;
    
    // 进入后第一次加载hot
    [self scrollViewDidEndDecelerating:self.boomScrollView];
}


#pragma mark
#pragma mark - scrollView代理
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 每个子控制器的宽高
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    
    // 偏移量 - x
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取视图的索引
    NSInteger index = offset / width;
    
    //根据索引返回vc的引用
    UIViewController *childVC = self.childViewControllers[index];
    
    self.lastVC = childVC;
    
    // 判断当前vc是否加载过
    if ([childVC isViewLoaded]) return;
    
    
    // 给没加载过的控制器设置frame
    childVC.view.frame = CGRectMake(offset, 0, width, height);
    
    // 添加控制器视图到contentScrollView上
    [scrollView addSubview:childVC.view];
    
    
    
}
// 减速结束时调用 加载子控制器view的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    // 传的调用这个代理方法的scrollview
    [self scrollViewDidEndScrollingAnimation:scrollView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
