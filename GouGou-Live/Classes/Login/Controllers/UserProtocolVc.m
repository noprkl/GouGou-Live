//
//  UserProtocolVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UserProtocolVc.h"
#import "NormalModel.h"

@interface UserProtocolVc ()
@property (nonatomic, strong) UILabel *label; /**< 文字 */
@property (nonatomic, strong) UIScrollView *boomScrollView; /**< 文字 */
@property (copy, nonatomic) NSString *labelText; /**< label内容 */
@property (assign, nonatomic) CGFloat lableHeight; /**< label高度 */
@end

@implementation UserProtocolVc

- (void)getRequestProtocol {
    NSDictionary *dict = @{@"id":@(1)};
    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [NormalModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        NormalModel *model = arr[0];
        self.label.text = model.conent;
        // 接收文字内容
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
    [self getRequestProtocol];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    [self setNavBarItem];
    [self.view addSubview:self.boomScrollView];
    [self.boomScrollView addSubview:self.label];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.boomScrollView.top);
        make.left.equalTo(self.view.left).offset(20);
        make.centerX.equalTo(self.boomScrollView.centerX);
        make.bottom.equalTo(self.boomScrollView.bottom);
    }];
}
- (UIScrollView *)boomScrollView {
    if (!_boomScrollView) {
        _boomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _boomScrollView.showsVerticalScrollIndicator = NO;
        _boomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.lableHeight + 64);
        _boomScrollView.contentOffset = CGPointMake(0, 0);
        _boomScrollView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _boomScrollView.bounces = NO;
    }
    return _boomScrollView;
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"用户协议";
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.numberOfLines = 0;
    }
    return _label;
}

@end
