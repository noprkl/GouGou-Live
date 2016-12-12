//
//  PicturesViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

// 列数
#define kCols 3

#import "PicturesViewController.h"
#import "PicturesCell.h"
#import "SellerGoodsBottomView.h"
#import "SellerGoodsBarBtnView.h"
#import "SellerDeleDDetailView.h"
#import "MyAlbumsModel.h"
#import "NSString+CertificateImage.h"
#import "MyPictureListModel.h"

@interface PicturesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic, strong) UICollectionView *collectionView; /**< 表格 */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) NSMutableArray *selectData; /**< 选中数据 */

@property(nonatomic, assign) BOOL isSelect; /**< 是否选中 */
@property(nonatomic, assign) BOOL isHid; /**< 是否隐藏 */

@property(nonatomic, strong) SellerGoodsBottomView *bottomView; /**< 选中按钮 */

@property(nonatomic, strong) SellerGoodsBarBtnView *barBtnView; /**< 上边按钮 */

@property(nonatomic, strong) UIButton *allBtn; /**< 全选按钮 */

@end
static NSString *cellid = @"PicturesCell";

@implementation PicturesViewController
- (void)getRequestAlbumList {
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"id":_model.ID
                           };
    [self getRequestWithPath:API_Album_list params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.dataArr removeAllObjects];
        self.dataArr = [MyPictureListModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    
}
- (void)deletePictures {
    
    for (NSInteger i = 0; i < self.selectData.count; i ++) {
        MyPictureListModel *model = self.selectData[i];
        [self.selectData replaceObjectAtIndex:i withObject:model.ID];
    }
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"id":[self.selectData componentsJoinedByString:@","]
                           };
    [self getRequestWithPath:API_Album_del params:dict success:^(id successJson) {
//        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        [self getRequestAlbumList];
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
        
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.barBtnView];
    self.navigationItem.rightBarButtonItem = item;
    
    [self.view addSubview:self.bottomView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    _isSelect = NO;
    _isHid = YES;
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.bottomView];
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

- (NSMutableArray *)selectData {
    if (!_selectData) {
        _selectData = [NSMutableArray array];
    }
    return _selectData;
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
// 编辑
- (SellerGoodsBarBtnView *)barBtnView {
    if (!_barBtnView) {
        _barBtnView = [[SellerGoodsBarBtnView alloc] init];
        _barBtnView.bounds = CGRectMake(0, 0, 100, 44);
        __weak typeof(self) weakSelf = self;
        _barBtnView.editBlock = ^(BOOL flag){
#pragma mark - 编辑
            // 清除所有选中数据
            [weakSelf.selectData removeAllObjects];
            
            // 设置按钮显示
            _isHid = !flag;
            [weakSelf.collectionView reloadData];
            
            // 编辑时不允许跳转 底部按钮不隐藏
            weakSelf.bottomView.hidden = !flag;
            // 当底部按钮隐藏时 全选按钮为非选中状态
            if (weakSelf.bottomView.hidden) {
                weakSelf.allBtn.selected = NO;
            }
        };
        _barBtnView.addBlock = ^(){
            // 添加相片
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            
            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    
                        NSString *base64 = [NSString imageBase64WithDataURL:photos[0]];
                        NSDictionary *dict = @{
                                               @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                               @"img":base64
                                               };
                    
                    
                    [weakSelf postRequestWithPath:API_UploadImg params:dict success:^(id successJson) {
                        if ([successJson[@"message"] isEqualToString:@"上传成功"]) {
                            CGSize size = CGSizeMake(200, 300);
                            // 请求
                            NSDictionary *dict2 = @{
                                                    @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                                                    @"id":weakSelf.model.ID,
                                                    @"path_small":weakSelf.model.pathSmall,
                                                    @"path_big":successJson[@"data"],
                                                    @"photo_space":NSStringFromCGSize(size)
                                                    };
                            DLog(@"%@", dict2);
                            [weakSelf getRequestWithPath:API_Add_albums params:dict2 success:^(id successJson) {
                                [weakSelf showAlert:successJson[@"message"]];
                                [weakSelf getRequestAlbumList];
                                DLog(@"%@", successJson);
                            } error:^(NSError *error) {
                                DLog(@"%@", error);
                            }];
                        }

                        } error:^(NSError *error) {
                            DLog(@"%@", error);
                        }];
                    
                }else{
                    DLog(@"出错了");
                }
            }];

        };
    }
    return _barBtnView;
}
// 底部按钮
- (SellerGoodsBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[SellerGoodsBottomView alloc] init];
        _bottomView.hidden = YES;
        _bottomView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        _bottomView.allSelectBlock = ^(UIButton *btn){
            btn.selected = !btn.selected;
            // 全选按钮选中
            _isSelect = btn.selected;
            
            // 如果全选 把数据全添加进去
            if (btn.selected) {
                [weakSelf.selectData addObjectsFromArray:weakSelf.dataArr];
                
            }else{ // 否则 把数据全清除
                [weakSelf.selectData removeAllObjects];
            }
            
            [weakSelf.collectionView reloadData];
            weakSelf.allBtn = btn;
        };
        
        // 删除选中数据
        _bottomView.deleteBlock = ^(){
            
            __block SellerDeleDDetailView *prommit = [[SellerDeleDDetailView alloc] init];
            NSInteger count = 0;
            if (weakSelf.allBtn.selected) {
                count = self.dataArr.count;
            }else{
                count = self.selectData.count;
            }
            prommit.message = [NSString stringWithFormat:@"你将删除%ld个宝贝", count];
            prommit.sureBlock = ^(UIButton *btn){

                // 删除请求
                [weakSelf deletePictures];
                // 清除数组中数据
                [weakSelf.dataArr removeObjectsInArray:weakSelf.selectData];
                [weakSelf.collectionView reloadData];
                // 清空数据
                [weakSelf.selectData removeAllObjects];
                
                prommit = nil;
                [prommit dismiss];
            };
            [prommit show];
            
        };
    }
    return _bottomView;
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
    
    cell.isHid = _isHid;
    cell.isAllSelect = _isSelect;//[self.selectData containsObject:@(indexPath.row)]
    cell.selectBlock = ^(){
        if ([self.selectData containsObject:model]) {
            //如果点击的cell在deleArr中，则从deleArr中删除
            [self.selectData removeObject:model];
        }else{
            //否则添加cell到
            [self.selectData addObject:model];
        }
        
    };
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
@end
