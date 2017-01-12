//
//  FavoriteDogDetailVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FavoriteDogDetailVc.h"
#import "SellerDogDetailView.h"
#import "SellerOrderDetailBottomView.h"
#import "ChageGoodsMessageVc.h"
#import "DogDetailModel.h"
#import "DeletePrommtView.h"

@interface FavoriteDogDetailVc ()

@property(nonatomic, strong) SellerDogDetailView *dogDetailView; /**< 狗狗详情View */
@property(nonatomic, strong) DogDetailModel *dogInfo; /**< 狗狗信息 */

@end

@implementation FavoriteDogDetailVc
- (void)getGoodsDetail {
    NSDictionary *dict = @{
                           @"id":@([_dogID intValue])
                           };
    DLog(@"%@", dict);
    [self getRequestWithPath:API_Product_limit params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            self.dogInfo = [DogDetailModel mj_objectWithKeyValues:successJson[@"data"]];
            NSArray *imsArr = [self.dogInfo.pathBig componentsSeparatedByString:@","];
            if (imsArr.count == 5) {//第一张可能是重复的，在后边干掉了
                self.dogDetailView.contentSize = CGSizeMake(0, 650);
            } else{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
