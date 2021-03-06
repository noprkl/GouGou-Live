//
//  NotificationMessageCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "NotificationMessageCell.h"
#import "SystemPushMessageModel.h"

@interface NotificationMessageCell ()
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageContentLabel;

@end

@implementation NotificationMessageCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(SystemPushMessageModel *)model {
    _model = model;
    self.timeLabel.text = [NSString stringFromDateString:model.createTime];
    self.messageContentLabel.text = model.conent;
    if (model.conent.length == 0) {
        self.timeLabel.hidden = YES;
    }else{
        self.timeLabel.hidden = NO;
    }
}
- (void)setUnReadCount:(NSInteger)unReadCount {
    _unReadCount = unReadCount;
    
    if (unReadCount == 0) {
        self.messageCountLabel.hidden = YES;
    }else{
        self.messageCountLabel.hidden = NO;
        self.messageCountLabel.text = [NSString stringWithFormat:@"%ld", unReadCount];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
