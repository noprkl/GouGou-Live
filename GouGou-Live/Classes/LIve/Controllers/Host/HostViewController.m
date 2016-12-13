//
//  HostViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HostViewController.h"
#import "DogPictureCollectionViewCell.h"
#import "DogTypesView.h"
#import "NoneNetWorkingView.h"

#import "LivingViewController.h"

#import "MoreImpressViewController.h"

#import "DogTypesViewController.h"

static NSString * identifer = @"DogPictureCellID";
static NSString * reuseIdentifier = @"headerID";

@interface HostViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 正在直播的狗 */
@property (strong,nonatomic) UICollectionView *collection;
/** 顶部headerView */
@property (strong,nonatomic) DogTypesView *typesView;

/** 数据源 */
@property (strong,nonatomic) NSMutableArray *dataArray;

@property(nonatomic, strong) NoneNetWorkingView *noneNetView; /**< 无网 */

@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
}

- (void)initUI {

    self.view.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];

    self.edgesForExtendedLayout = 64;
    [self addCollectionview];
    
}

- (void)addCollectionview {
    
    [self.view addSubview:self.typesView];
    [self.view addSubview:self.collection];

    __weak typeof(self) weakself = self;
    
    [_typesView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.view.top);
        make.left.right.equalTo(weakself.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 45));
    }];
    
    [_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.typesView.bottom).offset(10);
        make.left.right.equalTo(weakself.view);
        make.bottom.equalTo(weakself.view.bottom).offset(-64);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (NoneNetWorkingView *)noneNetView {
    if (!_noneNetView) {
        _noneNetView = [[NoneNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneNetView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];    }
    return _noneNetView;
}
- (DogTypesView *)typesView {
    
    if (!_typesView) {
        
        _typesView = [[DogTypesView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _typesView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        
        _typesView.btnBlock = ^(UIButton *btn){

            NSInteger tag = btn.tag - 30;
            switch (tag) {
                case 0:
                    [weakSelf pushDogTypeVC:btn.titleLabel.text];
                    break;
                case 1:
                    [weakSelf pushDogTypeVC:btn.titleLabel.text];
                    break;
                case 2:
                    [weakSelf pushDogTypeVC:btn.titleLabel.text];
                    break;
                case 3:
                    [weakSelf pushDogTypeVC:btn.titleLabel.text];
                    break;
                case 4:
                    {
                        MoreImpressViewController *moreVC = [[MoreImpressViewController alloc] init];
                        
                        [weakSelf.navigationController pushViewController:moreVC animated:YES];
                
                    }
                    break;
                default:
                    break;
            }
        
        };

    }
    return _typesView;
}

- (void)pushDogTypeVC:(NSString *)title {
    
    DogTypesViewController * typeVC = [[DogTypesViewController alloc] init];
    
    typeVC.title = title;
    typeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:typeVC animated:YES];
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UICollectionView *)collection {

    if (!_collection) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];

        //设置item的大小
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH / 2, 130);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        // 设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
//        // 设置头部区域大小
//        flowLayout.headerReferenceSize = CGSizeMake(0, 45);
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 54, SCREEN_WIDTH, 500) collectionViewLayout:flowLayout];
        
        _collection.delegate  = self;
        _collection.dataSource = self;
        _collection.showsHorizontalScrollIndicator = NO;
        
        _collection.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        
        // 注册cell
        [_collection registerClass:[DogPictureCollectionViewCell class] forCellWithReuseIdentifier:identifer];
        
    }
    return _collection;
}

#pragma mark
#pragma mark - collection代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

//    return self.dataArray.count;
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DogPictureCollectionViewCell * dogpictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    dogpictureCell.backgroundColor = [UIColor whiteColor];
    
    return dogpictureCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    if (_typeBlock) {
        
        _typeBlock(indexPath.row);
    
    }
//        LivingViewController *livingVC = [[LivingViewController alloc] init];
//        livingVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:livingVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
