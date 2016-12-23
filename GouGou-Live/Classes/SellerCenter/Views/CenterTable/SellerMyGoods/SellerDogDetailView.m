//
//  SellerDogDetailView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/19.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerDogDetailView.h"
#import "DogImageView.h"
#import "DogMarkView.h"


@interface SellerDogDetailView ()

/** 发布时间 */
@property (strong, nonatomic) UILabel *promulgateTimeLabel;
/** 狗狗购买状态 */
@property (strong, nonatomic) UILabel *sellStateLabel;
/** 图片view */
@property (strong, nonatomic) DogImageView  *dogImageView;
/** 描述 */
@property (strong, nonatomic) UILabel *descLabel;
/** 标签 */
@property (strong, nonatomic) DogMarkView *markView;
/** 线1 */
@property (strong, nonatomic) UILabel *line1;

/** 名字 */
@property (strong, nonatomic) UILabel *dogNameLabel;
/** 品种 */
@property (strong, nonatomic) UILabel *dogKindLabel;
/** 年龄 */
@property (strong, nonatomic) UILabel *dogAgeLaebl;
/** 体型 */
@property (strong, nonatomic) UILabel *dogSizeLabel;
/** 颜色 */
@property (strong, nonatomic) UILabel *dogColorLaebl;
/** 价格 */
@property (strong, nonatomic) UILabel *dogPriceLaebl;
/** 线2 */
@property (strong, nonatomic) UILabel *line2;

/** 运费 */
@property (strong, nonatomic) UILabel *transMoneyLabel;
/** 运费 */
@property (strong, nonatomic) UILabel *transPriceLabel;
/** 小图标 */
@property (strong, nonatomic) UIImageView *markImageView;
/** 线3 */
@property (strong, nonatomic) UILabel *line3;

/** 30天保障 */
@property (strong, nonatomic) UILabel *safeLaebl;
/** 线4 */
@property (strong, nonatomic) UILabel *line4;


@property(nonatomic, strong) UILabel *noteLabel; /**< 备注 */

@property(nonatomic, strong) UILabel *dogState; /**< 狗狗状态 */

@end

@implementation SellerDogDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor  =[UIColor whiteColor];

        [self addSubview:self.promulgateTimeLabel];
        [self addSubview:self.sellStateLabel];
        [self addSubview:self.dogImageView];
        [self addSubview:self.descLabel];
        [self addSubview:self.markView];
        [self addSubview:self.line1];
        [self addSubview:self.dogNameLabel];
        [self addSubview:self.dogKindLabel];
        [self addSubview:self.dogAgeLaebl];
        [self addSubview:self.dogSizeLabel];
        [self addSubview:self.dogColorLaebl];
        [self addSubview:self.dogPriceLaebl];
        [self addSubview:self.line2];
        [self addSubview:self.transMoneyLabel];
        [self addSubview:self.transPriceLabel];
        [self addSubview:self.markImageView];
        [self addSubview:self.line3];
        [self addSubview:self.safeLaebl];
        [self addSubview:self.line4];
        [self addSubview:self.noteLabel];
        [self addSubview:self.dogState];
        
    }
    return self;
}

