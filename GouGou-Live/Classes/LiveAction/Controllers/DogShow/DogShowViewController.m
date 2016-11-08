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

@interface DogShowViewController ()<UITableViewDataSource, UITableViewDelegate>

/** TableView */
@property (strong, nonatomic) UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray *dataArr;

/** 图片的个数 */
@property (assign, nonatomic) NSInteger images;

/** cell */
@property (strong, nonatomic) DogShowMessageCell *cell;

@property(nonatomic, strong) NSArray *shareAlertBtns; /**< 分享模型数组 */

@property(nonatomic, strong) ShareAlertView *shareAlert; /**< 分享view */


@end

static NSString *cellid = @"DogShowCellid";

@implementation DogShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationBarHidden = NO;
}
- (void)initUI {
    
    [self.view addSubview:self.tableView];
    
}
- (NSArray *)dataArr {

    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.decelerationRate = 0.9;
        [_tableView registerClass:[DogShowMessageCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArr.count;
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DogShowMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selected = UITableViewCellSelectionStyleNone;
    
    self.cell = cell;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    DogShowMessageCell *cell = (DogShowMessageCell *)self.cell;
    __weak typeof(self) weakSelf = self;
    
    cell.shareBlock = ^ (){
       
        ShareAlertView *shareAlert = [[ShareAlertView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 150, self.view.bounds.size.width, 150) alertModels:self.shareAlertBtns tapView:^(NSInteger btnTag) {
            
            NSInteger index = btnTag - 20;
            switch (index) {
                case 0:
                    DLog(@"朋友圈");
//                    [weakSelf performSelector:@selector(shareAlertDismiss)];
                    
                    break;
                case 1:
                    DLog(@"微信");
//                    [weakSelf performSelector:@selector(shareAlertDismiss)];
                    break;
                case 2:
                    DLog(@"QQ空间");
//                   [weakSelf performSelector:@selector(shareAlertDismiss)];
                    break;
                case 3:
                    DLog(@"新浪微博");
//                    [weakSelf performSelector:@selector(shareAlertDismiss)];
                    break;
                case 4:
                    DLog(@"QQ");
//                    [weakSelf performSelector:@selector(shareAlertDismiss)];
                    break;
                    
                default:
                    break;
            }
            

        }];
        self.shareAlert = shareAlert;
        shareAlert.backgroundColor = [UIColor whiteColor];
        [shareAlert show];

    };
    cell.likeBlock = ^ (){
       
        
    };
    cell.bookBlock = ^ (){
        
        BuyRuleAlertView *rulesAlert = [[BuyRuleAlertView alloc] init];
        [rulesAlert show];
        
        rulesAlert.sureBlock = ^(){
            [self pushToDogBookVC];
            
        };
    };
    return [cell getCellHeight];
}
- (void)pushToDogBookVC {
   
    DogBookViewController *dogBookVC = [[DogBookViewController alloc] init];
    dogBookVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:dogBookVC animated:YES];
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

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
