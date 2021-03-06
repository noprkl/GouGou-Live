//
//  ServiceViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//
#define EmojiHeight 240

#import "ServiceViewController.h"
#import "TalkingView.h"
//#import <HyphenateLite_CN/EMSDK.h>
#import <TZImagePickerController.h>
#import "TSEmojiView.h"

// 表情
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

@interface ServiceViewController ()<UITextFieldDelegate, EaseMessageViewControllerDelegate, EaseMessageViewControllerDataSource, TSEmojiViewDelegate>

@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入框 */

@property (nonatomic, strong) TSEmojiView *emojiView; /**< 表情键盘 */

@end

@implementation ServiceViewController
#pragma mark
#pragma mark - 自定义cell
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
            if ([UserInfos sharedUser].userimgurl.length != 0) {
                NSString *urlString = [IMAGE_HOST stringByAppendingString:[UserInfos sharedUser].userimgurl];
                model.avatarURLPath = urlString;//头像网络地址
            }
            model.nickname = [UserInfos sharedUser].usernickname;//用户昵称
        }else{
           model.nickname = @"ME";//用户昵称
        }
    }else{
        if (_liverImgUrl.length != 0) {
            NSString *urlString = [IMAGE_HOST stringByAppendingString:_liverImgUrl];
            model.avatarURLPath = urlString;//头像网络地址
        }
            model.nickname = _liverName;//用户昵称
    }
    
    return model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    self.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290);

    [self initUI];
    // 如果已经登录，登录环信
    if ([UserInfos getUser]) {
        [self loginHuanXin];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
    [self.view addSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    
    //@property中带有UI_APPEARANCE_SELECTOR，都可以通过set的形式设置样式，具体可以参考EaseBaseMessageCell.h,EaseMessageCell.h
    [[EMClient sharedClient].chatManager getConversation:@"liver" type:EMConversationTypeChat createIfNotExist:YES];

    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"圆角矩形-1"] stretchableImageWithLeftCapWidth:5 topCapHeight:30]];//设置发送气泡
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_receiver_bg"] stretchableImageWithLeftCapWidth:30 topCapHeight:30]];//设置接收气泡
    
    [[EaseBaseMessageCell appearance] setAvatarSize:44.f];//设置头像大小
    //    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];//设置头像圆角
    self.dataSource = self;
   
    // 添加键盘
    _emojiView = [[TSEmojiView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, EmojiHeight)];
    _emojiView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    _emojiView.delegate = self;
    [self.view addSubview:_emojiView];

    // 隐藏输入框 自定义输入框
    self.chatToolbar.hidden = YES;
}
- (void)initUI {
    
    [self focusKeyboardShow];
}
- (void)loginHuanXin {
    // 环信登录
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:[UserInfos sharedUser].ID password:@"gougoulive"];
        if (!error) {
            NSLog(@"登陆成功");
        } else {
            NSLog(@"登陆失败");
        }
    }
}
#pragma mark
#pragma mark - 懒加载
- (TalkingView *)talkView {
    if (!_talkView) {
        _talkView = [[TalkingView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        
        _talkView.sendBlock = ^(NSString *message){
            if (message.length != 0) {
                [weakSelf.talkView.messageTextField resignFirstResponder];
                if ([UserInfos getUser]) {
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

                }else{
                    [weakSelf showHint:@"您还未登录"];
                }
            }else{
                [weakSelf showHint:@"请输入消息内容"];
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
        _talkView.textFieldBlock = ^(UITextField *textField){
            weakSelf.textField = textField;
        };
    }
    return _talkView;
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
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (section == 0) {
        UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 20)];
        alertLabel.text = @"您好，您所发留言将会在主播结束后为您答复";
        alertLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        alertLabel.font = [UIFont systemFontOfSize:12];
        alertLabel.textAlignment = NSTextAlignmentCenter;
        
        return alertLabel;
    }
    return nil;
}

// 表情
- (NSArray *)defaultEmoticons {
    NSMutableArray *array = [NSMutableArray new];
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emoT];
        }
    }
    return array;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
