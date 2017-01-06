//
//  TalkingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TalkingViewController.h"

#import "NoneNetWorkingView.h"
#import "TalkingView.h"
//#import <HyphenateLite_CN/EMSDK.h>
#import "TalkTableViewCell.h"
#import "IMessageModel.h"

@interface TalkingViewController ()<UITextFieldDelegate, EaseMessageViewControllerDelegate, IEMChatroomManager>

//@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入框 */

@end
static NSString *cellid = @"TalkTableViewCell";
@implementation TalkingViewController
//- (void)loadView {
//    self.view.bounds = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//}
#pragma mark
#pragma mark - 自定义cell
// 设置
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarURLPath = @"";
    model.failImageName = @"";
    // 如果来自主播
    if ([model.message.from isEqualToString:_liverid]) {
        model.nickname = @"主播:";
    }else if ([model.message.from isEqualToString:EaseTest_Service]){
        model.nickname = @"客服:";
    }else{
        if (model.isSender) {
            model.nickname = [NSString stringWithFormat:@"%@:", [UserInfos sharedUser].username];
        }else{
            model.nickname = @"游客:";//用户昵称
        }
    }
    
    return model;
}
//具体创建自定义Cell的样例：
- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
{
    //样例为如果消息是文本消息显示用户自定义cell
    if (model.bodyType == EMMessageBodyTypeText) {
        NSString *CellIdentifier = [TalkTableViewCell cellIdentifierWithModel:model];
        //CustomMessageCell为用户自定义cell,继承了EaseBaseMessageCell
        TalkTableViewCell *cell = (TalkTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[TalkTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.model = model;
        return cell;
    }
    return nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self initUI];
    if (self.conversation.type == EMConversationTypeChatRoom) {
        [self joinChatroom:_roomID];
    }
}
- (void)showHudInView:(UIView *)view hint:(NSString *)hint {

}
- (void)showHint:(NSString *)hint {
    
}
- (void)setIshidText:(BOOL)ishidText {
    _ishidText = ishidText;
    self.talkView.hidden = YES;
    self.chatToolbar.hidden = YES;
}
- (void)setIsNotification:(BOOL)isNotification {
    _isNotification = isNotification;
    if (!isNotification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        
    }else{
        [self focusKeyboardShow];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden = YES;
    // 隐藏

    [self.view insertSubview:self.talkView aboveSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
    // 隐藏输入框 自定义输入框
    self.chatToolbar.hidden = YES;
    // 设置代理
    [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
}

// 接受消息回调
- (void)didReceiveMessages:(NSArray *)aMessages {
    for (EMMessage *message in aMessages) {
        if (message.chatType == EMChatTypeChatRoom) { // 只接受群聊消息
            EMMessageBody *msgBody = message.body;
            switch (msgBody.type) {
                case EMMessageBodyTypeText:
                {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                DLog(@"%@", txt);
                [self.dataArray addObject:message];
                [self.tableView reloadData];
                // 刷新
                }
                    break;
                default:
                    break;
            }
        }
    }
}
- (void)initUI {

}
#pragma mark
#pragma mark - chatroom
- (void)saveChatroom:(EMChatroom *)chatroom
{
    NSString *chatroomName = chatroom.subject ? chatroom.subject : @"";
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"OnceJoinedChatrooms_%@", [[EMClient sharedClient] currentUsername]];
    NSMutableDictionary *chatRooms = [NSMutableDictionary dictionaryWithDictionary:[ud objectForKey:key]];
    if (![chatRooms objectForKey:chatroom.chatroomId]) {
        [chatRooms setObject:chatroomName forKey:chatroom.chatroomId];
        [ud setObject:chatRooms forKey:key];
        [ud synchronize];
    }
}

- (void)joinChatroom:(NSString *)chatroomId
{
    __weak typeof(self) weakSelf = self;
//    [self showHudInView:self.view hint:NSEaseLocalizedString(@"chatroom.joining",@"Joining the chatroom")];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        EMChatroom *chatroom = [[EMClient sharedClient].roomManager joinChatroom:chatroomId error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf) {
                EaseMessageViewController *strongSelf = weakSelf;
                [strongSelf hideHud];
                if (error != nil) {
                    [strongSelf showHint:[NSString stringWithFormat:NSEaseLocalizedString(@"chatroom.joinFailed",@"join chatroom \'%@\' failed"), chatroomId]];
                } else {
                    strongSelf.isJoinedChatroom = YES;
                    [self saveChatroom:chatroom];
                }
            }  else {
                if (!error || (error.code == EMErrorChatroomAlreadyJoined)) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        EMError *leaveError;
                        [[EMClient sharedClient].roomManager leaveChatroom:chatroomId error:&leaveError];
                        [[EMClient sharedClient].chatManager deleteConversation:chatroomId isDeleteMessages:YES completion:nil];
                    });
                }
            }
        });
    });
}

#pragma mark
#pragma mark - 懒加载
- (TalkingView *)talkView {
    if (!_talkView) {
        _talkView = [[TalkingView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        
        _talkView.sendBlock = ^(NSString *message){
            [weakSelf sendTextMessage:message];
//            EMTextMessageBody *body = [[EMTextMessageBody alloc] initWithText:message];
//            NSString *from = [[EMClient sharedClient] currentUsername];
//            
//            // 消息拓展
////            NSDictionary *dict = [];
//            //生成Message
//            EMMessage *sendmessage = [[EMMessage alloc] initWithConversationID:weakSelf.roomID from:from to:weakSelf.roomID body:body ext:nil];
//            sendmessage.chatType = EMChatTypeChatRoom;// 设置为聊天室消息
//           // 消息发送
//            [[EMClient sharedClient].chatManager sendMessage:sendmessage progress:nil completion:^(EMMessage *message, EMError *error) {
//            }];
        };
        _talkView.emojiBlock = ^(){
            
        };
        _talkView.textFieldBlock = ^(UITextField *textField){
            weakSelf.textField = textField;
        };
    }
    return _talkView;
}
#pragma mark
#pragma mark - 监听键盘
- (void)focusKeyboardShow {
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom).offset(-h);
            make.left.right.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom);
            make.left.right.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}
- (void)dealloc
{
    if (self.conversation.type == EMConversationTypeChatRoom)
        {
        //退出聊天室，删除会话
        if (self.isJoinedChatroom) {
            NSString *chatter = [self.conversation.conversationId copy];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                EMError *error = nil;
                [[EMClient sharedClient].roomManager leaveChatroom:chatter error:&error];
                if (error !=nil) {
                }
            });
        }
        else {
            [[EMClient sharedClient].chatManager deleteConversation:self.conversation.conversationId isDeleteMessages:YES completion:nil];
        }
        }
    
    [[EMClient sharedClient] removeDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (BOOL)shouldAutorotate {
//}
@end
