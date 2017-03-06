//
//  SingleChatViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define EmojiHeight 240

#import "SingleChatViewController.h"
#import "MessageInputView.h" // 输入框
#import "MessageMeumView.h" // 菜单

#import <TZImagePickerController.h>
#import "HttpTool.h"
#import "EMClient.h"

#import "PersonalPageController.h" // 个人主页
#import "PersonalMessageModel.h"
#import "TSEmojiView.h"

@interface SingleChatViewController ()<EaseMessageViewControllerDelegate, TZImagePickerControllerDelegate, EMContactManagerDelegate, EaseMessageViewControllerDataSource, TSEmojiViewDelegate>

@property(nonatomic, strong) MessageInputView *talkView; /**< 输入框 */

@property(nonatomic, strong) MessageMeumView *menuView; /**< 菜单 */

//@property (nonatomic, strong) PersonalMessageModel *personalModel; /**< 个人信息 */

@property (nonatomic, strong) TSEmojiView *emojiView; /**< 表情键盘 */

@end

@implementation SingleChatViewController
- (void)getrequestPersonalMessage {
    NSDictionary *dict = @{
                           @"id":@([_chatID intValue])
                           };
    [HTTPTool getRequestWithPath:@"http://gougou.itnuc.com/api/UserService/personal" params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [PersonalMessageModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
//        self.personalModel = [arr lastObject];
//        if (self.personalModel.userName != NULL) {
//            self.title = self.personalModel.userName;
//        }else{
//            self.title = _chatID;
//        }
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
//#pragma mark
//#pragma mark - 自定义cell
// 头像
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
       //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];
    model.avatarImage = [UIImage imageNamed:@"头像"];//默认头像
    
    if (model.isSender) {
        if ([UserInfos getUser]) {
            NSString *urlString = [IMAGE_HOST stringByAppendingString:[UserInfos sharedUser].userimgurl];
            model.avatarURLPath = urlString;//头像网络地址
        }
         model.nickname = [UserInfos sharedUser].usernickname;//用户昵称
    }else{
        if (self.iconUrl) {
            NSString *urlString = [IMAGE_HOST stringByAppendingString:self.iconUrl];
            model.avatarURLPath = urlString;//头像网络地址
        }
        model.nickname = self.nameStr;//用户昵称
    }
    
    return model;
}
//生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavBarItem];

    //@property中带有UI_APPEARANCE_SELECTOR，都可以通过set的形式设置样式，具体可以参考EaseBaseMessageCell.h,EaseMessageCell.h
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"圆角矩形-1"] stretchableImageWithLeftCapWidth:5 topCapHeight:30]];//设置发送气泡
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_receiver_bg"] stretchableImageWithLeftCapWidth:30 topCapHeight:30]];//设置接收气泡
    
    [[EaseBaseMessageCell appearance] setAvatarSize:44.f];//设置头像大小

    self.dataSource = self;
    self.title = self.nameStr;
    // 隐藏输入框 自定义输入框
    self.chatToolbar.hidden = YES;
    [self.view addSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
    // 添加键盘
    _emojiView = [[TSEmojiView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, EmojiHeight)];
    _emojiView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    _emojiView.delegate = self;
    [self.view addSubview:_emojiView];
    
    // 上下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 重新获取数据
        
        [self.tableView.mj_header endRefreshing];
    }];
    // 进入立即刷新
    [self.tableView.mj_header beginRefreshing];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.menuView.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 监听键盘
    [self focusKeyboardShow];
}
#pragma mark
#pragma mark - 自定义输入框
- (MessageInputView *)talkView {
    if (!_talkView) {
        _talkView = [[MessageInputView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _talkView.cameraBlock = ^(){
        
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:weakSelf];
            imagePickerVc.sortAscendingByModificationDate = NO;
            imagePickerVc.isSelectOriginalPhoto = YES;
            imagePickerVc.allowPickingOriginalPhoto = NO;

            [weakSelf presentViewController:imagePickerVc animated:YES completion:nil];
            
            [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL flag) {
                if (flag) {
                    UIImage *image = [photos lastObject];
                    [weakSelf sendImageMessage:image];
                }else{
                    DLog(@"出错了");
                }
            }];
            
        };
        _talkView.sendBlock = ^(NSString *message){
           
            if (message.length != 0) {
                [weakSelf sendTextMessage:message];
                [weakSelf.emojiView remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(weakSelf.view);
                    make.top.equalTo(weakSelf.view.bottom);
                    make.width.equalTo(SCREEN_WIDTH);
                    make.height.equalTo(EmojiHeight);
                }];
                [weakSelf.talkView remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.bottom.right.equalTo(weakSelf.view);
                    make.height.equalTo(44);
                }];
                [weakSelf.tableView remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.top.right.equalTo(weakSelf.view);
                    make.bottom.equalTo(weakSelf.view).offset(-44);
                }];
            }
        };
        
        _talkView.emojiBlock = ^(){
            [weakSelf.talkView.messageTextField resignFirstResponder];
            [weakSelf.emojiView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view.bottom);
                make.width.equalTo(SCREEN_WIDTH);
                make.height.equalTo(EmojiHeight);
            }];
            [weakSelf.talkView remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view.bottom).offset(-EmojiHeight);
                make.height.equalTo(44);
            }];
            
            [weakSelf.tableView remakeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(weakSelf.view);
                make.bottom.equalTo(weakSelf.view.bottom).offset(-EmojiHeight-44);
            }];
        };
    }
    return _talkView;
}
- (void)scrollViewToBottom:(BOOL)animated
{
    if (self.tableView.contentSize.height > self.tableView.frame.size.height)
    {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height);
        [self.tableView setContentOffset:offset animated:animated];
    }
}
- (void)didTouchEmojiView:(TSEmojiView*)emojiView touchedEmoji:(NSString*)str
{
    
    self.talkView.messageTextField.text = [NSString stringWithFormat:@"%@%@", self.talkView.messageTextField.text, str];
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
        
        CGFloat height = 270;
        [self.emojiView remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.bottom);
            make.width.equalTo(SCREEN_WIDTH);
            make.height.equalTo(height);
        }];

    }];
}

