//
//  MessageListCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageListCell.h"
#import "IConversationModel.h"
#import "HTTPTool.h"
#import "PersonalMessageModel.h"
@implementation MessageListCell
- (void)setModel:(id<IConversationModel>)model
{
    _model = model;
    NSDictionary *dict = @{
                           @"id":model.conversation.conversationId
                           };
    [HTTPTool getRequestWithPath:@"http://gougou.itnuc.com/api/UserService/personal" params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [PersonalMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
       PersonalMessageModel *personalModel = [arr lastObject];
        if (personalModel.userName != NULL) {
            self.nickNameLabel.text = personalModel.userName;
        }else{
            
        }
        if (personalModel.userImgUrl != NULL) {
            NSString *img = [IMAGE_HOST stringByAppendingString:personalModel.userImgUrl];
            
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];

    
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
