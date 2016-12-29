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

@interface TalkingViewController ()<UITextFieldDelegate, EaseMessageViewControllerDelegate>

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
    }else if ([model.message.from isEqualToString:EaseTest_Chat1]){
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
//- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)messageModel {
//    TalkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
//    cell.OwnerLabel.text = messageModel.nickname;
//   
//    // 聊天内容
//    EMMessage *message = messageModel.message;
//    EMMessageBody *msgBody = message.body;
//    EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
//    NSString *txt = textBody.text;
//    cell.contentLabel.text = txt;
////    cell.contentLabel.text = messageModel.message.
////    cell.contentLabel.text = messageModel.m;
//    
//    return cell;
//}
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
//    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-290);
    self.tableView.frame = self.view.bounds;
//    [self.tableView registerNib:[UINib nibWithNibName:cellid bundle:nil] forCellReuseIdentifier:cellid];

    [self initUI];
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
        //注册键盘出现的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
         
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification object:nil];
        
        //注册键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    // 隐藏

    [self.view insertSubview:self.talkView aboveSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(44);
    }];

    // 提前
//    [self.view bringSubviewToFront:self.talkView];
    

//    @property中带有UI_APPEARANCE_SELECTOR，都可以通过set的形式设置样式，具体可以参考EaseBaseMessageCell.h,EaseMessageCell.h
//
//    //设置发送气泡
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[UIImage imageNamed:@""]] ;
//
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@""] stretchableImageWithLeftCapWidth:30 topCapHeight:30]];//设置接收气泡
////
//    [[EaseBaseMessageCell appearance] setAvatarSize:0];//设置头像大小
//    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:0];//设置头像圆角
    
    
    // 隐藏输入框 自定义输入框
    self.chatToolbar.hidden = YES;
    //    [self.view addSubview:self.talkView];
    //    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.bottom.right.equalTo(self.view);
    //        make.height.equalTo(44);
    //    }];
    // 加入聊天室
    EMError *error = nil;
    [[EMClient sharedClient].roomManager joinChatroom:_roomID error:&error];
    //注册消息回调
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 退出聊天室
    EMError *error = nil;
    [[EMClient sharedClient].roomManager leaveChatroom:_roomID error:&error];
    //移除消息回调
    [[EMClient sharedClient].chatManager removeDelegate:self];
}
// 接受消息回调
- (void)didReceiveMessages:(NSArray *)aMessages {
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
            // 收到的文字消息
            EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
            NSString *txt = textBody.text;
            DLog(@"%@", txt);
            [self.dataArray addObject:txt];
            [self.tableView reloadData];
            // 刷新
//            NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:(self.dataArray.count - 1)];
            
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationBottom)];
            }
                break;
            default:
                break;
        }
    }
}
- (void)initUI {
    
    [self focusKeyboardShow];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
