//
//  MyPageViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyPageViewController.h"
#import "MyPageHeaderView.h"
#import "MyPageDescView.h"
#import "PlayBackView.h"
#import "DogTypeCellModel.h"
#import "MyPagePictureView.h"
#import "PromptView.h"

#import "CertificateViewController.h"
#import "MerchantViewController.h"

#import "ManagePictureaViewController.h"

@interface MyPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */


@property(nonatomic, strong) NSArray *dogCardArr; /**< 临时数据 */

@property(nonatomic, strong) NSArray *picturesArr; /**< 临时数据 */

@end

static NSString *cellid = @"cellid";

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.hidesBottomBarWhenPushed = NO;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];
}

- (void)initUI {
    [self setNavBarItem];

    self.title = @"个人主页";
    [self.view addSubview:self.tableView];
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"头部"], @[@"简介"], @[@"实名认证", @"商家认证"],@[@"回放"],@[@"相册"]];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) { // 头部信息
                MyPageHeaderView *headerView = [[MyPageHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
                headerView.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:headerView];
            }
            break;
        case 1:
            if (indexPath.row == 0) { // 简介
                MyPageDescView *descView = [[MyPageDescView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 73))];
                descView.backgroundColor = [UIColor whiteColor];
                descView.editBlock = ^(){
                    PromptView *promit = [[PromptView alloc] init];

                    promit.title = @"简介编辑";
                    [promit show];
                };
                   [cell.contentView addSubview:descView];
            }
            break;
        case 2:
            if (indexPath.row == 0) { // 实名认证
                cell.textLabel.text = @"实名认证";
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
                
                UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 44))];
                label.backgroundColor = [UIColor whiteColor];
                label.text = @"实名";
                label.font = [UIFont systemFontOfSize:14];
                label.textColor = [UIColor colorWithHexString:@"#333333"];
                [cell.contentView addSubview:label];

                // 根据是否认证 创建认证按钮
                if (![UserInfos sharedUser].isreal) {

                    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
                    btn.frame = CGRectMake(0, 0, 75, 33);
                    [btn setTitle:@"去认证" forState:(UIControlStateNormal)];
                    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
                    btn.titleLabel.font = [UIFont systemFontOfSize:14];
                    btn.layer.cornerRadius = 10;
                    btn.layer.masksToBounds = YES;

                    [btn addTarget:self action:@selector(clickRealBtnAction) forControlEvents:(UIControlEventTouchDown)];

                    cell.accessoryView = btn;
                }
               
            }else if (indexPath.row == 1){ // 商家认证
                cell.textLabel.text = @"商家认证";
                cell.textLabel.font = [UIFont systemFontOfSize:16];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];

                UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(100, 0, 100, 44))];
                label.backgroundColor = [UIColor whiteColor];
                label.text = @"商家";
                label.font = [UIFont systemFontOfSize:14];
                label.textColor = [UIColor colorWithHexString:@"#333333"];
                [cell.contentView addSubview:label];
                
                // 根据是否认证 创建认证按钮
                if (![UserInfos sharedUser].ismerchant) {
                    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
                    btn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
                    btn.frame = CGRectMake(0, 0, 75, 33);
                    [btn setTitle:@"去认证" forState:(UIControlStateNormal)];
                    [btn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
                    btn.titleLabel.font = [UIFont systemFontOfSize:14];
                    btn.layer.cornerRadius = 10;
                    btn.layer.masksToBounds = YES;

                    [btn addTarget:self action:@selector(clickMerchantBtnAction) forControlEvents:(UIControlEventTouchDown)];
                    
                    cell.accessoryView = btn;

                }
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                CGFloat playbackViewHeight = 0;
                
                if (self.dogCardArr.count == 0) {
                    playbackViewHeight = 33 + 30;;
                }else{
                    playbackViewHeight = self.dogCardArr.count * 125 + 43;
                }
                
                PlayBackView *playbackView = [[PlayBackView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, playbackViewHeight) withPlayBackMessage:self.dogCardArr clickPlaybackBtn:^(UIControl *control){
                    
                    NSInteger btnTag = control.tag - 40;
                    if (self.dogCardArr.count == 0) {
                        
                    }else{
                        if (self.dogCardArr.count == 1) {
                            switch (btnTag) {
                                case 0:
                                    DLog(@"第一个回放");
                                    break;
                                default:
                                    break;
                            }
                        }else if (self.dogCardArr.count == 2){
                            switch (btnTag) {
                                case 0:
                                    DLog(@"第一个回放");
                                    break;
                                case 1:
                                    DLog(@"第二个回放");
                                    break;
                                default:
                                    break;
                            }
                        }
                    }
                }];
                playbackView.backgroundColor = [UIColor whiteColor];
//                [cell addSubview:playbackView];
                [cell.contentView addSubview:playbackView];
            }
            break;
        case 4:
            if (indexPath.row == 0) {
                CGFloat pictureHeight = 40;
               
                if (self.picturesArr.count != 0) {
                    pictureHeight += 180;
                }
                MyPagePictureView *picture = [[MyPagePictureView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, pictureHeight)];
                picture.pictures = self.picturesArr;
                picture.backgroundColor = [UIColor whiteColor];
                [cell.contentView addSubview:picture];
               
                __weak typeof(self) weakSelf = self;
                picture.manageBlock = ^(){
                    ManagePictureaViewController *manage = [[ManagePictureaViewController alloc] init];
                    manage.hidesBottomBarWhenPushed = YES;
                    [weakSelf.navigationController pushViewController:manage animated:YES];
                };
            }
            break;
        default:
            break;
    }
    return cell;
}
- (void)test1 {
    DLog(@"test");
}
- (NSArray *)dogCardArr {
    if (!_dogCardArr) {
        _dogCardArr = [NSArray array];
        
        DogTypeCellModel *cardModel1 = [[DogTypeCellModel alloc] initWithDogIcon:@"banner" focusCount:@"1000" dogDesc:@"纯种拉布拉多犬" anchorName:@"逗逼" showCount:@"5" onSailCount:@"8"];
        DogTypeCellModel *cardModel2 = [[DogTypeCellModel alloc] initWithDogIcon:@"banner" focusCount:@"1000" dogDesc:@"纯种拉布拉多犬" anchorName:@"逗逼" showCount:@"5" onSailCount:@"8"];
        
        _dogCardArr = @[cardModel1, cardModel2];
    }
    return _dogCardArr;
}
- (NSArray *)picturesArr {
    if (!_picturesArr) {
        _picturesArr = [NSArray array];
        _picturesArr = @[@"品种", @"品种"];
    }
    return _picturesArr;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 200;
            break;
        case 1:
            return 73;
            break;
        case 2:
            return 44;
            break;
        case 3:
        {
            CGFloat playbackViewHeight = 0;
            if (self.dogCardArr.count == 0) {
                playbackViewHeight = 33 + 30;;
            }else{
                playbackViewHeight = self.dogCardArr.count * 125 + 50;
            }
            return playbackViewHeight;
        }
            break;
        case 4:
        {
            CGFloat pictureHeight = 40;
            
            if (self.picturesArr.count != 0) {
                pictureHeight += 180;
            }
            return pictureHeight;
        }
            break;
        default:
            break;
    }
    return 0;
}
#pragma mark
#pragma mark - Action
- (void)clickRealBtnAction {
    CertificateViewController *certifi = [[CertificateViewController alloc] init];
    [self.navigationController pushViewController:certifi animated:YES];
}

- (void)clickMerchantBtnAction {
    MerchantViewController *merchant = [[MerchantViewController alloc] init];
    [self.navigationController pushViewController:merchant animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
