//
//  MessageCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageCell.h"

@interface MessageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageCountLabel;
@end

@implementation MessageCell

- (void)setIsFocus:(BOOL)isFocus {
    _isFocus = isFocus;
    self.focusLabel.selected = !isFocus;
}
- (void)setFocusHide:(BOOL)focusHide {
    _focusHide = focusHide;
    self.focusLabel.hidden = focusHide;
}
- (void)setCountHide:(BOOL)countHide {
    _countHide = countHide;
    self.messageCountLabel.hidden = countHide;
}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
