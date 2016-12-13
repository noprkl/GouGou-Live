//
//  SearchFocusViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SearchFocusViewController.h"
#import "MyFocusTableCell.h"
#import "FocusAndFansModel.h"

@interface SearchFocusViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入框 */

@end

static NSString *cellid = @"MyFocusCell";

@implementation SearchFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索icon-拷贝"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSearchBottonAction)];
    
    [self.navigationItem setTitleView:self.titleInputView];
    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
}
// 只有点击搜索才能点击搜索
- (void)clickSearchBottonAction {
    [self.titleInputView resignFirstResponder];
    NSDictionary *dict = @{
                           @"user_nick_name":self.titleInputView.text
                           };
    [self postRequestWithPath:API_Search_nick params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            //            DLog(@"%@", successJson);
            self.dataArr = [FocusAndFansModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
// 每改变一个字搜一次
- (void)editSearchAction:(UITextField *)textField {
    
}
- (UITextField *)titleInputView {
    if (!_titleInputView) {
        _titleInputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        _titleInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入用户昵称" attributes:@{
                                                                                                                    NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],
                                                                                                                    NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _titleInputView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _titleInputView.layer.cornerRadius = 5;
        _titleInputView.layer.masksToBounds = YES;
        _titleInputView.delegate = self;
        _titleInputView.font = [UIFont systemFontOfSize:14];
        [_titleInputView addTarget:self action:@selector(editSearchAction:) forControlEvents:(UIControlEventEditingChanged)];
    }
    return _titleInputView;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"MyFocusTableCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.dataArr.count;
//    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFocusTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    FocusAndFansModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    cell.selectBlock = ^(BOOL isSelect){
        if (isSelect) {
            
            NSDictionary *dict = @{
                                   @"user_id":@(11),
                                   @"id":@(model.userFanId),
                                   @"type":@(0)
                                   };
            [self getRequestWithPath:API_Add_fan params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
            
        }else {
            
            NSDictionary *dict = @{
                                   @"user_id":@(11),
                                   @"id":@(model.userFanId),
                                   @"type":@(1)
                                   };
            [self getRequestWithPath:API_Add_fan params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [self showAlert:successJson[@"message"]];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        }
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 75;
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
