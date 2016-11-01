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


@property(nonatomic, strong) UITextField *textField; /**< 输入框 */
@end



@implementation TalkingViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    
    [self initUI];
    DLog(@"%@", NSStringFromCGRect(self.view.frame));
    
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
        
        _talkView.editBlock = ^(UITextField *textField){
            [textField addTarget:weakSelf action:@selector(touchTextField:) forControlEvents:(UIControlEventTouchDown)];
           
            weakSelf.textField = textField;
            textField.delegate = weakSelf;
        };
    }
    return _talkView;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290);
            make.left.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
    
    return YES;
}
- (void)touchTextField:(UITextField *)textField {
    [textField becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        [self.talkView remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.top).offset(SCREEN_HEIGHT - 290- 264);
            make.left.equalTo(self.view);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        }];
    }];
}

@end
