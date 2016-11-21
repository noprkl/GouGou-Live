//
//  SellerDoInputCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerDoInputCell.h"

@interface SellerDoInputCell ()
@property (weak, nonatomic) IBOutlet UIImageView *dogImage;
@property (weak, nonatomic) IBOutlet UILabel *dogType;
@property (weak, nonatomic) IBOutlet UILabel *dogSize;

@property (weak, nonatomic) IBOutlet UILabel *dogMark;
@property (weak, nonatomic) IBOutlet UILabel *liveCount;

@end

@implementation SellerDoInputCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)clickSureAddAction:(UIButton *)sender {
    if (_sureAddBlock) {
        _sureAddBlock();
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
