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
#import "PersonalMessageModel.h"
#import "FocusAndFansModel.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource, EaseConversationListViewControllerDataSource, EaseConversationListViewControllerDelegate, IEMChatManager>

@property(nonatomic, strong) NSMutableArray *arrConversion; /**< 所有会话数据 */
@property(nonatomic, strong) NSMutableDictionary *arrConversionDict; /**< 所有会话头像字典 */
@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSArray *systemMessageArr; /**< 系统信息 */

@property (nonatomic, assign) NSInteger unread; /**< 未读 */

@end

static NSString *cellid1 = @"MessageListCell";
static NSString *cellid2 = @"NotificationMessageCell";

@implementation MessageViewController

// 关注的人
- (void)postRequestGetFocus {
    if (![UserInfos getUser]) {
        [UserInfos sharedUser].ID = @"";
    }
    NSDictionary *dict = @{@"user_id":[UserInfos sharedUser].ID
                           };
    [self getRequestWithPath:API_Fan_Information params:dict success:^(id successJson) {
        if ([successJson[@"code"] isEqualToString:@"1"]) {
            // 得到关注人的人
            NSArray *focusArr = [FocusAndFansModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
            NSString *filePath = [NSString cachePathWithfileName:Focus];
            NSMutableArray *arr = [NSMutableArray array];
            for (FocusAndFansModel *model in focusArr) {
                [arr addObject:@(model.userFanId)];
            }
            [arr writeToFile:filePath atomically:YES];
            [self.tableView reloadData];
        }
        
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

// 获得系统通知消息
- (void)postRequestGetSystemPush {
    // ([[UserInfos sharedUser].ID integerValue])
    if ([UserInfos getUser]) {
        NSDictionary *dict = @{@"user_id":[UserInfos sharedUser].ID};
        [self getRequestWithPath:API_System_msg params:dict success:^(id successJson) {
            self.systemMessageArr = @[];
//            DLog(@"%@", successJson);
            if ([successJson[@"code"] isEqualToString:@"1"]) {
                self.systemMessageArr = [SystemPushMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
               // 未读消息
                NSInteger uncount = 0;
                for (NSInteger i = 0; i < self.systemMessageArr.count; i++) {
                    SystemPushMessageModel *model = self.systemMessageArr[i];
                    if ([model.status integerValue] == 0) {
                        uncount ++;
                    }
                }
                self.unread = uncount;
                [self.tableView reloadData];
            }else{
                self.unread = 0;
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
    }
}
#pragma mark
#pragma mark - 获取会话
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 获取系统消息

    [self postRequestGetSystemPush];
    [self postRequestGetFocus];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage3"] forBarMetrics:(UIBarMetricsDefault)];

    NSArray *arr = [[[EMClient sharedClient].chatManager getAllConversations] mutableCopy];
    [self.arrConversion removeAllObjects];
    [self.arrConversionDict removeAllObjects];
    // 只要单聊对话
    for (EMConversation *conversation in arr) {
        if (conversation.type == EMConversationTypeChat && ![conversation.conversationId isEqualToString:EaseTest_Liver] && ![conversation.conversationId isEqualToString:EaseTest_Service] && conversation.latestMessage) {
            
            [self.arrConversion addObject:conversation];
            DLog(@"id-------%@", conversation.conversationId);
            [self getConversationIconsWithId:conversation.conversationId];
        }
    }
}
// 根据对话id请求对话人的昵称头像
- (void)getConversationIconsWithId:(NSString *)conversationid {
    NSDictionary *dict = @{
                           @"id":conversationid
                           };
    DLog(@"%@", dict);
        [self getRequestWithPath:API_Personal params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            if ([successJson[@"code"] isEqualToString:@"1"]) {
                NSArray *arr = [PersonalMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
                PersonalMessageModel *model = [arr lastObject];
                [self.arrConversionDict setObject:model forKey:conversationid];
            }else{
                PersonalMessageModel *model = [[PersonalMessageModel alloc] init];
                [self.arrConversionDict setObject:model forKey:conversationid];
            }

            if (self.arrConversionDict.count == self.arrConversion.count) {
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
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
        [self postRequestGetFocus];
        [self postRequestGetSystemPush];

        NSArray *arr = [[[EMClient sharedClient].chatManager getAllConversations] mutableCopy];
        [self.arrConversion removeAllObjects];
        [self.arrConversionDict removeAllObjects];

        // 只要单聊对话
        for (EMConversation *conversation in arr) {
            if (conversation.type == EMConversationTypeChat && ![conversation.conversationId isEqualToString:EaseTest_Liver] && ![conversation.conversationId isEqualToString:EaseTest_Service] && conversation.latestMessage) {
                [self.arrConversion addObject:conversation];
                [self getConversationIconsWithId:conversation.conversationId];
            }
        }
    }];
    // 进入立即刷新
//    [self.tableView.mj_header beginRefreshing];
}

#pragma mark
#pragma mark - 懒加载
- (NSArray *)systemMessageArr {
    if (!_systemMessageArr) {
        _systemMessageArr = [NSArray array];
    }
    return _systemMessageArr;
}
- (NSMutableArray *)arrConversion {
    if (!_arrConversion) {
        _arrConversion = [NSMutableArray array];
    }
    return _arrConversion;
}
- (NSMutableDictionary *)arrConversionDict {
    if (!_arrConversionDict) {
        _arrConversionDict = [NSMutableDictionary dictionary];
    }
    return _arrConversionDict;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
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
       
        notifiCell.model = [self.systemMessageArr firstObject];
        notifiCell.unReadCount = self.unread;
        return notifiCell;
    }
    if (indexPath.section == 1) {
        MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid1];
        
        EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
        
        if (conversation.type == EMConversationTypeChat) {
            
            // 关注
            NSString *filename = [NSString cachePathWithfileName:Focus];
            NSArray *focusArr = [NSArray arrayWithContentsOfFile:filename];
            NSInteger focusID = [conversation.conversationId integerValue];
            
            if ([focusArr containsObject:@(focusID)]) {
                cell.isFocus.text = @"已关注";
                cell.isFocus.textColor = [UIColor colorWithHexString:@"#99cc33"];
            }else{
                cell.isFocus.text = @"未关注";
                cell.isFocus.textColor = [UIColor colorWithHexString:@"#666666"];
                
            }
            
            if (self.arrConversionDict.count != 0) {
                PersonalMessageModel *model = [self.arrConversionDict valueForKey:conversation.conversationId];

                if (model.userName.length != 0) {
                    cell.nickNameLabel.text = model.userName;
                    if (model.userImgUrl.length != 0) {
                        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.userImgUrl];
                        [cell.iconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];//头像网络地址
                    }
                }else if ([conversation.conversationId isEqualToString:@"admin"]){
                    cell.nickNameLabel.text = @"环信后台";
                    cell.iconView.image = [UIImage imageNamed:@"LOGO"];
                }
            }
            
            if (conversation.latestMessage) {
                
                cell.lastMessageLabel.text = [self _latestMessageTitleForConversation:conversation];
                cell.lastTimeLabel.text = [self _latestMessageTimeForConversation:conversation];
                                
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
    return 80;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
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
        
//        UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
//        label3.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
//        [view addSubview:label3];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, SCREEN_WIDTH, 42)];
        label.text = @"最近联系";
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        [view addSubview:label];
       
//        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
//        label2.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
//        [view addSubview:label2];
        
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
        [self.navigationController pushViewController:systemVC animated:YES];
    }
    if (indexPath.section == 1) {
        EMConversation *conversation = [self.arrConversion objectAtIndex:indexPath.row];
        
        SingleChatViewController *singleVC = [[SingleChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:(EMConversationTypeChat)];
        if (self.arrConversionDict.count != 0) {
            PersonalMessageModel *model = [self.arrConversionDict valueForKey:conversation.conversationId];
            if (model.userName.length != 0) {
                singleVC.title = model.userName;
                singleVC.iconUrl = model.userImgUrl;
                singleVC.nameStr = model.userName;

            }else if ([conversation.conversationId isEqualToString:@"admin"]){
                singleVC.title = @"环信后台";
                singleVC.nameStr = @"环信后台";
            }
        }
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
                NSArray *arr = [[[EMClient sharedClient].chatManager getAllConversations] mutableCopy];
                [self.arrConversion removeAllObjects];
                // 只要单聊对话
                for (EMConversation *conversation in arr) {
                    if (conversation.type == EMConversationTypeChat) {
                        [self.arrConversion addObject:conversation];
                    }
                }
                [self.tableView reloadData];

            }];
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除后不可恢复";
}
@end
