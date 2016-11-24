//
//  MessageChatListViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/24.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageChatListViewController.h"

#import "MessageListCell.h"

#import "SingleChatViewController.h"

@interface MessageChatListViewController ()<EaseConversationListViewControllerDataSource, EaseConversationListViewControllerDelegate, IEMChatManager, UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, strong) NSMutableArray *arrConversion; /**< 所有会话数据 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end
static NSString *cellid = @"MessageListCell";

@implementation MessageChatListViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.arrConversion = [[[EMClient sharedClient].chatManager getAllConversations] mutableCopy];
    DLog(@"%@", self.arrConversion);
    [self.tableView reloadData];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:@"MessageListCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrConversion.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
    if (conversation.type == EMConversationTypeChat) {
        if (conversation.latestMessage) {
            cell.nickNameLabel.text = conversation.conversationId;
            cell.iconView.image = [UIImage imageNamed:@"头像"];
            cell.lastMessageLabel.text = [self _latestMessageTitleForConversation:conversation];
            cell.lastTimeLabel.text = [self _latestMessageTimeForConversation:conversation];
            cell.isFocus.selected = (indexPath.row % 2) == 0 ? YES:NO;
            if (conversation.unreadMessagesCount == 0) {
                cell.unreadCountLabel.hidden = YES;
            }else{
                cell.unreadCountLabel.text = [@([conversation unreadMessagesCount]) stringValue];
            }
            
        }
    }
    
    
    return cell;
}
// 最后信息
- (NSString *)_latestMessageTimeForConversation:(EMConversation *)conversation
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}
// 最后时间
- (NSString *)_latestMessageTitleForConversation:(EMConversation *)conversation
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSEaseLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSEaseLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSEaseLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSEaseLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSEaseLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
    
    SingleChatViewController *singleVC = [[SingleChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:(EMConversationTypeChat)];
    singleVC.hidesBottomBarWhenPushed = YES;
    singleVC.title = conversation.conversationId;
    [self.navigationController pushViewController:singleVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
