//
//  PersonalPicturesVc.m
//  GouGou-Live
//
//  Created by 李祥起 on 2017/2/7.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "PersonalPicturesVc.h"
#import "MyPictureListModel.h"
#import "SDPhotoBrowser.h"
#import "PicturesCell.h"

@interface PersonalPicturesVc ()<UICollectionViewDelegate, UICollectionViewDataSource, SDPhotoBrowserDelegate>
@property(nonatomic, strong) UICollectionView *collectionView; /**< 表格 */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */
@end
static NSString *cellid = @"PicturesCell";

@implementation PersonalPicturesVc
- (void)getRequestAlbumList {
    NSDictionary *dict = @{
                           @"user_id":self.userId,
                           @"id":_model.ID
                           };
    [self getRequestWithPath:API_Album_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.dataArr removeAllObjects];
        if (successJson[@"data"]) {
            self.dataArr = [MyPictureListModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            [self.collectionView reloadData];
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
- (void)initUI {
    [self setNavBarItem];
    [self.view addSubview:self.collectionView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestAlbumList];
}
- (void)setModel:(MyAlbumsModel *)model {
    _model = model;
    self.title = model.albumName;
}
#pragma mark
#pragma mark - collectionView
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        CGFloat W = (SCREEN_WIDTH - 40) / 3;
        flowlayout.itemSize = CGSizeMake(W, W);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"PicturesCell" bundle:nil] forCellWithReuseIdentifier:cellid];
    }
    return _collectionView;
}
#pragma mark
#pragma mark - 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicturesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    MyPictureListModel *model = self.dataArr[indexPath.row];
    cell.model = model;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = collectionView;
    
    browser.imageCount = self.dataArr.count;
    
    browser.currentImageIndex = indexPath.row;
    
    browser.delegate = self;
    
    [browser show]; // 展示图片浏览器
}
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    MyPictureListModel *model = self.dataArr[index];
    NSString *urlStr = [IMAGE_HOST stringByAppendingString:model.pathBig];
    return [NSURL URLWithString:urlStr];
}
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
//
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
