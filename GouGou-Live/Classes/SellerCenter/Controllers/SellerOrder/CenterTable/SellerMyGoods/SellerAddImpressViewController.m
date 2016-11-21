//
//  SellerAddImpressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerAddImpressViewController.h"

@interface SellerAddImpressViewController ()<UITextFieldDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UITextField *titleInputView; /**< 头部输入 */

@property(nonatomic, strong) UICollectionView *collectionView; /**< 表格 */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@end

static NSString *cellid = @"SellerAddImpresscell";

@implementation SellerAddImpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    [self initUI];
}
- (void)initUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:(UIBarButtonItemStylePlain) target:self action:@selector(clickSureBtnAction)];
    
    [self.navigationItem setTitleView:self.titleInputView];
    [self.view addSubview:self.collectionView];
}
#pragma mark
#pragma mark - Action
- (void)clickSureBtnAction {
    self.titleInputView = nil;
    [self.titleInputView removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)editSearchAction:(UITextField *)textField {
    
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
        _dataArr = @[@"#易驯养#", @"#聪明#", @"#不掉毛#", @"#可爱#", @"#坑骨头#", @"#没啥问题#"];
    }
    return _dataArr;
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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (SCREEN_WIDTH - 40) / 2, 33)];
    label.layer.cornerRadius = 5;
    label.layer.masksToBounds = YES;
    label.text = self.dataArr[indexPath.row];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:16];
    
    label.backgroundColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){SCREEN_WIDTH / 2,44};
}


//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 5, 5, 5);
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
