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
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "LoginViewController.h"
#import "ProtecePowerPromptView.h"
#import "NSString+CertificateImage.h"

@interface LiveViewController ()<UIScrollViewDelegate>

/** 底部的scrollview */
@property (weak, nonatomic) IBOutlet UIScrollView *contentView;

/** 子控制器名字 */
@property (strong, nonatomic) NSArray *childTitle;

/** 头部按钮 */
@property (strong, nonatomic) LiveTopView *topView;

@property (nonatomic, strong) NSTimer *timer; /**< 定时器 */

@end


@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createAddChildVC];
    [self setNavView];
    
    if ([UserInfos getUser]) {
        // 把之前的干掉
        self.timer = nil;
//        [self.timer invalidate];
        // 重新开线程
        self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(RequestBlackUser) userInfo:nil repeats:YES];
    }
}
- (void)RequestBlackUser {
   
    if ([UserInfos getUser]) {
        NSDictionary *dict = @{
                               @"user_id":[UserInfos sharedUser].ID
                               };
        [self getRequestWithPath:API_Memberstate params:dict success:^(id successJson) {
            if ([successJson[@"code"] integerValue] == 0) {// 0拉黑用户 1正常用户
                // 关闭定时器
                [self.timer invalidate];
                self.timer = nil;

                // 退出登录
                [UserInfos removeUser];
                [UserInfos sharedUser].usertel = @"";
                [[NSUserDefaults standardUserDefaults] synchronize];
                // 退出环信
                [[EMClient sharedClient] logout:YES];
                ProtecePowerPromptView *promptView = [[ProtecePowerPromptView alloc] init];
                promptView.message = @"此账号因违反平台协议被限制使用";
                [promptView show];
                
                promptView.sureApplyBtnBlock = ^(UIButton *btn){
                    LoginViewController *loginVc = [[LoginViewController alloc] init];
                    loginVc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:loginVc animated:YES];
                };

            }
        } error:^(NSError *error) {
            
            DLog(@"%@", error);
        }];
    }else{
        [self.timer invalidate];
        self.timer = nil;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];

}
#pragma mark
#pragma mark - 设置导航栏
- (void)setNavView{
    
    self.navigationItem.titleView = self.topView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索放大镜"] style:(UIBarButtonItemStylePlain) target:self action:@selector(LeftBarAction)];
    
}
- (void)LeftBarAction {
    
    SearchViewController *searchVC = [[SearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
    
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img.mp.itc.cn/upload/20170326/7bcac329e7604ad99b3d1ba12462e0c8_th.jpeg"]];
//        UIImage *image = [UIImage imageWithData:data];
//        
//        NSString *base64 = [NSString imageBase64WithDataURL:image];
//        NSDictionary *dict = @{
//                               @"img":base64
//                               };
//        [self postRequestWithPath:Api_UploadImg_test params:dict success:^(id successJson) {
//            DLog(@"%@", successJson);
//        } error:^(NSError *error) {
//            
//        }];
//
//    });
}

#pragma mark - 添加子控制器
- (void)createAddChildVC{
  
    NSArray *childVCName = @[@"FocusViewController", @"RecommendViewController", @"HostViewController"];
    
    for (NSInteger i = 0; i < childVCName.count; i ++) {
        
        NSString *vcName = childVCName[i];
        UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
//        vc.title = self.childTitle[i];
        
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

    if (offset < 0.5 *width){
        offset = 0;
    }else if (offset < 1.5 *width && offset > 0.5){
        offset = 1 * width;
    }else if (offset < 2.5 *width && offset > 1.5 * width) {
        offset = 2 * width;
    }
    
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
        _childTitle = @[@"关注", @"推荐", @"最新"];
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
- (void)dealloc {
    self.timer = nil;
    [self.timer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