- (void)setDogInfo:(DogDetailModel *)dogInfo {
    _dogInfo = dogInfo;
    
//    self.dogAgeLaebl.text = [NSString getAgeFormInt:dogInfo.age];
    self.dogAgeLaebl.text = dogInfo.age.name;
    self.dogColorLaebl.text = dogInfo.color.name;
    self.dogKindLabel.text = dogInfo.kind.name;
    self.dogNameLabel.text = dogInfo.name;
    self.dogSizeLabel.text = dogInfo.size.name;

    self.dogPriceLaebl.text = dogInfo.price;
    
    self.descLabel.text = dogInfo.comment;
    self.promulgateTimeLabel.text = dogInfo.createTime;
    
    NSArray *imsArr = [dogInfo.pathBig componentsSeparatedByString:@","];
    
    CGFloat height = [_dogImageView getCellHeightWithImages:imsArr];
    _dogImageView.frame = CGRectMake(0, 34, SCREEN_WIDTH, height);
    
    // 数组转化模型
    NSArray *impressModels = [DogCategoryModel mj_objectArrayWithKeyValuesArray:dogInfo.impresssion];

    NSMutableArray *impressArr = [NSMutableArray array];
    for (DogCategoryModel *impress in impressModels) {
        [impressArr addObject:impress.name];
    }
    
    [self.markView creatDogMarksWithMark:impressArr];
    
    NSString *state = @"";
    if ([dogInfo.status isEqualToString:@"1"]) {// 1：新建商品 2：审核未通过  3：上线 4：下线5：售完
        state = @"新建商品";
    }else if ([dogInfo.status isEqualToString:@"2"]) {
        state = @"审核未通过";
    }else if ([dogInfo.status isEqualToString:@"3"]) {
        state = @"上线";
    }else if ([dogInfo.status isEqualToString:@"4"]) {
        state = @"下线";
    }else if ([dogInfo.status isEqualToString:@"5"]) {
        state = @"售完";
    }
    self.dogState.text = state;
    self.sellStateLabel.text = state;
}
// 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.promulgateTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(15);
    }];
    
    [self.sellStateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.promulgateTimeLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    
    [self.descLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.dogImageView.bottom).offset(15);
    }];
    [self.markView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.descLabel.centerY);
        make.left.equalTo(self.descLabel.right).offset(10);
        make.height.equalTo(22);
    }];
    
    [self.line1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.dogImageView.bottom).offset(44);
        make.height.equalTo(1);
    }];
    
    [self.dogNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.line1.bottom).offset(10);
    }];
    
    [self.dogKindLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dogNameLabel.right).offset(10);
        make.bottom.equalTo(self.dogNameLabel.bottom);
    }];
    
    [self.dogAgeLaebl makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.dogNameLabel.bottom).offset(5);
    }];
    [self.dogSizeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dogAgeLaebl.right).offset(10);
        make.centerY.equalTo(self.dogAgeLaebl.centerY);
    }];
    [self.dogColorLaebl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogAgeLaebl.centerY);
        make.left.equalTo(self.dogSizeLabel.right).offset(10);
    }];
    [self.dogPriceLaebl makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.dogColorLaebl.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    [self.line2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.line1.bottom).offset(53);
        make.height.equalTo(1);
    }];
    [self.transMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.line2.bottom).offset(15);
    }];
    [self.markImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.transMoneyLabel.centerY);
        make.right.equalTo(self.right).offset(-10);
    }];
    [self.transPriceLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.transMoneyLabel.centerY);
        make.right.equalTo(self.markImageView.left).offset(-10);
    }];
    [self.line3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.line2.bottom).offset(44);
        make.height.equalTo(1);
    }];
    [self.safeLaebl makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.line3.bottom).offset(15);
    }];
    [self.line4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.line3.bottom).offset(44);
        make.height.equalTo(1);
    }];
    [self.noteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line4.bottom).offset(8);
        make.left.equalTo(self.left).offset(10);
    }];
    
    [self.dogState makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noteLabel.bottom).offset(7);
        make.left.equalTo(self.left).offset(10);
    }];
    
//    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetMaxY(self.line4.frame) + 53);
}

#pragma mark
#pragma mark - 懒加载

