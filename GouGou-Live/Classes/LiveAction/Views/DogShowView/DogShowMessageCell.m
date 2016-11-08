//
//  DogShowMessageCell.m
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogShowMessageCell.h"
#import "DogImageView.h"
#import "DogMarkView.h"

@interface DogShowMessageCell ()

/** 发布时间 */
@property (strong, nonatomic) UILabel *promulgateTimeLabel;
/** 展播状态 */
@property (strong, nonatomic) UILabel *liveStateLabel;
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

/** 30天 */
@property (strong, nonatomic) UILabel *safeLaebl;
/** 线4 */
@property (strong, nonatomic) UILabel *line4;

/** 分享按钮 */
@property (strong, nonatomic) UIButton *shareBtn;
/** 喜欢 */
@property (strong, nonatomic) UIButton *likeBtn;
/** 订购 */
@property (strong, nonatomic) UIButton *bookBtn;
/** 线5 */
@property (strong, nonatomic) UILabel *line5;

@end

@implementation DogShowMessageCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.promulgateTimeLabel];
        [self.contentView addSubview:self.liveStateLabel];
        [self.contentView addSubview:self.dogImageView];
        [self.contentView addSubview:self.descLabel];
        [self.contentView addSubview:self.markView];
        [self.contentView addSubview:self.line1];
        [self.contentView addSubview:self.dogNameLabel];
        [self.contentView addSubview:self.dogKindLabel];
        [self.contentView addSubview:self.dogAgeLaebl];
        [self.contentView addSubview:self.dogSizeLabel];
        [self.contentView addSubview:self.dogColorLaebl];
        [self.contentView addSubview:self.dogPriceLaebl];
        [self.contentView addSubview:self.line2];
        [self.contentView addSubview:self.transMoneyLabel];
        [self.contentView addSubview:self.transPriceLabel];
        [self.contentView addSubview:self.markImageView];
        [self.contentView addSubview:self.line3];
        [self.contentView addSubview:self.safeLaebl];
        [self.contentView addSubview:self.line4];
       
        [self setBtn:self.shareBtn title:@"分享" normalImage:[UIImage imageNamed:@"分享-icon"] selectImage:[UIImage imageNamed:@"分享-icon(点击"]];
        [self setBtn:self.likeBtn title:@"喜欢" normalImage:[UIImage imageNamed:@"喜欢"] selectImage:[UIImage imageNamed:@"喜欢icon(点击"]];
        [self setBtn:self.bookBtn title:@"订购" normalImage:[UIImage imageNamed:@"订购icon"] selectImage:[UIImage imageNamed:@"订购icon（点击-拷贝"]];
        
        [self.contentView addSubview:self.line5];
    }
    return self;
}

// 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.promulgateTimeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(15);
    }];
    
    [self.liveStateLabel makeConstraints:^(MASConstraintMaker *make) {
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
    
    [self.shareBtn makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left);
        make.top.equalTo(self.line4.bottom);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 44));
    }];
    
    [self.likeBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.shareBtn.centerY);
        make.left.equalTo(self.shareBtn.right);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 44));
    }];
    [self.bookBtn makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.likeBtn.centerY);
        make.right.equalTo(self.right);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 44));

    }];
    [self.line5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.line4.bottom).offset(44);
        make.height.equalTo(10);
    }];
}
- (CGFloat)getCellHeight {
    return CGRectGetMaxY(self.line5.frame);
}
#pragma mark
#pragma mark - 懒加载

