//
//  TalkingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TalkingViewController.h"

#import "TalkingView.h"
#import "NoneNetWorkingView.h"

@interface TalkingViewController ()<UITextFieldDelegate, EMChatroomManagerDelegate>

@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入view */

@property(nonatomic, strong) NoneNetWorkingView *noneNetView; /**< 无网 */

@end

@implementation TalkingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //    [self.view addSubview:self.noneNetView];

    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290);
        make.left.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
    
    // 加入聊天室
    EMError *error = nil;
    [[EMClient sharedClient].roomManager joinChatroom:_roomID completion:^(EMChatroom *aChatroom, EMError *aError) {
        DLog(@"%@", error);
    }];
    //注册聊天室回调
    [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
}

- (void)didReceiveUserJoinedChatroom:(EMChatroom *)aChatroom
                            username:(NSString *)aUsername {
    [self showAlert:[NSString stringWithFormat:@"%@加入了聊天室", aUsername]];
}

- (void)didReceiveUserLeavedChatroom:(EMChatroom *)aChatroom
                            username:(NSString *)aUsername {
    [self showAlert:[NSString stringWithFormat:@"%@离开了聊天室", aUsername]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 离开聊天室
    EMError *error = nil;
    [[EMClient sharedClient].roomManager leaveChatroom:_roomID error:&error];
}
- (void)initUI {
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)makeConstraint {

}
- (void)setIsHidText:(BOOL)isHidText {
    _isHidText = isHidText;
    self.talkView.hidden = isHidText;
}
#pragma mark
#pragma mark - 懒加载
- (NoneNetWorkingView *)noneNetView {
    if (!_noneNetView) {
        _noneNetView = [[NoneNetWorkingView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _noneNetView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];    }
    return _noneNetView;
}
- (TalkingView *)talkView {
    if (!_talkView) {
        _talkView = [[TalkingView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        _talkView.textFieldBlock = ^(UITextField *textField){
            weakSelf.textField = textField;
        };
    }
    return _talkView;
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290 - h);
            make.left.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290);
            make.left.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}

@end
