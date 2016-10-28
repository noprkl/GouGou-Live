//
//  LiveViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveTopView.h"
#import "SearchViewController.h"


@interface LiveViewController ()<UIScrollViewDelegate>

/** 底部的scrollview */
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

/** 子控制器名字 */
@property (strong, nonatomic) NSArray *childTitle;

/** 头部按钮 */
@property (strong, nonatomic) LiveTopView *topView;

@end


@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createAddChildVC];
    [self setNavView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}
#pragma mark
#pragma mark - 设置导航栏
- (void)setNavView{
    
    self.navigationItem.titleView = self.topView;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"01"] style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftBarAction)];
}
- (void)LeftBarAction {
    
    SearchViewController *searchVC = [[SearchViewController alloc] initWithStyle:(UITableViewStylePlain)];
    
    UISearchController *searchC = [[UISearchController alloc] initWithSearchResultsController:searchVC];
    
    [self.navigationController pushViewController:searchC animated:YES];
}

#pragma mark - 添加子控制器
- (void)createAddChildVC{
  
    NSArray *childVCName = @[@"FocusViewController", @"RecommendViewController", @"HostViewController"];
    
    for (NSInteger i = 0; i < childVCName.count; i ++) {
        
        NSString *vcName = childVCName[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
        vc.title = self.childTitle[i];
        
        // 执行addChildViewController时不会执行viewDidLoad 视图不会被加载
        [self addChildViewController:vc];
    }
    
    // 将子控制器的view 加载到MainVC的ScrollView上  这里用的是加载时的屏幕宽
    self.contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childTitle.count, 0);
    
    // 设置contentView加载时的位置
    self.contentView.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
    
    // 减速结束加载控制器视图 代理
    self.contentView.delegate = self;
    
    // 进入后第一次加载hot
    [self scrollViewDidEndDecelerating:self.contentView];
}
#pragma mark
#pragma mark - UIScrollViewDelegate代理

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 每个子控制器的宽高
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    
    // 偏移量 - x
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取视图的索引
    NSInteger index = offset / width;
    
    // 标题线
    [self.topView scrolling:index];
    
    //根据索引返回vc的引用
    UIViewController *childVC = self.childViewControllers[index];
    
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


#pragma mark
#pragma mark - 懒加载

- (NSArray *)childTitle {
    if (!_childTitle) {
        _childTitle = @[@"关注", @"展播", @"最新"];
    }
    return _childTitle;
}
- (LiveTopView *)topView {
    
    if (!_topView) {
        
        _topView = [[LiveTopView alloc] initWithFrame:CGRectMake(0, 0, 250, 44) titleNames:self.childTitle tapView:^(NSInteger btnTag) {
            
            _topView.backgroundColor = [UIColor colorWithRed:152/255.0 green:204/255.0 blue:42/255.0 alpha:1];
            
            CGPoint center = CGPointMake(btnTag * SCREEN_WIDTH, self.contentView.contentOffset.y);
            
            [self.contentView setContentOffset:center animated:YES];
        }];
    }
    return _topView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
