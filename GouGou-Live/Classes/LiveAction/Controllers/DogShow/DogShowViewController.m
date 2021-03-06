//
//  DogShowViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogShowViewController.h"
#import "DogShowMessageCell.h"
#import "ShareAlertView.h"
#import "ShareBtnModel.h"
#import "DogBookViewController.h"
#import "BuyRuleAlertView.h"

#import "DogDetailModel.h"
#import "DogImageView.h"
#import "NormalModel.h"

#import "LiveListDogInfoModel.h"

@interface DogShowViewController ()<UITableViewDataSource, UITableViewDelegate>

/** TableView */
@property (strong, nonatomic) UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray *dataArr;

/** cell */
@property (strong, nonatomic) DogShowMessageCell *cell;

@property(nonatomic, strong) NSArray *shareAlertBtns; /**< 分享模型数组 */

//@property(nonatomic, strong) ShareAlertView *shareAlert; /**< 分享view */

@end

static NSString *cellid = @"DogShowCellid";

@implementation DogShowViewController
- (void)getRequestDogInfos {
    NSDictionary *dict = @{@"live_id":_liveid};
    [self getRequestWithPath:API_Live_list_product params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [LiveListDogInfoModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        
    }];

}
#pragma mark
#pragma mark - 生命周期
//- (void)loadView {
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 290)];
//    view.backgroundColor = [UIColor whiteColor];
//    self.view = view;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self getRequestDogInfos];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.hidesBottomBarWhenPushed = YES;
}

- (void)initUI {
    
    [self.view addSubview:self.tableView];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {

    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.decelerationRate = 0.9;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DogShowMessageCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSArray *)shareAlertBtns {
    if (!_shareAlertBtns) {
        _shareAlertBtns = [NSArray array];
        
        ShareBtnModel *model1 = [[ShareBtnModel alloc] initWithTitle:@"朋友圈" image:[UIImage imageNamed:@"朋友圈selected"]];
        
        ShareBtnModel *model2 = [[ShareBtnModel alloc] initWithTitle:@"微信" image:[UIImage imageNamed:@"微信select"]];
        
        ShareBtnModel *model3 = [[ShareBtnModel alloc] initWithTitle:@"QQ空间" image:[UIImage imageNamed:@"QQ空间"]];
        ShareBtnModel *model4 = [[ShareBtnModel alloc] initWithTitle:@"新浪微博" image:[UIImage imageNamed:@"新浪微博"]];
        ShareBtnModel *model5 = [[ShareBtnModel alloc] initWithTitle:@"QQ" image:[UIImage imageNamed:@"QQ-(1)"]];
        
        _shareAlertBtns = @[model1, model2, model3, model4, model5];
    }
    return _shareAlertBtns;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DogShowMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    LiveListDogInfoModel *model = self.dataArr[indexPath.row];
    cell.model = model;

    self.cell = cell;
    __weak typeof(self) weakSelf = self;
    
    cell.shareBlock = ^ (){
        
       __block ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, self.view.bounds.size.width, 150) alertModels:self.shareAlertBtns tapView:^(NSInteger btnTag) {
            
            NSInteger index = btnTag - 20;
            switch (index) {
                case 0:
                {
                    // 朋友圈
                    [weakSelf WechatTimeShare];
                    shareAlert = nil;
                    [shareAlert dismiss];
                }
                    break;
                case 1:
                    {
                        // 微信
                        [weakSelf WChatShare];
                        shareAlert = nil;
                        [shareAlert dismiss];
                    }
                    break;
                case 2:
                    {
                        // QQ空间
                        [weakSelf TencentShare];
                        shareAlert = nil;
                        [shareAlert dismiss];
                    }
                    break;
                case 3:
                    {
                        // 新浪微博
                        [weakSelf SinaShare];
                        shareAlert = nil;
                        [shareAlert dismiss];
                    }
                    break;
                case 4:
                    {
                        // QQ
                        [weakSelf QQShare];
                        shareAlert = nil;
                        [shareAlert dismiss];
                    }
                    break;
                    
                default:
                    break;
            }
        } colCount:4];
        [shareAlert show];
    };
    // 喜欢
    cell.likeBlock = ^ (){
        if ([UserInfos getUser]) {
            // 添加喜欢的狗
            NSDictionary *dict = @{
                                   @"user_id":[UserInfos sharedUser].ID,
                                   @"product_id":model.ID ,
                                   @"type":@(1),
                                   @"state":@(1)
                                   };
            [weakSelf getRequestWithPath:API_My_add_like params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [weakSelf showAlert:successJson[@"message"]];

            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
    };
    cell.bookBlock = ^ (){
        if ([UserInfos getUser]) {
            if ([[UserInfos sharedUser].ID isEqualToString:_liverID]) {
                [self showAlert:@"您不能购买自己发布的商品"];
            }else{
                // 判断商品状态
                NSDictionary *dict = @{
                                       @"id":model.ID
                                       };
                [self getRequestWithPath:API_Order_status_new params:dict success:^(id successJson) {
                    DLog(@"%@", successJson);
                    if ([successJson[@"code"] integerValue] == 1) { // 可以买
                        __block BuyRuleAlertView *rulesAlert = [[BuyRuleAlertView alloc] init];
                        NSDictionary *dict2 = @{@"id":@(2)};
                        [self showHudInView:self.view hint:@"加载中.."];
                        [self getRequestWithPath:API_Help params:dict2 success:^(id successJson) {
                            rulesAlert.ruleContets = successJson[@"data"];
                            [rulesAlert show];
                            [self hideHud];
                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                        rulesAlert.sureBlock = ^(){
                            [self pushToDogBookVC:model];
                        };
                    }else if ([successJson[@"code"] integerValue] == 2){ // 已被订购
                        [self showAlert:@"狗狗已经被订购"];
                    }
                } error:^(NSError *error) {
                    DLog(@"%@", error);
                }];
            }
        }else {
            [self showAlert:@"请登录"];
        }
    
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    LiveListDogInfoModel *model = self.dataArr[indexPath.row];
    NSMutableArray *imgsArr = [NSMutableArray arrayWithArray:[model.dataPhoto componentsSeparatedByString:@"|"]];
    DogImageView *dogimageView = [[DogImageView alloc] init];
    CGFloat height = [dogimageView getCellHeightWithImages:imgsArr];
    return 290 + height;
}
- (void)pushToDogBookVC:(LiveListDogInfoModel *)model {
   
    DogBookViewController *dogBookVC = [[DogBookViewController alloc] init];
    dogBookVC.hidesBottomBarWhenPushed = YES;
    dogBookVC.model = model;
    dogBookVC.liverID = _liveid;
    dogBookVC.liverIcon = _liverIcon;
    dogBookVC.liverName = _liverName;
    dogBookVC.userId = _liverID;
    [self.navigationController pushViewController:dogBookVC animated:YES];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.text = @"没有更多商品";
    label.textColor = [UIColor colorWithHexString:@"#666666"];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 260;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
