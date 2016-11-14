//
//  SellerCenterViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerCenterViewController.h"
#import "TopButonView.h"

@interface SellerCenterViewController ()

@property(nonatomic, strong) TopButonView *topView; /**< 顶部按钮 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

@implementation SellerCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    [self setNavBarItem];
    [self.view addSubview:self.topView];
}
#pragma mark
#pragma mark - 懒加载
- (TopButonView *)topView {
    
    if (!_topView) {
        _topView  = [[TopButonView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 88)];
        
        _topView.unSelectedArray = @[@"待付款",@"待发货",@"收货",@"待评价",@"维权"];
        _topView.titleArray = @[@"待支付",@"代发货",@"待收货",@"待评价",@"维权"];
        _topView.selecedtArray = @[@"待付款（点击）",@"待发货（点击）",@"收货（点击）",@"待评价（点击）",@"维权（点击）"];
        
//        __weak typeof(self) weakself = self;
        
        _topView.difStateBlock = ^(UIButton *btn) {
            
            NSUInteger tag = btn.tag;
            
            DLog(@"%ld", tag);
            
            NSInteger flag = tag - 80;
            
            switch (flag) {
                case 0:
                    DLog(@"%ld", flag);
                    break;
                case 1:
                    DLog(@"%ld", flag);
                    break;
                case 2:
                    DLog(@"%ld", flag);
                    break;
                case 3:
                    DLog(@"%ld", flag);
                    break;
                case 4:
                    DLog(@"%ld", flag);
                    break;
                default:
                    break;
            }
        };
    }
    return _topView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
