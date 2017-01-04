//
//  HelpViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HelpViewController.h"
#import "NormalModel.h"
#import "SingleChatViewController.h"

@interface HelpViewController ()
@property (nonatomic, strong) UIButton *perfromBtn; /**< 未解决按钮 */
@property (nonatomic, strong) UIButton *serviceBtn; /**< 客服按钮 */
@property (nonatomic, strong) UITableView *tableView; /**< 表格 */
/** 文字 */
@property (strong,nonatomic) UILabel *label;
@property (copy, nonatomic) NSString *labelText; /**< label内容 */
@property (assign, nonatomic) CGFloat lableHeight; /**< label高度 */
/** 底部ScrollView */
@property (strong,nonatomic) UIScrollView *boomScrollView;
@end

@implementation HelpViewController
- (void)getRequestHelp {
    NSDictionary *dict = @{@"id":@(6)};
    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [NormalModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        NormalModel *model = arr[0];
        self.label.text = model.conent;
        self.labelText = self.label.text;
        CGSize testSize = [self.labelText boundingRectWithSize:CGSizeMake(self.view.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        // 接收文字高度
        self.lableHeight = testSize.height;
        
        NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
        paraStyle01.alignment = NSTextAlignmentJustified;  //对齐(两端对齐)
        paraStyle01.headIndent = 0.0f;//行首缩进
        //参数：（字体大小17号字乘以2，34f即首行空出两个字符）
        CGFloat emptylen = self.label.font.pointSize * 2;
        paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
        paraStyle01.tailIndent = 0.0f;//行尾缩进
        paraStyle01.lineSpacing = 2.0f;//行间距
        
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.label.text attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
        self.label.attributedText = attrText;
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self getRequestHelp];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self.view addSubview:self.perfromBtn];
    [self.view addSubview:self.serviceBtn];
    self.title = @"帮助";
    [self.view addSubview:self.boomScrollView];
    [self.boomScrollView addSubview:self.label];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.boomScrollView.top);
        make.left.equalTo(self.view.left).offset(10);
        make.centerX.equalTo(self.view.centerX);
        make.bottom.equalTo(self.boomScrollView.bottom);
    }];
    [self.perfromBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH / 2);
        make.height.equalTo(50);
    }];
    [self.serviceBtn makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.view);
        make.width.equalTo(SCREEN_WIDTH / 2);
        make.height.equalTo(50);
    }];
}
- (UIScrollView *)boomScrollView {
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)];
        _boomScrollView.showsVerticalScrollIndicator = NO;
        _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.lableHeight + 64);
        _boomScrollView.contentOffset = CGPointMake(0, 0);
        _boomScrollView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _boomScrollView.bounces  = NO;
    }
    return _boomScrollView;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 0;
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.font = [UIFont systemFontOfSize:14];
    }
    return _label;
}
- (UIButton *)perfromBtn {
    if (!_perfromBtn) {
        _perfromBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_perfromBtn setTitle:@"还没解决问题？" forState:(UIControlStateNormal)];
        _perfromBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _perfromBtn.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [_perfromBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [_perfromBtn addTarget:self action:@selector(ClickPerformBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _perfromBtn;
}
- (void)ClickPerformBtnAction {
    
}
- (UIButton *)serviceBtn {
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_serviceBtn setTitle:@"联系客服" forState:(UIControlStateNormal)];
        _serviceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _serviceBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        _serviceBtn.titleLabel.tintColor = [UIColor colorWithHexString:@"#ffffff"];
        [_serviceBtn addTarget:self action:@selector(ClickServiceBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _serviceBtn;
}
- (void)ClickServiceBtnAction {
    
    SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
    viewController.title = EaseTest_Chat1;
    viewController.chatID = EaseTest_Chat1;
    [self.navigationController pushViewController:viewController animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
