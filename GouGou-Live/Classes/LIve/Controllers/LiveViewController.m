//
//  LiveViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

/** 屏幕宽 */
#define SCREEN_WITH [UIScreen mainScreen].bounds.size.width
/** 屏幕高 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


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
    
//    self.view.backgroundColor = [UIColor orangeColor];

    
    [self createAddChildVC];
    [self setNavView];
}
- (void)setNavView{
    self.navigationItem.titleView = self.topView;
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search"] style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftBarAction)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftBarAction)];
}
- (void)LeftBarAction {
    
    SearchViewController *searchVC = [[SearchViewController alloc] initWithStyle:(UITableViewStylePlain)];
    
    UISearchController *searchC = [[UISearchController alloc] initWithSearchResultsController:searchVC];
    
    [self.navigationController pushViewController:searchC animated:YES];
}
- (void)createAddChildVC{
  
    NSArray *childVCName = @[@"FocusViewController", @"RecommendViewController", @"HostViewController"];
    
    for (NSInteger i = 0; i < childVCName.count; i ++) {
        // 创建子控制器
        NSString *childName = childVCName[i];
        UIViewController *vc = [[NSClassFromString(childName) alloc] init];
        [self addChildViewController:vc];
        
    }
    // 将子控制器的view 加载到MainVC的ScrollView上  这里用的是加载时的屏幕宽
    self.contentView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * self.childTitle.count, 0);
    
    // 设置contentScrollView加载时的位置
    self.contentView.contentOffset = CGPointMake(SCREEN_WITH, 0);
    
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
    CGFloat width = SCREEN_WITH;
    CGFloat height = SCREEN_HEIGHT;
    
    // 偏移量 - x
    CGFloat offset = scrollView.contentOffset.x;
    
    // 获取视图的索引
    NSInteger index = offset / width;
    NSLog(@"index-%ld", index);
    //根据索引返回vc的引用
    UIViewController *childVC = self.childViewControllers[index];
    NSLog(@"%@", childVC);
    
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
        _childTitle = @[@"关注", @"推荐", @"最新"];
    }
    return _childTitle;
}
- (LiveTopView *)topView {
    if (!_topView) {
        _topView = [[LiveTopView alloc] initWithFrame:CGRectMake(0, 0, 200, 40) titleNames:self.childTitle tapView:^(NSInteger btnTag) {
            
            NSLog(@"btnTag-%ld", btnTag);
            
//            self.contentScrollView.contentOffset = CGPointMake(btnTag * SCREEN_WITH, self.contentScrollView.contentOffset.y);
            
//            [self.contentScrollView setContentOffset:CGPointMake(btnTag * SCREEN_WITH, self.contentScrollView.contentOffset.y) animated:YES];
            
            CGPoint point = CGPointMake(btnTag * SCREEN_WITH, self.contentView.contentOffset.y);
            [self.contentView setContentOffset:point animated:YES];
            
            NSLog(@"%@", NSStringFromCGPoint(self.contentView.contentOffset));
        }];
        
        
    }
    return _topView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
