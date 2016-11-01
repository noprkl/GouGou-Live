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

#import "LivingViewController.h"

#import "MoreImpressViewController.h"

static NSString * identifer = @"DogPictureCellID";
static NSString * reuseIdentifier = @"headerID";

@interface HostViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 正在直播的狗 */
@property (strong,nonatomic) UICollectionView *collection;
/** 顶部headerView */
@property (strong,nonatomic) DogTypesView *typesView;

/** 数据源 */
@property (strong,nonatomic) NSMutableArray *dataArray;

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
- (DogTypesView *)typesView {
    
    if (!_typesView) {
        
        _typesView = [[DogTypesView alloc] init];
        _typesView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        
        _typesView.easyBtnBlock = ^(){
            
            DLog(@"以驯养");
            
            return YES;
        };
        
        _typesView.noDropFureBlock = ^(){
        
            DLog(@"不掉毛");
            
        return YES;
        };
        
        _typesView.faithBtnBlock = ^(){
            
            DLog(@"忠诚");
            
            return YES;
        };
        
        _typesView.lovelyBtnBlock = ^(){
            
            DLog(@"可爱");
            
            
            return YES;
        };
        
        _typesView.moreImpressBtnBlock = ^(){
            
            MoreImpressViewController *moreVC = [[MoreImpressViewController alloc] init];
            [weakSelf.navigationController pushViewController:moreVC animated:YES];
        };
    }
    return _typesView;
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
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        
        _collection.delegate  = self;
        _collection.dataSource = self;
        _collection.showsHorizontalScrollIndicator = NO;
        
        _collection.backgroundColor = [UIColor colorWithHexString:@"e0e0e0"];
        
        // 注册cell
        [_collection registerClass:[DogPictureCollectionViewCell class] forCellWithReuseIdentifier:identifer];
        
    }
    return _collection;
}


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
    
        LivingViewController *livingVC = [[LivingViewController alloc] init];
        livingVC.title = [NSString stringWithFormat:@"直播-%ld", indexPath.row];
    livingVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:livingVC animated:YES];
        
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
