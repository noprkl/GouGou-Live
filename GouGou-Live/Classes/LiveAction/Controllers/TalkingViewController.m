//
//  TalkingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "TalkingViewController.h"

#import "TalkingView.h"

@interface TalkingViewController ()<UITextFieldDelegate>


@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入view */



@end



@implementation TalkingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    [self initUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationBarHidden = YES;
    [self.view addSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290);
        make.left.equalTo(self.view);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
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

#pragma mark
#pragma mark - 懒加载

- (TalkingView *)talkView {
    if (!_talkView) {
        _talkView = [[TalkingView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        
        self.textField = _talkView.messageTextField;
    }
    return _talkView;
}

- (void)keyboardWasShown:(NSNotification*)aNotification

{
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


-(void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290);
            make.left.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}

@end
