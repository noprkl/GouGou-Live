//
//  AddPictureView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddPictureView.h"

#import "AddUpdataImagesCell.h"

// 每行个数
#define lineImaCount 5
// 图片总数
#define ImgTotalCount 7

static NSString *cellid = @"AddUpdataImagesCell";

@interface AddPictureView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/** 晒晒宝贝 */
@property (strong,nonatomic) UILabel *textLabel;

@property(nonatomic, strong) UIButton *addBtn; /**< 添加按钮 */

@property(nonatomic, assign) CGFloat W; /**< 宽高 */
/** 计数 */
@property (strong,nonatomic) UILabel *countLabel;
@end

@implementation AddPictureView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self addSubview:self.collectionView];
    [self addSubview:self.addBtn];
    [self addSubview:self.textLabel];
    [self addSubview:self.countLabel];
    
    [self.collectionView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.top.right.equalTo(self);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.right).offset(-10);
        make.bottom.equalTo(self.bottom).offset(-10);
        
    }];
}

- (void)setPictureCounts:(NSInteger)pictureCounts {

    _pictureCounts = pictureCounts;
    self.countLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.dataArr.count ,self.maxCount];
}

// 通过最大图片张数与每行最大数比较设置图片尺寸
- (void)setMaxCount:(NSInteger)maxCount {
    _maxCount = maxCount;
    if (maxCount <= lineImaCount) {
        _W = (SCREEN_WIDTH - (_maxCount + 1) * 10) / _maxCount;
    }else{
        _W = (SCREEN_WIDTH - (lineImaCount + 1) * 10) / lineImaCount;
    }
}
#pragma mark - 懒加载
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
        [_addBtn setTitle:@"添加图片" forState:UIControlStateNormal];
        _addBtn.layer.borderColor = [UIColor colorWithHexString:@"#99cc33"].CGColor;
        _addBtn.layer.cornerRadius = 5;
        _addBtn.layer.masksToBounds = YES;
        
        _addBtn.imageEdgeInsets = UIEdgeInsetsMake(-20, 15, 0, 0);
        _addBtn.titleEdgeInsets = UIEdgeInsetsMake(30, -60, 0, -30);
        
        [_addBtn setTitleColor:[UIColor colorWithHexString:@"#999999"] forState:UIControlStateNormal];
        
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _addBtn.layer.borderWidth = 1;
        _addBtn.frame = CGRectMake(10, 10, _W, _W);
        [_addBtn addTarget:self action:@selector(ClickAddAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _addBtn;
}
- (UILabel *)textLabel {
    
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(89, 64, 100, 25)];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _textLabel.text = @"晒晒小宝贝";
    }
    return _textLabel;
}
- (UILabel *)countLabel {
    
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.text = @"0/7";
    }
    return _countLabel;
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
    CGFloat row = self.dataArr.count / lineImaCount;
    
    CGFloat col = self.dataArr.count % lineImaCount;
    
    // 设置添加按钮的相对位置
    if (self.dataArr.count < _maxCount) {
        
        self.addBtn.userInteractionEnabled = YES;
        
        [self.addBtn remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(col * (_W + 10) + 10);
            make.top.equalTo(row * (_W + 10) + 10);
            make.size.equalTo(CGSizeMake(_W, _W));
        }];
        
        if (self.dataArr.count == self.maxCount - 1) {
            
            [self.textLabel remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo(col * (_W +10) +10);
                make.top.equalTo((row +1)* (_W + 10) + 44);
                make.size.equalTo(CGSizeMake(70, 20));
                
            }];

            
        } else {
        
            [self.textLabel remakeConstraints:^(MASConstraintMaker *make) {
                
                make.left.equalTo((col + 1) * (_W +10) +10);
                make.top.equalTo(row * (_W + 10) + 44);
                make.size.equalTo(CGSizeMake(70, 20));
                
            }];

        }
        
    } else{
        
        [self.addBtn remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(col * (_W + 10) + 10);
            make.top.equalTo(row * (_W + 10) + 10);
            make.size.equalTo(CGSizeMake(_W, _W));
        }];
        [self.textLabel remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo((col + 1) * (_W +10) +10);
            make.top.equalTo(row * (_W + 10) + 44);
            make.size.equalTo(CGSizeMake(70, 20));
            
        }];
        // 超过最大图片数量设置addBtn不能点击
        self.addBtn.userInteractionEnabled = NO;
        
    }
    return self.dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AddUpdataImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellid forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    UIImage *image = self.dataArr[indexPath.row];
    
    cell.image = image;
    cell.deleteBlock = ^(){
        
        if (_deleteBlock) {
            
            [self.dataArr removeObject:image];
            
            self.pictureCounts = self.dataArr.count;
            
            self.pictureCounts--;
            
            [self.collectionView reloadData];
            
            _deleteBlock();
        }
    };
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
//        if (indexPath.row == (self.dataArr.count - 1)) {
//            if (_addBlock) {
//                // 传过去并添加返回的照片
//                [self.dataArr insertObject:_addBlock() atIndex:(indexPath.row - 1)];
//    
//                // 刷新数据
//                [self.collectionView reloadData];
//            }
//        }
    NSLog(@"%ld", indexPath.row);
}
@end

