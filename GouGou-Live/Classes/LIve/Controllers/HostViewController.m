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
static NSInteger kMargin = 20;

static NSString * identifer = @"DogPictureCellID";
static NSString * reuseIdentifier = @"headerID";

@interface HostViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/** 正在直播的狗 */
@property (strong,nonatomic) UICollectionView *collection;
/** 顶部headerView */
@property (strong,nonatomic) DogTypesView *typesView;

/** 数据源 */
@property (strong,nonatomic) NSArray *dataArray;

@end

@implementation HostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:240 / 255.0 green:240 / 255.0 blue:240 / 255.0 alpha:1];
    
    [self initUI];
    
}

- (void)initUI {

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
        make.left.right.bottom.equalTo(weakself.view);
    }];
    
}
- (DogTypesView *)typesView {
    
    if (!_typesView) {
        _typesView = [[DogTypesView alloc] init];
        _typesView.easyBtnBlock = ^(){
            
            NSLog(@"以驯养");
        };
        
        _typesView.noDropFureBlock = ^(){
        
            NSLog(@"不掉毛");
        
        };
        
        _typesView.faithBtnBlock = ^(){
            
            NSLog(@"忠诚");
            
        };
        
        _typesView.lovelyBtnBlock = ^(){
            
            NSLog(@"可爱");
            
        };
        
        _typesView.moreImpressBtnBlock = ^(){
            
            NSLog(@"更多印象");
            
        };
    }
    return _typesView;
}

- (UICollectionView *)collection {

    if (!_collection) {
        
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        NSInteger colBoardaMargin = (SCREEN_WIDTH - 10 - 2 * 172)/2;

        //section的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(kMargin, colBoardaMargin, kMargin, colBoardaMargin);
        //设置item的大小
        flowLayout.itemSize = CGSizeMake(172, 120);
        flowLayout.minimumLineSpacing = 10;
        // 设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        // 设置头部区域大小
//        flowLayout.headerReferenceSize = CGSizeMake(0, 45);
        
        _collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
        
        _collection.delegate  = self;
        _collection.dataSource = self;
        _collection.clearsContextBeforeDrawing = YES;
        
        _collection.backgroundColor = [UIColor whiteColor];
        // 注册cell
        [_collection registerClass:[DogPictureCollectionViewCell class] forCellWithReuseIdentifier:identifer];
        
//        // 注册header
//        [_collection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier];
    }
    return _collection;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 4;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//
//    //判断header,footer
//    if (kind == UICollectionElementKindSectionHeader) {
//        
//        //从缓冲池里获取header
//        UICollectionReusableView * reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//        
//        reuseView.backgroundColor = [UIColor yellowColor];
//        
//        return reuseView;
//    }
//    
//    return nil;
//}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DogPictureCollectionViewCell * dogpictureCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    
    dogpictureCell.backgroundColor = [UIColor whiteColor];
    
    return dogpictureCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {


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
