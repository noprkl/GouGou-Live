//
//  MoreImpressViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MoreImpressViewCell.h"

@interface MoreImpressViewCell ()


@property(nonatomic, strong) UIImageView *markImageView; /**< 图片 */
@end

@implementation MoreImpressViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self.contentView addSubview:self.markImageView];
    }
    return self;
}
- (UIImageView *)markImageView {
    if (!_markImageView) {
        _markImageView = [[UIImageView alloc] init];
        _markImageView.image = [UIImage imageNamed:@"小联系人（辅助）"];
    }
    return _markImageView;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.markImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.centerY);
        make.right.equalTo(self.detailTextLabel.left).offset(-5);
    }];
}
- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
