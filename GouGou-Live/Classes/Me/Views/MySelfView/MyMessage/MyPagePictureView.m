//
//  MyPagePictureView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyPagePictureView.h"
#import "ManagePictureaCell.h"
#import "MyAlbumsModel.h"

@interface MyPagePictureView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property(nonatomic, strong) UILabel *albumLabel; /**< 相册 */

@property(nonatomic, assign) CGFloat W; /**< 宽高 */

@property(nonatomic, strong) UIButton *manageAlbum; /**< 管理相册 */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */
@property(nonatomic, strong) UICollectionView *collectionView; /**< 列表 */

@end
static NSString *cellid = @"ManagePictureaCell";

@implementation MyPagePictureView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.albumLabel];
        [self addSubview:self.manageAlbum];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.albumLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.manageAlbum makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self addSubview:self.collectionView];

    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.albumLabel.bottom).offset(10);
    }];

}
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    if (maxCount <= kMaxImgCount) {
        _W = (SCREEN_WIDTH - (_maxCount + 1) * 10) / _maxCount;
    }else{
        _W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
    }
}
- (void)setDataPlist:(NSArray *)dataPlist {
    _dataPlist = dataPlist;
    self.dataArr = dataPlist;
    [self.collectionView reloadData];
}
- (void)clickManageBtnAction {
    if (_manageBlock) {
        _manageBlock();
    }
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)albumLabel {
    if (!_albumLabel) {
        _albumLabel = [[UILabel alloc] init];
        _albumLabel.text = @"相册";
        _albumLabel.font = [UIFont systemFontOfSize:18];
    }
    return _albumLabel;
}
- (UIButton *)manageAlbum {
    if (!_manageAlbum) {
        _manageAlbum = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_manageAlbum setTitle:@"管理" forState:(UIControlStateNormal)];
        _manageAlbum.titleLabel.font = [UIFont systemFontOfSize:18];
        [_manageAlbum setTintColor:[UIColor colorWithHexString:@"#000000"]];
        [_manageAlbum addTarget:self action:@selector(clickManageBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _manageAlbum;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        NSInteger count = self.dataArr.count;
        CGFloat W = 0;
        if (count == 1) {
            count = 2;
            W = (SCREEN_WIDTH - (count + 1) * 10) / count;
        }else if (count > 1){
            
            W = (SCREEN_WIDTH - (count + 1) * 10) / count;
        }
        flowlayout.itemSize = CGSizeMake(W, W + 20);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"ManagePictureaCell" bundle:nil] forCellWithReuseIdentifier:cellid];
    }
    return _collectionView;
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ManagePictureaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    cell.model = self.dataArr[indexPath.row];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_pictureBlock) {
        _pictureBlock();
    }
}
@end
