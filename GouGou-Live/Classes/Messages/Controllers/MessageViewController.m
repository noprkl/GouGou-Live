//
//  MessageViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageListCell.h"
#import "NotificationMessageCell.h"

#import "SingleChatViewController.h" // 聊天对话

#import "SystemNotificationViewController.h"
#import "SystemPushMessageModel.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource, EaseConversationListViewControllerDataSource, EaseConversationListViewControllerDelegate, IEMChatManager>

@property(nonatomic, strong) NSMutableArray *arrConversion; /**< 所有会话数据 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *systemMessageArr; /**< 系统信息 */

@end

static NSString *cellid1 = @"MessageListCell";
static NSString *cellid2 = @"NotificationMessageCell";

@implementation MessageViewController

- (void)postRequestGetSystemPush {
    // ([[UserInfos sharedUser].ID integerValue])
    NSDictionary *dict = @{@"user_id":@(11)};
    [self getRequestWithPath:API_System_msg params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        if ([successJson[@"code"] isEqualToString:@"1"]) {
            self.systemMessageArr = [SystemPushMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            [self.tableView reloadData];
        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
#pragma mark
#pragma mark - 获取会话
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];

    self.arrConversion = [[[EMClient sharedClient].chatManager getAllConversations] mutableCopy];
    [self postRequestGetSystemPush];

    [self.tableView reloadData];
}

#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    self.edgesForExtendedLayout = 0;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self.view addSubview:self.tableView];
    
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.left.right.equalTo(self.view);
//        make.height.equalTo(130);
    }];

    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 重新获取数据
        self.arrConversion = [[[EMClient sharedClient].chatManager getAllConversations] mutableCopy];
        [self.tableView.mj_header endRefreshing];
    }];
    // 进入立即刷新
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)systemMessageArr {
    if (!_systemMessageArr) {
        _systemMessageArr = [NSArray array];
    }
    return _systemMessageArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        [_tableView registerNib:[UINib nibWithNibName:@"NotificationMessageCell" bundle:nil] forCellReuseIdentifier:cellid2];
        [_tableView registerNib:[UINib nibWithNibName:@"MessageListCell" bundle:nil] forCellReuseIdentifier:cellid1];

    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.arrConversion.count;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NotificationMessageCell *notifiCell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        notifiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        notifiCell.model = [self.systemMessageArr lastObject];
        notifiCell.unReadCount = self.systemMessageArr.count;
        return notifiCell;
    }
    if (indexPath.section == 1) {
        MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        
        EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
        
        if (conversation.type == EMConversationTypeChat) {
            if (conversation.latestMessage) {
                
                // 昵称
                if (conversation.latestMessage.ext[@"nickname"]) {
                    cell.nickNameLabel.text = conversation.latestMessage.ext[@"nickname"];
                }else{
                    cell.nickNameLabel.text = conversation.conversationId;
                }

                // 头像
                if (conversation.latestMessage.ext[@"avatarURL"]) {
                    NSString *urlString = [IMAGE_HOST stringByAppendingString:[UserInfos sharedUser].userimgurl];
                    [cell.iconView sd_setImageWithURL:[NSURL URLWithString:urlString]placeholderImage:[UIImage imageNamed:@"头像"]];
                }else{
                    cell.iconView.image = [UIImage imageNamed:@"头像"];
                }
                
                cell.lastMessageLabel.text = [self _latestMessageTitleForConversation:conversation];
                cell.lastTimeLabel.text = [self _latestMessageTimeForConversation:conversation];
                
                cell.isFocus.selected = YES;
                
                if (conversation.unreadMessagesCount == 0) {
                    cell.unreadCountLabel.hidden = YES;
                }else{
                    cell.unreadCountLabel.text = [@([conversation unreadMessagesCount]) stringValue];
                }
                
            }
        }
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 75;
    }
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        
        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        label3.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [view addSubview:label3];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, SCREEN_WIDTH, 42)];
        label.text = @"最近联系";
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [view addSubview:label];
       
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        label2.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [view addSubview:label2];
        
        return view;
    }
    return nil;
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

// 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        SystemNotificationViewController *systemVC = [[SystemNotificationViewController alloc] init];
        systemVC.hidesBottomBarWhenPushed = YES;
        systemVC.models = self.systemMessageArr;
        [self.navigationController pushViewController:systemVC animated:YES];
    }
    if (indexPath.section == 1) {
        EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
        
        SingleChatViewController *singleVC = [[SingleChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:(EMConversationTypeChat)];
        singleVC.chatID = conversation.conversationId;
        singleVC.hidesBottomBarWhenPushed = YES;
        singleVC.title = conversation.conversationId;
        [self.navigationController pushViewController:singleVC animated:YES];
    }
}
// 侧滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellEditingStyleDelete) {
      
        if (indexPath.section == 1) {
            EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
            
            [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId isDeleteMessages:NO completion:^(NSString *aConversationId, EMError *aError) {
                // 刷新
                [self.tableView reloadData];
            }];
        }
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除后不可恢复";
}
@end
