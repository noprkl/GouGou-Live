//
//  DetailCountViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DetailCountViewCell.h"

@interface DetailCountViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *balanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *incomeLabel;


@end

@implementation DetailCountViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(UserAssetModel *)model {
    _model = model;
    NSString *type = @"";

    if ([model.assetChangeType isEqualToString:@"-1"]) { //转出，下单扣除
        type = @"转出，下单扣除";
    }else if ([model.assetChangeType isEqualToString:@"-2"]){ //转出，提现
        type = @"转出，提现";
    }else if ([model.assetChangeType isEqualToString:@"1"]){ //转入，维权
        type = @"转入，维权";
    }else if ([model.assetChangeType isEqualToString:@"2"]){ //转入，后台充值
        type = @"转入，后台充值";
    }else if ([model.assetChangeType isEqualToString:@"3"]){ //转入，取消订单，获得系统退款
        type = @"转入，取消订单，获得系统退款";
    }
    self.stateLabel.text = type;
    self.incomeLabel.text = model.assetChange;
    self.balanceLabel.text = model.nowAsset;
    self.timeLabel.text = model.assetChangeTime;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