#pragma mark
#pragma mark - 设置导航栏
- (void)setNavBarItem {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
    // 关注栏
    UIButton *rightBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [rightBtn sizeToFit];
    [rightBtn setImage:[UIImage imageNamed:@"菜单未点击"] forState:(UIControlStateNormal)];
    [rightBtn setImage:[UIImage imageNamed:@"菜单"] forState:(UIControlStateSelected)];
    
    [rightBtn addTarget:self action:@selector(showRightBarItem:) forControlEvents:(UIControlEventTouchDown)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    [window addSubview:self.menuView];
}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
// 右侧弹窗
- (void)showRightBarItem:(UIButton *)btn {
    btn.selected = !btn.selected;
    _menuView.hidden = !btn.selected;
}
- (MessageMeumView *)menuView {
    if (!_menuView) {
        _menuView = [[MessageMeumView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 130, 64, 130, 176) style:(UITableViewStylePlain)];
        _menuView.hidden = YES;
        EMError *error = nil;
        NSArray *blackArr = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];
       
        // 关注
        NSString *filename = [NSString cachePathWithfileName:Focus];
        NSArray *focusArr = [NSArray arrayWithContentsOfFile:filename];
        NSInteger chatID = [_chatID integerValue];
        
        // 如果已经屏蔽 已经关注
        if ([blackArr containsObject:_chatID] && [focusArr containsObject:@(chatID)]) {
            _menuView.dataPlist = @[@"已关注", @"已屏蔽", @"举报", @"个人主页"];
        }else if ([blackArr containsObject:_chatID] && ![focusArr containsObject:@(chatID)]) {
            _menuView.dataPlist = @[@"关注", @"已屏蔽", @"举报", @"个人主页"];
        }else if (![blackArr containsObject:_chatID] && [focusArr containsObject:@(chatID)]) {
            _menuView.dataPlist = @[@"已关注", @"屏蔽", @"举报", @"个人主页"];
        }else if (![blackArr containsObject:_chatID] && ![focusArr containsObject:@(chatID)]) {
            _menuView.dataPlist = @[@"关注", @"屏蔽", @"举报", @"个人主页"];
        }
        
        __weak typeof(self) weakSelf = self;
        _menuView.cellBlock = ^(NSString *cellText){
            [weakSelf clickMenuActionWithText:cellText];
        };
    }
    return _menuView;
}

