//
//  TalkTableViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TalkTableViewCell.h"

@implementation TalkTableViewCell

- (void)setModel:(id<IMessageModel>)model
{
    [super setModel:model];
    
    _nameLabel.text = model.nickname;
    // 聊天内容
    EMMessage *message = model.message;
    EMMessageBody *msgBody = message.body;
    EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
    NSString *txt = textBody.text;
    self.contentLabel.text = txt;

    if (self.model.isSender) {
        _hasRead.hidden = YES;
        switch (self.model.messageStatus) {
            case EMMessageStatusDelivering:
            {
            _statusButton.hidden = YES;
            [_activity setHidden:NO];
            [_activity startAnimating];
            }
                break;
            case EMMessageStatusSuccessed:
            {
            _statusButton.hidden = YES;
            [_activity stopAnimating];
            if (self.model.isMessageRead) {
                _hasRead.hidden = NO;
            }
            }
                break;
            case EMMessageStatusPending:
            case EMMessageStatusFailed:
            {
            [_activity stopAnimating];
            [_activity setHidden:YES];
            _statusButton.hidden = NO;
            }
                break;
            default:
                break;
        }
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
