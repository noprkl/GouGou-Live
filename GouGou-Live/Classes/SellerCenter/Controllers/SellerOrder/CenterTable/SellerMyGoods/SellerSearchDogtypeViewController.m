//
//  SellerSearchDogtypeViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define kHistory @"DOGTYPEHISSTORY"

#import "SellerSearchDogtypeViewController.h"
#import "SellerNoInputTableView.h"
#import "SellerDoInputTableView.h"
#import "SellerNoneDogTypeView.h" 

@interface SellerSearchDogtypeViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) SellerDoInputTableView *doInputView; /**< 搜索了 */

@property(nonatomic, strong) SellerNoInputTableView *noinputView; /**< 没搜索 */

@property(nonatomic, strong) SellerNoneDogTypeView *noneDoyType; /**< 没有狗狗品种 */

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入框 */

@property(nonatomic, strong) NSArray *hotArr; /**< 热门搜索 */

@end

@implementation SellerSearchDogtypeViewController

- (void)getRequestDogType {
    NSDictionary *dict = @{
                           @"type":@(3)
                           };
    [self getRequestWithPath:API_Category params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if (successJson) {
            self.hotArr = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            self.noinputView.hotArr = self.hotArr;
            [self.noinputView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self setNavBarItem];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.noinputView];
    [self.view addSubview:self.doInputView];
    [self.view addSubview:self.noneDoyType];
    self.noinputView.hidden = NO;
    self.doInputView.hidden = YES;
    self.noneDoyType.hidden = YES;
    [self getRequestDogType];
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"搜索icon-拷贝"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSearchBtnAction)];
    
    [self.navigationItem setTitleView:self.titleInputView];
    
}
- (void)clickSearchBtnAction {
    if (self.titleInputView.text.length != 0) {
        [self searchDogTypeWithType:self.titleInputView.text];
    }
}
- (void)editSearchAction:(UITextField *)textField {
    if (textField.text.length == 0) {
        // 刷新
        self.noinputView.hidden = NO;
        [self.noinputView reloadData];
        self.doInputView.hidden = YES;
        self.noneDoyType.hidden = YES;
    }
}
- (void)searchDogTypeWithType:(NSString *)type {
    NSDictionary *dict = @{
                           @"name":type,
                           @"type":@(3)
                           };
    [self postRequestWithPath:API_Search_varieties params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"data"] count] == 0) {
            self.noinputView.hidden = YES;
            self.doInputView.hidden = YES;
            self.noneDoyType.hidden = NO;
            self.noneDoyType.dogType = self.titleInputView.text;
        }else{
            self.noinputView.hidden = YES;
            self.doInputView.hidden = NO;
            self.noneDoyType.hidden = YES;
            self.doInputView.dataPlist = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            [self.doInputView reloadData];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    [self.titleInputView resignFirstResponder];
    
    // 本地
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:kHistory]];
    // NSArray --> NSMutableArray
    NSMutableArray *historyArr = [myArray mutableCopy];
    
    // 可变数组存放一样的数据
    NSMutableArray *searTXT = [NSMutableArray array];
    //        searTXT = [myArray mutableCopy];
    
    if (historyArr.count > 0) {
        //搜索本地内容
        for (NSString * str in historyArr) {
            if ([type isEqualToString:str]) {
                [searTXT addObject:type];
            }
        }
    }
    // 搜索一样的数据 删除
    [historyArr removeObjectsInArray:searTXT];
    // 添加数据
    [historyArr insertObject:type atIndex:0];
    // 存放限制 10个
    if(searTXT.count > 10)
        {
        [searTXT removeLastObject];
        }
    //将上述数据全部存储到NSUserDefaults中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:historyArr forKey:kHistory];
}
#pragma mark
#pragma mark - 懒加载
- (UITextField *)titleInputView {
    if (!_titleInputView) {
        _titleInputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        _titleInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入您的狗狗品种" attributes:@{
                                                                                                                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"],                                                                                                      NSFontAttributeName:[UIFont systemFontOfSize:14]}];
        _titleInputView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _titleInputView.layer.cornerRadius = 5;
        _titleInputView.layer.masksToBounds = YES;
        _titleInputView.delegate = self;
        _titleInputView.font = [UIFont systemFontOfSize:14];
        [_titleInputView addTarget:self action:@selector(editSearchAction:) forControlEvents:(UIControlEventAllEvents)];
    }
    return _titleInputView;
}
// 已经搜索了
- (SellerDoInputTableView *)doInputView {
    if (!_doInputView) {
        _doInputView = [[SellerDoInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        _doInputView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        __weak typeof(self) weakSelf = self;

        _doInputView.sureAddBlock = ^(DogCategoryModel *model){
            NSDictionary *dict = @{
                                   @"Type":model
                                   };
            DLog(@"%@", model);
            //通过通知中心发送通知
            NSNotification *notification = [NSNotification notificationWithName:@"DogType" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
    }
    return _doInputView;
}
// 未搜索
- (SellerNoInputTableView *)noinputView {
    if (!_noinputView) {
        _noinputView = [[SellerNoInputTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        _noinputView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        __weak typeof(self) weakSelf = self;
        _noinputView.typeBlock = ^(DogCategoryModel *model){
            NSDictionary *dict = @{
                                   @"Type":model
                                   };
            NSNotification *notification = [NSNotification notificationWithName:@"DogType" object:nil userInfo:dict];
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        };
        _noinputView.typeCellBlock = ^(NSString *type){
            weakSelf.titleInputView.text = type;
            [weakSelf searchDogTypeWithType:type];
        };
    }
    return _noinputView;
}
// 没搜索到品种，添加
- (SellerNoneDogTypeView *)noneDoyType {
    if (!_noneDoyType) {
        _noneDoyType = [[SellerNoneDogTypeView alloc] initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64))];
        
        // 添加品种
        __weak typeof(self) weakSelf = self;
        _noneDoyType.addBlock = ^(NSString *dogType){
           
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"name":dogType
                                   };
            [weakSelf postRequestWithPath:API_Add_varieties params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [weakSelf showAlert:successJson[@"message"]];
                weakSelf.noneDoyType.hidden = YES;
                [weakSelf clickSearchBtnAction];
                
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
    }
    return _noneDoyType;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
