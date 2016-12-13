//
//  SearchViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SearchViewController.h"
#import "LiveTableView.h"
#import "LiveViewCellModel.h"
#import "LiveListDogInfoModel.h"
#import "LivingViewController.h"

@interface SearchViewController ()

@property(nonatomic, strong) LiveTableView *tableView; /**< tableView */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入 */

@property (nonatomic, strong) NSMutableArray *dogInfos; /**< 狗狗信息 */

@end

/** cellid */
static NSString *cellid = @"RecommentCellid";

@implementation SearchViewController
#pragma mark
#pragma mark - 网络请求
- (void)getRequestLiveList {
    
    NSDictionary *dict = @{
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Live_new_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.dogInfos removeAllObjects];
        
        self.tableView.dataPlist = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
        if (self.tableView.dataPlist.count == 0) {
            
        }else{
            // 高度
            __block CGFloat height = 0;
            // 请求狗狗信息
            for (NSInteger i = 0; i < self.tableView.dataPlist.count; i ++) {
                LiveViewCellModel *model = self.tableView.dataPlist[i];
                if (model.pNum == 0) {
                    [self.dogInfos addObject:@[]];
                    height += 239;
                    
                }else{
                    NSDictionary *dict = @{
                                           @"live_id":model.liveId
                                           };
                    [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                        DLog(@"%@", successJson);
                        [self.dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                        height += 357;
                        if (self.dogInfos.count == self.tableView.dataPlist.count) {
                            self.tableView.dogInfos = self.dogInfos;
                            [self.tableView reloadData];
                        }
                    } error:^(NSError *error) {
                        DLog(@"%@", error);
                    }];
                }
                if (self.dogInfos.count == self.tableView.dataPlist.count) {
                    self.tableView.dogInfos = self.dogInfos;
                    [self.tableView reloadData];
                }
            }
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.dogInfos = @[];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 64, 0));
    }];
    [self setNavBarItem];
    [self.navigationItem setTitleView:self.titleInputView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSureButtonAction)];
   
}
// 直播列表
- (LiveTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 154, SCREEN_WIDTH,1000) style:(UITableViewStylePlain)];
        
        _tableView.bounces = NO;
        
        __weak typeof(self) weakSelf = self;
        
        _tableView.cellBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
            [weakSelf pushToLivingVc:model products:dogInfos];
        };
        _tableView.dogCardBlock = ^(LiveViewCellModel *model, NSArray *dogInfos){
            [weakSelf pushToLivingVc:model products:dogInfos];
        };
    }
    return _tableView;
}
- (void)pushToLivingVc:(LiveViewCellModel *)model products:(NSArray *)dogInfos {
    DLog(@"%@", model);
    LivingViewController *livingVC = [[LivingViewController alloc] init];
    livingVC.liveID = model.liveId;
    livingVC.liverId = model.ID;
    livingVC.liverIcon = model.userImgUrl;
    livingVC.liverName = model.merchantName;
    livingVC.doginfos = dogInfos;
    livingVC.watchCount = model.pNum;
    livingVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:livingVC animated:YES];
}

- (UITextField *)titleInputView {
    if (!_titleInputView) {
        _titleInputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        _titleInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入搜索的用户账号" attributes:@{
                                                                                                                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _titleInputView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _titleInputView.layer.cornerRadius = 5;
        _titleInputView.layer.masksToBounds = YES;
        _titleInputView.delegate = self;
        _titleInputView.font = [UIFont systemFontOfSize:14];
        [_titleInputView addTarget:self action:@selector(editSearchAction:) forControlEvents:(UIControlEventAllEvents)];
    }
    return _titleInputView;
}
- (void)clickSureButtonAction {
    
}
- (void)editSearchAction:(UITextField *)textField {

}
#pragma mark - Tableview 代理



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
