//
//  DogDetailViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogDetailViewController.h"
#import "SellerDogDetailView.h"
#import "SellerOrderDetailBottomView.h"
#import "ChageGoodsMessageVc.h"
#import "DogDetailModel.h"
#import "DeletePrommtView.h"

@interface DogDetailViewController ()

@property(nonatomic, strong) SellerDogDetailView *dogDetailView; /**< 狗狗详情View */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */

@property(nonatomic, strong) DogDetailModel *dogInfo; /**< 狗狗信息 */

@end

@implementation DogDetailViewController
- (void)getGoodsDetail {
    NSDictionary *dict = @{
                           @"id":@([_model.ID integerValue])
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Product_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            self.dogInfo = [DogDetailModel mj_objectWithKeyValues:successJson[@"data"]];
            NSArray *imsArr = [self.dogInfo.pathBig componentsSeparatedByString:@","];
            if (imsArr.count == 4) {
                self.dogDetailView.contentSize = CGSizeMake(0, 650);
            }else{
                self.dogDetailView.contentSize = CGSizeMake(0, 0);
            }
            [self.view addSubview:self.dogDetailView];
            self.dogDetailView.dogInfo = self.dogInfo;

            DLog(@"%@", self.dogInfo);
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
// 删除
- (void)deleGoods {
    DeletePrommtView *deleView = [[DeletePrommtView alloc] init];
    deleView.message = @"确认删除此狗狗吗？";
    
    [deleView show];
    deleView.sureBlock = ^(UIButton *btn){
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                               @"id":@([_model.ID integerValue])
                               };
        [self getRequestWithPath:API_Del_Commodity params:dict success:^(id successJson) {
            //        DLog(@"%@", successJson);
            [self showAlert:successJson[@"message"]];
            // 如果成功跳回去
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    };
}
- (void)editGoodsMessage {
    
}
- (void)setModel:(SellerMyGoodsModel *)model {
    _model = model;
}
#pragma mark
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self getGoodsDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI {
    self.title = @"狗狗详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.bottomView];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];

}
#pragma mark
#pragma mark - 懒加载
- (SellerDogDetailView *)dogDetailView {
    if (!_dogDetailView) {
        _dogDetailView = [[SellerDogDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50)];
        _dogDetailView.backgroundColor = [UIColor whiteColor];
        _dogDetailView.contentSize = CGSizeMake(0, 1000);
        _dogDetailView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _dogDetailView.showsVerticalScrollIndicator = NO;
    }
    return _dogDetailView;
}
- (SellerOrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerOrderDetailBottomView alloc] init];
        _bottomView.btnTitles = @[@"删除", @"编辑"];
        __weak typeof(self) weakSelf = self;
        _bottomView.clickBlock = ^(NSString *btnTitle){
            if ([btnTitle isEqualToString:@"删除"]) {
                [weakSelf deleGoods];
                
            }else if ([btnTitle isEqualToString:@"编辑"]) {
                ChageGoodsMessageVc *changeGoodsVc = [[ChageGoodsMessageVc alloc] init];
                changeGoodsVc.model = weakSelf.dogInfo;
                [weakSelf.navigationController pushViewController:changeGoodsVc animated:YES];
            }
        };
    }
    return _bottomView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
