//
//  SearchViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define History @"SEARCHDOGTYPEHISSTORY"

#import "SearchViewController.h"
#import "LiveTableView.h"
#import "LiveViewCellModel.h"
#import "LiveListDogInfoModel.h"
#import "LivingViewController.h"
#import "HaveNoneLiveView.h"
#import "PlayBackViewController.h"
#import "NoinputSearchKindView.h" // 初始界面
#import "LiveHotSearchModel.h"
@interface SearchViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) LiveTableView *tableView; /**< tableView */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 直播数据源 */

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入 */

@property (nonatomic, strong) NSMutableArray *dogInfos; /**< 狗狗信息 */

@property(nonatomic, strong) HaveNoneLiveView *noneView; /**< 没人直播 */

@property (nonatomic, strong) NoinputSearchKindView *noinputView; /**< 没搜索view */

@property (nonatomic, strong) NSArray *hotArr; /**< 热搜数据 */

@end

/** cellid */
static NSString *cellid = @"RecommentCellid";

@implementation SearchViewController
// 热搜请求
- (void)getRequestHotLive {
    
    [self getRequestWithPath:API_Kind_recommand params:nil success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            self.hotArr = [LiveHotSearchModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            self.noinputView.hotArr = self.hotArr;
            [self.noinputView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)getRequestLiveWithKind:(NSString *)kind {
    [self.titleInputView resignFirstResponder];
    // 搜索
    NSDictionary *dict = @{
                           @"kind":kind
                           };
    [self getRequestWithPath:API_Live_kind params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"data"] count] == 0) {
            
            self.noinputView.hidden = YES;
            self.tableView.hidden = YES;
            self.noneView.hidden = NO;
        }else{
            [self.tableView.dataPlist removeAllObjects];
            [self.tableView.dogInfos removeAllObjects];
            if (successJson[@"data"][@"num"] == 0) { // 如果为0刷新
                [self.tableView reloadData];
            }
            self.tableView.hidden = NO;
            
            //        [self showHudInView:self.view hint:@"刷新中"];
            /** 所有信息 */
            NSArray *liveArr = [LiveViewCellModel mj_objectArrayWithKeyValuesArray:successJson[@"data"][@"data"]];
            /** 直播信息 */
            NSMutableArray *liveMutableArr = [NSMutableArray array];
            /** 狗狗信息 */
            NSMutableArray *dogInfos = [NSMutableArray array];
            // 请求狗狗信息
            for (NSInteger i = 0; i < liveArr.count; i ++) {
                
                LiveViewCellModel *model = liveArr[i];
                NSDictionary *dict = @{
                                       @"live_id":model.liveId
                                       };
                [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    if (model.pNum == 0) {
                        [dogInfos addObject:@[]];
                    }else{
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                        }
                    }
                    [liveMutableArr addObject:model];
                    
                    if (dogInfos.count == liveArr.count && liveMutableArr.count == liveArr.count) {
                        self.tableView.dogInfos = dogInfos;
                        self.tableView.dataPlist = liveMutableArr;
                        [self.tableView reloadData];
                        [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //                    [self hideHud]
            //        [self.tableView reloadData];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
    // 本地
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:History]];
    // NSArray --> NSMutableArray
    NSMutableArray *historyArr = [myArray mutableCopy];
    
    // 可变数组存放一样的数据
    NSMutableArray *searTXT = [NSMutableArray array];
    //        searTXT = [myArray mutableCopy];

    if (historyArr.count > 0) {
        //搜索本地内容
        for (NSString * str in historyArr) {
            if ([kind isEqualToString:str]) {
                [searTXT addObject:kind];
            }
        }
    }
    // 搜索一样的数据 删除
    [historyArr removeObjectsInArray:searTXT];
    [historyArr insertObject:kind atIndex:0];
    // 存放限制 10个
    if(searTXT.count > 10)
        {
        [searTXT removeLastObject];
        }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:historyArr forKey:History];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.noinputView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noneView];
    self.noinputView.hidden = NO;
    self.tableView.hidden = YES;
    self.noneView.hidden = YES;
    [self getRequestHotLive];
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索icon-拷贝"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSearchBtnAction)];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

    [self.navigationItem setTitleView:self.titleInputView];
}
- (void)clickSearchBtnAction {
    if (self.titleInputView.text.length != 0) {
        [self getRequestLiveWithKind:self.titleInputView.text];
    }
}
- (void)editSearchAction:(UITextField *)textField {
    if (textField.text.length == 0) {
        // 刷新
        self.noinputView.hidden = NO;
        [self.noinputView reloadData];
        self.tableView.hidden = YES;
        self.noneView.hidden = YES;
    }
}
#pragma mark
#pragma mark - 懒加载
- (UITextField *)titleInputView {
    if (!_titleInputView) {
        _titleInputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        _titleInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入您的狗狗品种" attributes:@{
                                                                                                                    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],                                                                                                      NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _titleInputView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _titleInputView.layer.cornerRadius = 5;
        _titleInputView.layer.masksToBounds = YES;
        _titleInputView.delegate = self;
        _titleInputView.font = [UIFont systemFontOfSize:14];
        [_titleInputView addTarget:self action:@selector(editSearchAction:) forControlEvents:(UIControlEventAllEvents)];
    }
    return _titleInputView;
}
- (LiveTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LiveTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) style:(UITableViewStylePlain)];
        
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
// 初始view
- (NoinputSearchKindView *)noinputView {
    if (!_noinputView) {
        _noinputView = [[NoinputSearchKindView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        _noinputView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        __weak typeof(self) weakSelf = self;
        _noinputView.typeBlock = ^(NSString *kind){
            // 热搜搜索
            weakSelf.titleInputView.text = kind;
            [weakSelf getRequestLiveWithKind:kind];
        };
        _noinputView.cellBlock = ^(NSString *kind){
            // 点击搜索历史搜索
            weakSelf.titleInputView.text = kind;
            [weakSelf getRequestLiveWithKind:kind];
        };
    }
    return _noinputView;
}
- (HaveNoneLiveView *)noneView {
    if (!_noneView) {
        _noneView = [[HaveNoneLiveView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64))];
        // 返回
        __weak typeof(self) weakSelf = self;
        _noneView.backBlock = ^(){
            weakSelf.noneView.hidden = YES;
            weakSelf.tableView.hidden = YES;
            weakSelf.noinputView.hidden = NO;
            weakSelf.titleInputView.text = @"";
            [weakSelf editSearchAction:weakSelf.titleInputView];
        };
    }
    return _noneView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