- (UILabel *)promulgateTimeLabel {
    if (!_promulgateTimeLabel) {
        _promulgateTimeLabel = [[UILabel alloc] init];
        _promulgateTimeLabel.text = @"发布时间";
        _promulgateTimeLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _promulgateTimeLabel.font = [UIFont systemFontOfSize:12];
    }
    return _promulgateTimeLabel;
}
- (UILabel *)liveStateLabel {
    if (!_liveStateLabel) {
        _liveStateLabel = [[UILabel alloc] init];
        _liveStateLabel.text = @"展播状态";
        _promulgateTimeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _promulgateTimeLabel.font = [UIFont systemFontOfSize:12];

    }
    return _liveStateLabel;
}
- (DogImageView *)dogImageView {
    if (!_dogImageView) {
        _dogImageView = [[DogImageView alloc] init];
        
        CGFloat height = [_dogImageView getCellHeightWithImages:@[@"组-7", @"组-7", @"组-7", @"组-7"]];
        _dogImageView.frame = CGRectMake(0, 34, SCREEN_WIDTH, height);
        
    }
    return _dogImageView;
}
- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.text = @"狗狗描述";
        _descLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _descLabel.font = [UIFont systemFontOfSize:12];
    }
    return _descLabel;
}
- (DogMarkView *)markView {
    if (!_markView) {
        _markView = [[DogMarkView alloc] initWithFrame:CGRectZero Titles:@[@"聪明", @"不掉毛", @"可爱"]];
        
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
        _dogNameLabel.text = @"名字";
        _dogNameLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogNameLabel.font = [UIFont systemFontOfSize:16];

    }
    return _dogNameLabel;
}
- (UILabel *)dogKindLabel {
    if (!_dogKindLabel) {
        _dogKindLabel = [[UILabel alloc] init];
        _dogKindLabel.text = @"品种";
        _dogKindLabel.textColor = [UIColor colorWithHexString:@"#000000"];
        _dogKindLabel.font = [UIFont systemFontOfSize:12];
    }
    return _dogKindLabel;
}
- (UILabel *)dogAgeLaebl {
    if (!_dogAgeLaebl) {
        _dogAgeLaebl = [[UILabel alloc] init];
        _dogAgeLaebl.text = @"年龄";
        _dogAgeLaebl.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogAgeLaebl.font = [UIFont systemFontOfSize:12];
    }
    return _dogAgeLaebl;
}
- (UILabel *)dogSizeLabel {
    if (!_dogSizeLabel) {
        _dogSizeLabel = [[UILabel alloc] init];
        _dogSizeLabel.text = @"体型";
        _dogSizeLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogSizeLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _dogSizeLabel;
}
- (UILabel *)dogColorLaebl {
    if (!_dogColorLaebl) {
        _dogColorLaebl = [[UILabel alloc] init];
        _dogColorLaebl.text = @"颜色";
        _dogColorLaebl.textColor = [UIColor colorWithHexString:@"#666666"];
        _dogColorLaebl.font = [UIFont systemFontOfSize:12];
    }
    return _dogColorLaebl;
}
- (UILabel *)dogPriceLaebl {
    if (!_dogPriceLaebl) {
        _dogPriceLaebl = [[UILabel alloc] init];
        _dogPriceLaebl.text = @"¥ 价格";
        _dogPriceLaebl.textColor = [UIColor colorWithHexString:@"#ffa11a"];
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
        _transPriceLabel.text = @"默认价格";
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
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_shareBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
        [_shareBtn addTarget:self action:@selector(clickShareBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _shareBtn;
}
- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_likeBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
        [_likeBtn addTarget:self action:@selector(clickLikeBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _likeBtn;
}
- (UIButton *)bookBtn {
    if (!_bookBtn) {
        _bookBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_bookBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
        [_bookBtn addTarget:self action:@selector(clickBookBtnAction:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _bookBtn;
}
- (UILabel *)line5 {
    if (!_line5) {
        _line5 = [[UILabel alloc] init];
        _line5.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _line5;
}
- (void)setBtn:(UIButton *)button title:(NSString *)title normalImage:(UIImage *)normalImage selectImage:(UIImage *)selectImage {
    
    // 正常
    NSDictionary *normalAttributeDict = @{
                                          NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#000000"],
                                          NSFontAttributeName:[UIFont systemFontOfSize:16]
                                          };
    NSAttributedString *normalAttribute = [[NSAttributedString alloc] initWithString:title attributes:normalAttributeDict];
    
    [button setAttributedTitle:normalAttribute forState:(UIControlStateNormal)];
    [button setImage:normalImage forState:(UIControlStateNormal)];
    
    [button setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
    [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
    [button setImage:selectImage forState:(UIControlStateHighlighted)];

    // 选中
//    NSDictionary *selectAttributeDict = @{
//                                          NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffffff"],
//                                          NSFontAttributeName:[UIFont systemFontOfSize:16]
//                                          };
//    NSAttributedString *selectAttribute = [[NSAttributedString alloc] initWithString:title attributes:selectAttributeDict];
//    [button setImage:selectImage forState:(UIControlStateSelected)];
//    
//    [button setAttributedTitle:selectAttribute forState:(UIControlStateSelected)];
    
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [self.contentView addSubview:button];
}

- (void)btnHighlightColor:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
}
#pragma mark
#pragma mark - Action 

- (void)clickShareBtnAction:(UIButton *)btn {
    
    if (_shareBlock) {
        _shareBlock();
    }
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
}
- (void)clickLikeBtnAction:(UIButton *)btn {
    
    if (_likeBlock) {
        _likeBlock();
    }
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
}
- (void)clickBookBtnAction:(UIButton *)btn {
    
    if (_bookBlock) {
        _bookBlock();
    }
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
