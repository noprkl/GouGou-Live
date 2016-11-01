//
//  SellerShowViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerShowViewController.h"
#import "SellerMessageView.h"

@interface SellerShowViewController ()

@property(nonatomic, strong) UIScrollView *baseScrollView; /**< 滚动view */

@property(nonatomic, strong) SellerMessageView *messageView; /**< 认证信息 */

@property(nonatomic, assign) CGFloat messageHeight; /**< message高度 */
@end

@implementation SellerShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
}
- (void)initUI {
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView addSubview:self.messageView];
    
    [self.messageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.right.equalTo(self.view);
        make.height.equalTo(self.messageHeight);
    }];
    
}
- (SellerMessageView *)messageView {
    if (!_messageView) {
        _messageView = [[SellerMessageView alloc] init];
        self.messageHeight = [_messageView getMessageHeight];
    }
    return _messageView;
}
- (UIScrollView *)baseScrollView {
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290)];
        _baseScrollView.contentSize = CGSizeMake(SCREEN_HEIGHT - 290, 0);
        _baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
       
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.showsVerticalScrollIndicator = NO;
    }
    return _baseScrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