- (UILabel *)promulgateTimeLabel {
    if (!_promulgateTimeLabel) {
        _promulgateTimeLabel = [[UILabel alloc] init];
        _promulgateTimeLabel.text = @"发布于14小时";
        _promulgateTimeLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _promulgateTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _promulgateTimeLabel;
}
- (UILabel *)sellStateLabel {
    if (!_sellStateLabel) {
        _sellStateLabel = [[UILabel alloc] init];
        _sellStateLabel.text = @"代售";
        _sellStateLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _sellStateLabel.font = [UIFont systemFontOfSize:12];
    }
    return _sellStateLabel;
}
- (DogImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[DogImageView alloc] init];
    }
    return _dogImageView;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"很聪明的狗狗";
        _descLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _descLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descLabel;
}
- (DogMarkView *)markView {
    if (!_markView) {
        _markView = [[DogMarkView alloc] init];
    }
    return _markView;
}
- (UILabel *)line1 {
    if (!_line1) {
        _line1 = [[UILabel alloc] init];
        _line1.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line1;
}
- (UILabel *)dogNameLabel {
    if (!_dogNameLabel) {
        _dogNameLabel = [[UILabel alloc] init];
        _dogNameLabel.text = @"豆豆";
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogNameLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _dogNameLabel;
}
- (UILabel *)dogKindLabel {
    if (!_dogKindLabel) {
        _dogKindLabel = [[UILabel alloc] init];
        _dogKindLabel.text = @"拉布拉多";
        _dogKindLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogKindLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogKindLabel;
}
- (UILabel *)dogAgeLaebl {
    if (!_dogAgeLaebl) {
        _dogAgeLaebl = [[UILabel alloc] init];
        _dogAgeLaebl.text = @"6个月";
        _dogAgeLaebl.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogAgeLaebl.font = [UIFont systemFontOfSize:12];
    }
    return _dogAgeLaebl;
}
- (UILabel *)dogSizeLabel {
    if (!_dogSizeLabel) {
        _dogSizeLabel = [[UILabel alloc] init];
        _dogSizeLabel.text = @"大型犬";
        _dogSizeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogSizeLabel.font = [UIFont systemFontOfSize:12];

    }
    return _dogSizeLabel;
}
- (UILabel *)dogColorLaebl {
    if (!_dogColorLaebl) {
        _dogColorLaebl = [[UILabel alloc] init];
        _dogColorLaebl.text = @"";
        _dogColorLaebl.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogColorLaebl.font = [UIFont systemFontOfSize:12];
    }
    return _dogColorLaebl;
}
- (UILabel *)dogPriceLaebl {
    if (!_dogPriceLaebl) {
        _dogPriceLaebl = [[UILabel alloc] init];
        _dogPriceLaebl.text = @"¥ 1400";
        _dogPriceLaebl.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        _dogPriceLaebl.font = [UIFont systemFontOfSize:14];
    }
    return _dogPriceLaebl;
}
- (UILabel *)line2 {
    if (!_line2) {
        _line2 = [[UILabel alloc] init];
        _line2.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line2;
}

- (UILabel *)transMoneyLabel {
    if (!_transMoneyLabel) {
        _transMoneyLabel = [[UILabel alloc] init];
        _transMoneyLabel.text = @"运费";
        _transMoneyLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _transMoneyLabel.font = [UIFont systemFontOfSize:16];
    }
    return _transMoneyLabel;
}
- (UILabel *)transPriceLabel {
    if (!_transPriceLabel) {
        _transPriceLabel = [[UILabel alloc] init];
        _transPriceLabel.text = @"默认价格¥50";
        _transPriceLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _transPriceLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _transPriceLabel;
}
- (UIImageView *)markImageView {
    if (!_markImageView) {
        _markImageView = [[UIImageView alloc] init];
        _markImageView.image = [UIImage imageNamed:@"返回-（小）"];
    }
    return _markImageView;
}
- (UILabel *)line3 {
    if (!_line3) {
        _line3 = [[UILabel alloc] init];
        _line3.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line3;
}

- (UILabel *)safeLaebl {
    if (!_safeLaebl) {
        _safeLaebl = [[UILabel alloc] init];
        _safeLaebl.text = @"30天细小病毒保障";
        _safeLaebl.textColor = [UIColor colorWithHexString:@"#000000"];
        _safeLaebl.font = [UIFont systemFontOfSize:16];
    }
    return _safeLaebl;
}

- (UILabel *)line4 {
    if (!_line4) {
        _line4 = [[UILabel alloc] init];
        _line4.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line4;
}
- (UILabel *)noteLabel {
    if (!_noteLabel) {
        _noteLabel = [[UILabel alloc] init];
        _noteLabel.text = @"备注";
        _noteLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _noteLabel.font = [UIFont systemFontOfSize:14];
    }
    return _noteLabel;
}
- (UILabel *)dogState {
    if (!_dogState) {
        _dogState = [[UILabel alloc] init];
        _dogState.text = @"已通过审核";
        _dogState.textColor = [UIColor colorWithHexString:@"#333333"];
        _dogState.font = [UIFont systemFontOfSize:12];
    }
    return _dogState;
}

@end