- (void)clickMenuActionWithText:(NSString *)text {
    if ([text isEqualToString:@"关注"]) {
        NSDictionary *dict = @{
                               @"user_id":@([[UserInfos sharedUser].ID intValue]),
                               @"id":@([_chatID intValue]),
                               @"type":@(0)
                               };

        [HTTPTool getRequestWithPath:@"http://gougou.itnuc.com/api/UserService/add_fan" params:dict success:^(id successJson) {
            DLog(@"%@", successJson);
            [self showHint:successJson[@"message"]];
            if ([successJson[@"message"] isEqualToString:@"关注成功"]) {
                [self showHint:successJson[@"message"]];
                _menuView.dataPlist = @[@"已关注", @"屏蔽", @"举报", @"个人主页"];
                [self.menuView reloadData];
            }
        } error:^(NSError *error) {
            DLog(@"%@", error);
        }];
        
        }
        if ([text isEqualToString:@"已关注"]) {
            NSDictionary *dict = @{
                                   @"user_id":@([[UserInfos sharedUser].ID intValue]),
                                   @"id":@([_chatID intValue]),
                                   @"type":@(1)
                                   };
            
            [HTTPTool getRequestWithPath:@"http://gougou.itnuc.com/api/UserService/add_fan" params:dict success:^(id successJson) {
                DLog(@"%@", successJson);
                    [self showHint:successJson[@"message"]];
                    _menuView.dataPlist = @[@"关注", @"屏蔽", @"举报", @"个人主页"];
                    [self.menuView reloadData];
            } error:^(NSError *error) {
                DLog(@"%@", error);
            }];
    }
    if ([text isEqualToString:@"屏蔽"]){
        EMError *error = nil;
        NSArray *blackArr = [[EMClient sharedClient].contactManager getBlackListFromServerWithError:&error];

        // 如果已经屏蔽
        if ([blackArr containsObject:_chatID]) {
            // 移除和名单
            EMError *error = [[EMClient sharedClient].contactManager removeUserFromBlackList:_chatID];
            if (!error) {
                [self showHint:@"已经解除屏蔽"];
            }
        }else{
            // 加入黑名单
            EMError *error = [[EMClient sharedClient].contactManager addUserToBlackList:_chatID relationshipBoth:YES];
            if (!error) {
                   [self showHint:@"已经屏蔽"];
            }
        }
    }else if ([text isEqualToString:@"举报"]){
        NSDictionary * dict = @{
                                @"id":self.chatID,
                                @"user_id":[UserInfos sharedUser].ID
                                };
        [HTTPTool getRequestWithPath:@"http://gougou.itnuc.com/api/UserService/report"  params:dict success:^(id successJson) {
            DLog(@"%@",successJson);
            [self showHint:successJson[@"message"]];
        } error:^(NSError *error) {
            DLog(@"%@",error);
            
        }];
    }else if ([text isEqualToString:@"个人主页"]){
        PersonalPageController *personalVc = [[PersonalPageController alloc] init];
        personalVc.hidesBottomBarWhenPushed = YES;
        personalVc.personalID = [_chatID intValue];
        [self.navigationController pushViewController:personalVc animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
