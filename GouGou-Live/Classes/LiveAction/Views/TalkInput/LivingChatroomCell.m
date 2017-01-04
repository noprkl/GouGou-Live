
//
//  LivingChatroomCell.m
//  GouGou-Live
//
//  Created by ma c on 17/1/2.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "LivingChatroomCell.h"

@interface LivingChatroomCell ()

@property (nonatomic, strong) UILabel *fromLabel; /**< 发送者 */

@property (nonatomic, strong) UILabel *messageLabel; /**< 消息内容 */

@end

@implementation LivingChatroomCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.fromLabel];
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}
- (CGFloat)getCellHeight {
    // 重新布局子控件
    [self layoutIfNeeded];

    return 5 + self.messageLabel.bounds.size.height + 5;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.fromLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.left).offset(10);
        make.top.equalTo(self.top).offset(5);
    }];
    [self.messageLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fromLabel.right).offset(10);
        make.top.equalTo(self.top).offset(5);
        make.right.equalTo(self.right).offset(-10);
    }];
}
- (UILabel *)fromLabel {
    if (!_fromLabel) {
        _fromLabel = [[UILabel alloc] init];
        _fromLabel.textColor = [UIColor colorWithHexString:@"#3333333"];
        _fromLabel.font = [UIFont systemFontOfSize:13];
    }
    return _fromLabel;
}
- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor colorWithHexString:@"#3333333"];
        _messageLabel.font = [UIFont systemFontOfSize:13];
    }
    return _messageLabel;
}
- (void)setMessage:(EMMessage *)message {
    if ([message.body isKindOfClass:[EMTextMessageBody class]]) {
        EMTextMessageBody *textBody = (EMTextMessageBody *)message.body;
        self.messageLabel.text = textBody.text;
        if ([message.conversationId isEqualToString:_owner]) {
            self.fromLabel.text = @"主播";
        }else{
            self.fromLabel.text = @"游客";
        }
    }
}

@end
