//
//  AddUpdataImagesView.m
//  Test1
//
//  Created by ma c on 16/11/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddUpdataImagesView.h"
#import "AddUpdataImagesCell.h"

@interface AddUpdataImagesView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property(nonatomic, strong) UIButton *addBtn; /**< 添加按钮 */

@property(nonatomic, assign) CGFloat W; /**< 宽高 */

@end
static NSString *cellid = @"AddUpdataImagesCell";

@implementation AddUpdataImagesView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.collectionView];
    [self addSubview:self.addBtn];

    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.top.right.equalTo(self);
    }];
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, _W + 10);
}
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    if (maxCount <= kMaxImgCount) {
        _W = (SCREEN_WIDTH - (_maxCount + 1) * 10) / _maxCount;
    }else{
        _W = (SCREEN_WIDTH - (kMaxImgCount + 1) * 10) / kMaxImgCount;
    }
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        flowlayout.itemSize = CGSizeMake(_W, _W);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        _collectionView.showsVerticalScrollIndicator = NO;
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"AddUpdataImagesCell" bundle:nil] forCellWithReuseIdentifier:cellid];
    }
    return _collectionView;
}
- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setImage:[UIImage imageNamed:@"添加照片"] forState:(UIControlStateNormal)];
        _addBtn.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _addBtn.layer.borderWidth = 1;
        _addBtn.frame = CGRectMake(10, 10, _W, _W);
        [_addBtn addTarget:self action:@selector(ClickAddAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _addBtn;
}
- (void)ClickAddAction:(UIButton *)btn {
    if (_addBlock) {
        _addBlock();
    }
}
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 设置添加按钮 不能放在 cell重用中，row == 0时 不走那个方法
    if (self.dataArr.count >= _maxCount) {
        self.addBtn.hidden = YES;
    }else{
        self.addBtn.hidden = NO;
    }
    CGFloat row = self.dataArr.count / kMaxImgCount;
   
    CGFloat col = self.dataArr.count % kMaxImgCount;
    [self.addBtn remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(col * (_W + 10) + 10);
        make.top.equalTo(row * (_W + 10) + 10);
        make.size.equalTo(CGSizeMake(_W, _W));
    }];
    
    
    
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddUpdataImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    UIImage *image = self.dataArr[indexPath.row];
    
    cell.image = image;
    cell.deleteBlock = ^(){
        [self.dataArr removeObject:image];
        [self.collectionView reloadData];
    };
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//    if (indexPath.row == (self.dataArr.count - 1)) {
//        if (_addBlock) {
//            // 传过去并添加返回的照片
//            [self.dataArr insertObject:_addBlock() atIndex:(indexPath.row - 1)];
//
//            // 刷新数据
//            [self.collectionView reloadData];
//        }
//    }
    NSLog(@"%ld", indexPath.row);
}
@end
