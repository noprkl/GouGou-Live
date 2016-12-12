//
//  AddShowDogImgCell.m
//  GouGou-Live
//
//  Created by ma c on 16/12/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddShowDogImgCell.h"

@interface AddShowDogImgCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *deleButton;

@end

@implementation AddShowDogImgCell
- (IBAction)clickDeleAction:(UIButton *)sender {
    if (_deleteBlock) {
        _deleteBlock();
    }
}
- (void)setModel:(SellerMyGoodsModel *)model {
    _model = model;
    if (model.pathSmall != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathSmall];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }else{
        self.iconView.image = [UIImage imageNamed:@"组-7"];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

@end
