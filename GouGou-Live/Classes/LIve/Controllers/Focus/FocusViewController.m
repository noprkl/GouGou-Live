//
//  FocusViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FocusViewController.h"
#import "NoneFocusView.h"
#import "NoneNetWorkingView.h"

#import "LiveTableView.h"
#import "LiveViewCell.h" // 自定义cell
#import "LivingViewController.h"

@interface FocusViewController ()

/** 无关注人 */
@property (strong, nonatomic) NoneFocusView *noneView;


@property(nonatomic, strong) NoneNetWorkingView *noneNetView; /**< 无网 */

/** 有人列表 */
@property (strong, nonatomic) LiveTableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation FocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = 64;
    
    [self loadFocusView];
}
- (void)loadFocusView {
    
    // 先判断是否有网，然后请求数据 如果没有添加无主播 否则添加 有主播
//    [self.view addSubview:self.noneNetView];
    
//    [self.view addSubview:self.noneView];
    
    [self.view addSubview:self.tableView];
}

#pragma mark
#pragma mark - 懒加载
- (NoneFocusView *)noneView {
    if (!_noneView) {
        _noneView = [[NoneFocusView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    }
    return _noneView;
}
- (NoneNetWorkingView *)noneNetView {
    if (!_noneNetView) {
        _noneNetView = [[NoneNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneNetView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];    }
    return _noneNetView;
}
- (LiveTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:(UITableViewStylePlain)];
        
        __weak typeof(self) weakSelf = self;
        _tableView.cellBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
            
        LivingViewController *livingVC = [[LivingViewController alloc] init];
        livingVC.hidesBottomBarWhenPushed = YES;
        livingVC.liveID = model.liveId;
        [weakSelf.navigationController pushViewController:livingVC animated:YES];
            
        };
    }
    return _tableView;
}
- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
