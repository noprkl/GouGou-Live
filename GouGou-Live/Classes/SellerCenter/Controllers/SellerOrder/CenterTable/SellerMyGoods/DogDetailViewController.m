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
@interface DogDetailViewController ()

@property(nonatomic, strong) SellerDogDetailView *dogDetailView; /**< 狗狗详情View */

@property(nonatomic, strong) SellerOrderDetailBottomView *bottomView; /**< 底部按钮 */

@end

@implementation DogDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI {
    self.title = @"狗狗详情";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.dogDetailView];
    [self.view addSubview:self.bottomView];
//    CGFloat height =[self.dogDetailView getViewHeight] + 10;
//    DLog(@"%lf", height);
//    _dogDetailView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
//    DLog(@"%@", self.dogDetailView);

    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
}
#pragma mark
#pragma mark - 懒加载
- (SellerDogDetailView *)dogDetailView {
    if (!_dogDetailView) {
        _dogDetailView = [[SellerDogDetailView alloc] init];
        
    }
    return _dogDetailView;
}
- (SellerOrderDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerOrderDetailBottomView alloc] init];
        _bottomView.btnTitles = @[@"删除", @"编辑"];
        _bottomView.clickBlock = ^(NSString *btnTitle){
            if ([btnTitle isEqualToString:@"删除"]) {
                DLog(@"编辑");
            }else if ([btnTitle isEqualToString:@"编辑"]) {
                DLog(@"删除");
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
