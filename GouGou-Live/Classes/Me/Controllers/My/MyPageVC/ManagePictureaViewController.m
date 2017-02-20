//
//  ManagePictureaViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

// 列数
#define kCols 2

#import "ManagePictureaViewController.h"
#import "ManagePictureaCell.h" 
#import "SellerGoodsBottomView.h" 
#import "SellerGoodsBarBtnView.h"
#import "SellerDeleDDetailView.h"
#import "AddPicturesViewController.h" // 添加相册
#import "PicturesViewController.h" //相册

#import "MyAlbumsModel.h"
#import "NoneDateView.h"

@interface ManagePictureaViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UIGestureRecognizerDelegate>

@property(nonatomic, strong) UICollectionView *collectionView; /**< 表格 */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) NSMutableArray *selectData; /**< 选中数据 */

@property(nonatomic, assign) BOOL isSelect; /**< 是否选中 */
@property(nonatomic, assign) BOOL isHid; /**< 是否隐藏 */

@property(nonatomic, strong) SellerGoodsBottomView *bottomView; /**< 选中按钮 */

@property(nonatomic, strong) SellerGoodsBarBtnView *barBtnView; /**< 上边按钮 */
@property(nonatomic, strong) UIButton *allBtn; /**< 全选按钮 */

@property (nonatomic, strong) NoneDateView *noneDateView; /**< 没有数据 */

@end
static NSString *cellid = @"ManagePictureaCell";

@implementation ManagePictureaViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 请求数据
    [self getRequestAlbums];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
- (void)getRequestAlbums {
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue])
                           };
    [self getRequestWithPath:API_album params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        [self.dataArr removeAllObjects];
        if ([successJson[@"code"] isEqualToString:@"0"]) {
            self.noneDateView.hidden = NO;
            self.collectionView.hidden = YES;
        }else{
            self.noneDateView.hidden = YES;
            self.collectionView.hidden = NO;
            self.dataArr = [MyAlbumsModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        }
        
        // 刷新
        [self.collectionView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)deleAlbum {
    for (NSInteger i = 0; i < self.selectData.count; i ++) {
        MyAlbumsModel *model = self.selectData[i];
        [self.selectData replaceObjectAtIndex:i withObject:model.ID];
    }
    NSDictionary *dict = @{
                           @"user_id":@([[UserInfos sharedUser].ID integerValue]),
                           @"id":[self.selectData componentsJoinedByString:@","]
                           };
    [self getRequestWithPath:API_Del_albums params:dict success:^(id successJson) {
//        DLog(@"%@", successJson);
        [self showAlert:successJson[@"message"]];
        [self getRequestAlbums];
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
    
    self.title = @"相册管理";
   
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:self.barBtnView];
    self.navigationItem.rightBarButtonItem = item;
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.noneDateView];
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(50);
    }];
    _isSelect = NO;
    _isHid = YES;
}
- (void)choseAddPicture:(UIButton *)btn {
    btn.selected = !btn.selected;
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
        CGFloat W = (SCREEN_WIDTH - 36) / 2;
        flowlayout.itemSize = CGSizeMake(W, W + 35);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,  0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"ManagePictureaCell" bundle:nil] forCellWithReuseIdentifier:cellid];
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
            // 添加相册
            AddPicturesViewController *addPicturesVC = [[AddPicturesViewController alloc] init];
            [weakSelf.navigationController pushViewController:addPicturesVC animated:YES];
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

            __strong typeof(weakSelf) strSelf = weakSelf;

            prommit.sureBlock = ^(UIButton *btn){
                [strSelf deleAlbum];
                
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
- (NoneDateView *)noneDateView {
    if (!_noneDateView) {
        _noneDateView = [[NoneDateView alloc] initWithFrame:self.view.bounds];
        _noneDateView.noteStr = @"没有相册";
        _noneDateView.hidden = YES;
        _noneDateView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _noneDateView;
}

#pragma mark
#pragma mark - 代理
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ManagePictureaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    MyAlbumsModel *model = self.dataArr[indexPath.row];
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

    // 添加长按手势 修改相册名字
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    return cell;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PicturesViewController *pictureVc  = [[PicturesViewController alloc] init];
    
    pictureVc.title = [NSString stringWithFormat:@"相册%ld", indexPath.row];
    pictureVc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:pictureVc animated:YES];
}
@end
