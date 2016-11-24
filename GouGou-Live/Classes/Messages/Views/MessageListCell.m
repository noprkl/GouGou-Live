//
//  MessageListCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageListCell.h"
#import "IConversationModel.h"

@implementation MessageListCell
- (void)setModel:(id<IConversationModel>)model
{
    _model = model;
    
    // 昵称
    if ([_model.title length] > 0) {
        self.nickNameLabel.text = _model.title;
    }
    else{
        self.nickNameLabel.text = _model.conversation.conversationId;
    }
    // 头像
    if ([_model.avatarURLPath length] > 0){
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:_model.avatarURLPath] placeholderImage:_model.avatarImage];
    } else {
        if (_model.avatarImage) {
            self.iconView.image = _model.avatarImage;
        }
    }

    // id 判断是否
    NSString *ids = model.conversation.conversationId;
    // 未读信息
    if ([model.conversation unreadMessagesCount] > 0) {
        self.unreadCountLabel.hidden = NO;
        self.unreadCountLabel.text = [@([model.conversation unreadMessagesCount]) stringValue];
    }
    self.unreadCountLabel.hidden = YES;
   
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
