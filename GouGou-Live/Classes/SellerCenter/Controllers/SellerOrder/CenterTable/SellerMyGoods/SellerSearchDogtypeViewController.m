//
//  SellerSearchDogtypeViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerSearchDogtypeViewController.h"
#import "SellerNoInputTableView.h"
#import "SellerDoInputTableView.h"
#import "SellerNoneDogTypeView.h" 

@interface SellerSearchDogtypeViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) SellerDoInputTableView *doInputView; /**< 搜索了 */

@property(nonatomic, strong) SellerNoInputTableView *noinputView; /**< 没搜索 */

@property(nonatomic, strong) SellerNoneDogTypeView *noneDoyType; /**< 没有狗狗品种 */

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入框 */

@end

@implementation SellerSearchDogtypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索icon-拷贝"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSearchBtnAction)];
    
    [self.navigationItem setTitleView:self.titleInputView];
    [self.view addSubview:self.noinputView];

}
- (void)clickSearchBtnAction {
    [self.noinputView removeFromSuperview];
//    [self.view addSubview:self.doInputView];
    [self.view addSubview:self.noneDoyType];
}
- (void)editSearchAction:(UITextField *)textField {
    
}
#pragma mark
#pragma mark - 懒加载
- (UITextField *)titleInputView {
    if (!_titleInputView) {
        _titleInputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        _titleInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入您的狗狗品种" attributes:@{
                                                                                                                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                                                                                                                 NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _titleInputView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _titleInputView.layer.cornerRadius = 5;
        _titleInputView.layer.masksToBounds = YES;
        _titleInputView.delegate = self;
        _titleInputView.font = [UIFont systemFontOfSize:14];
        [_titleInputView addTarget:self action:@selector(editSearchAction:) forControlEvents:(UIControlEventAllEvents)];
    }
    return _titleInputView;
}
- (SellerDoInputTableView *)doInputView {
    if (!_doInputView) {
        _doInputView = [[SellerDoInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        _doInputView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _doInputView;
}
- (SellerNoInputTableView *)noinputView {
    if (!_noinputView) {
        _noinputView = [[SellerNoInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        _noinputView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

    }
    return _noinputView;
}
- (SellerNoneDogTypeView *)noneDoyType {
    if (!_noneDoyType) {
        _noneDoyType = [[SellerNoneDogTypeView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64))];
        _noneDoyType.addBlock = ^(NSString *dogType){
            DLog(@"%@", dogType);
        };
    }
    return _noneDoyType;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
