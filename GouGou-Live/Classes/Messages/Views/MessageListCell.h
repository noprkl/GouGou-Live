//
//  MessageListCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *isFocus;
@property (weak, nonatomic) IBOutlet UILabel *lastMessageLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *unreadCountLabel;

@property (strong, nonatomic) id<IConversationModel> model;

@end
