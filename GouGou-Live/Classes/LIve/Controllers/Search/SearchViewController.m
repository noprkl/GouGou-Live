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
#import "HaveNoneLiveView.h"

@interface SearchViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) LiveTableView *tableView; /**< tableView */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入 */

@property (nonatomic, strong) NSMutableArray *dogInfos; /**< 狗狗信息 */

@property(nonatomic, strong) HaveNoneLiveView *noneView; /**< 没人直播 */
@end

/** cellid */
static NSString *cellid = @"RecommentCellid";

@implementation SearchViewController
#pragma mark
#pragma mark - 网络请求
- (void)getRequestLiveList {
    
    NSDictionary *dict = @{
                           @"tel":self.titleInputView.text
                           };
    [self getRequestWithPath:API_Search_live params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.tableView.dataPlist removeAllObjects];
        [self.tableView.dogInfos removeAllObjects];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneView.hidden = NO;
            self.tableView.hidden = YES;
        }else{
            self.noneView.hidden = YES;
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
                    //                DLog(@"%@", successJson);
                    if (model.pNum == 0) {
                        [dogInfos addObject:@[]];
                        DLog(@"%ld", i);
                    }else{
                        DLog(@"%ld", i);
                        if (successJson[@"data"]) {
                            [dogInfos addObject:[LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]]];
                        }
                    }
                    [liveMutableArr addObject:model];

                    if (dogInfos.count == liveArr.count && liveMutableArr.count == liveArr.count) {
                        DLog(@"%ld", i);
                        self.tableView.dogInfos = dogInfos;
                        self.tableView.dataPlist = liveMutableArr;
                        [self.tableView reloadData];
                        //                    [self hideHud];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
            //    [self hideHud]
        }
//        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
       [self initUI];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.noneView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
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
- (HaveNoneLiveView *)noneView {
    if (!_noneView) {
        _noneView = [[HaveNoneLiveView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneView.hidden = YES;
        _noneView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
        __weak typeof(self) weakSelf = self;
        _noneView.backBlock = ^(){
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _noneView;
}
- (void)pushToLivingVc:(LiveViewCellModel *)model products:(NSArray *)dogInfos {
    DLog(@"%@", model);
    LivingViewController *livingVC = [[LivingViewController alloc] init];
    livingVC.liveID = model.liveId;
    livingVC.liverId = model.ID;
    livingVC.liverIcon = model.userImgUrl;
    livingVC.liverName = model.merchantName;
    livingVC.doginfos = dogInfos;
    livingVC.watchCount = model.viewNum;
    livingVC.chatRoomID = model.chatroom;
    livingVC.state = model.status;
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

    if ([NSString valiMobile:self.titleInputView.text]) {
        [self.titleInputView resignFirstResponder];
        [self getRequestLiveList];
    }else{
        [self showAlert:@"请输入正确的手机号"];
    }
}
- (void)editSearchAction:(UITextField *)textField {

}
#pragma mark - Tableview 代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.titleInputView) {
        BOOL flag = [NSString validateNumber:textField.text];
        if (flag) {
            return YES;
        }
        return NO;
    }
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
