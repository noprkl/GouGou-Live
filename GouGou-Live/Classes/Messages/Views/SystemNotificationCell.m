//
//  SystemNotificationCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/28.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SystemNotificationCell.h"
#import "SystemPushMessageModel.h"

@interface SystemNotificationCell ()
@property (weak, nonatomic) IBOutlet UILabel *notificationType;

@property (weak, nonatomic) IBOutlet UILabel *notificationContent;
@property (weak, nonatomic) IBOutlet UILabel *notificationTime;

@end

@implementation SystemNotificationCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(SystemPushMessageModel *)model {
    _model = model;
    self.notificationTime.text = [NSString stringFromDateString:model.createTime];
    self.notificationType.text = model.type;
    self.notificationContent.text = model.conent;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
