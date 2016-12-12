//
//  SellerAddImpressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAddImpressViewController.h"
#import "AddDogImpressionView.h"

@interface SellerAddImpressViewController ()<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入 */

@property(nonatomic, strong) UICollectionView *collectionView; /**< 表格 */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */


@property(nonatomic, strong) AddDogImpressionView *addImpression; /**< 添加印象 */

@property(nonatomic, strong) NSMutableArray *selectImpression; /**< 选中的颜色 */

@property(nonatomic, strong) NSMutableArray *cells; /**< 选择的cell */

@property(nonatomic, strong) UITableViewCell *cell; /**< 最后的cell */

@end

static NSString *cellid = @"SellerAddImpresscell";

@implementation SellerAddImpressViewController
// 请求印象
- (void)getRequestImpression {
    [self getRequestWithPath:API_Impression params:nil success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationItem setTitleView:self.titleInputView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.addImpression];
    self.addImpression.hidden = YES;
    [self getRequestImpression];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
    
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSureBtnAction)];
}
#pragma mark
#pragma mark - Action
- (void)clickSureBtnAction {
    
    
    self.titleInputView = nil;
    [self.titleInputView removeFromSuperview];
    if (self.selectImpression.count == 0) {
        [self showAlert:@"请选择印象"];
    }else{
        NSDictionary *dict = @{
                               @"Impress":self.selectImpression
                               };
        NSNotification *notification = [NSNotification notificationWithName:@"DogImpress" object:nil userInfo:dict];
        
        [[NSNotificationCenter defaultCenter] postNotification:notification];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)editSearchAction:(UITextField *)textField {
    if (textField.text.length == 0) {
        self.collectionView.hidden = NO;
        self.addImpression.hidden = YES;
    }else{
        NSDictionary *dict = @{
                               @"name":self.titleInputView.text
                               };
        [self postRequestWithPath:API_Search_impression params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            if ([successJson[@"data"] count] == 0) {
                self.addImpression.dogImpress = textField.text;
                self.collectionView.hidden = YES;
                self.addImpression.hidden = NO;
            }else{
                self.collectionView.hidden = NO;
                self.addImpression.hidden = YES;
                self.dataArr = [DogCategoryModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                [self.collectionView reloadData];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
    
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}
- (NSMutableArray *)selectImpression {
    if (!_selectImpression) {
        _selectImpression = [NSMutableArray array];
    }
    return _selectImpression;
}
- (AddDogImpressionView *)addImpression {
    if (!_addImpression) {
        _addImpression = [[AddDogImpressionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];

        __weak typeof(self) weakSelf = self;
        _addImpression.addBlock = ^(NSString *text){
            // 添加印象
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                   @"name":text
                                   };
            [weakSelf postRequestWithPath:API_Add_Impression params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                [weakSelf showAlert:successJson[@"message"]];
                if ([successJson[@"message"] isEqualToString:@"添加成功"]) {
                    weakSelf.collectionView.hidden = NO;
                    weakSelf.addImpression.hidden = YES;
                    [weakSelf getRequestImpression];
                }
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
        };
    }
    return _addImpression;

}
- (UITextField *)titleInputView {
    if (!_titleInputView) {
        _titleInputView = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        _titleInputView.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"#输入您对狗狗的印象，最多不超过10个字#" attributes:@{
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
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];

        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellid];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    DogCategoryModel *model = self.dataArr[indexPath.row];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH - 40) / 2, 33)];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.text = [NSString stringWithFormat:@"#%@#", model.name];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    [self.cells addObject:label];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){SCREEN_WIDTH / 2,44};
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DogCategoryModel *model = self.dataArr[indexPath.row];
    UILabel *label = self.cells[indexPath.row];

    if ([self.selectImpression containsObject:model]) {
        [self.selectImpression removeObject:model];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

    }else{
        [self.selectImpression addObject:model];
        label.textColor = [UIColor colorWithHexString:@"#ffffff"];
        label.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];

    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
