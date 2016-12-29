//
//  ServiceViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ServiceViewController.h"
#import "TalkingView.h"
//#import <HyphenateLite_CN/EMSDK.h>
#import <TZImagePickerController.h>

@interface ServiceViewController ()<UITextFieldDelegate, EaseMessageViewControllerDelegate>

@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入框 */

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
            NSString *urlString = [IMAGE_HOST stringByAppendingString:[UserInfos sharedUser].userimgurl];
            model.avatarURLPath = urlString;//头像网络地址
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
    
    
    // 隐藏输入框 自定义输入框
    self.chatToolbar.hidden = YES;
//    [self.view addSubview:self.talkView];
//    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.equalTo(self.view);
//        make.height.equalTo(44);
//    }];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
