//
//  ServiceViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ServiceViewController.h"
#import "TalkingView.h"

@interface ServiceViewController ()<UITextFieldDelegate>

@property(nonatomic, strong) TalkingView *talkView; /**< 聊天输入框 */

@end

@implementation ServiceViewController

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
- (void)initUI {
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.text = @"您好，您所发留言将会在主播结束后为您答复";
    alertLabel.textColor = [UIColor colorWithHexString:@"#999999"];
    alertLabel.font = [UIFont systemFontOfSize:12];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alertLabel];
    
    [alertLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).offset(10);
        make.centerX.equalTo(self.view.centerX);
    }];
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark
#pragma mark - 懒加载
- (TalkingView *)talkView {
    if (!_talkView) {
        _talkView = [[TalkingView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        
        self.textField = _talkView.messageTextField;
        __weak typeof(self) weakSelf = self;
        
        
    }
    return _talkView;
}
//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [textField resignFirstResponder];
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290);
//            make.left.equalTo(self.view);
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
//        }];
//    }];
//    
//    return YES;
//}
//- (void)touchTextField:(UITextField *)textField {
//    [textField becomeFirstResponder];
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290- 264);
//            make.left.equalTo(self.view);
//            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
//        }];
//    }];
//}
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
