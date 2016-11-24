//
//  SingleChatViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SingleChatViewController.h"
#import "MessageInputView.h" // 输入框
#import "MessageMeumView.h" // 菜单

#import <TZImagePickerController.h>

@interface SingleChatViewController ()<EaseMessageViewControllerDelegate, TZImagePickerControllerDelegate>

@property(nonatomic, strong) MessageInputView *talkView; /**< 输入框 */

@property(nonatomic, strong) MessageMeumView *menuView; /**< 菜单 */

@end

@implementation SingleChatViewController
//#pragma mark
//#pragma mark - 自定义cell

//生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setNavBarItem];

    //@property中带有UI_APPEARANCE_SELECTOR，都可以通过set的形式设置样式，具体可以参考EaseBaseMessageCell.h,EaseMessageCell.h
    
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"圆角矩形-1"] stretchableImageWithLeftCapWidth:5 topCapHeight:30]];//设置发送气泡
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_receiver_bg"] stretchableImageWithLeftCapWidth:30 topCapHeight:30]];//设置接收气泡
    
    [[EaseBaseMessageCell appearance] setAvatarSize:44.f];//设置头像大小
//    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:20.f];//设置头像圆角
    
    
    // 隐藏输入框 自定义输入框
    self.chatToolbar.hidden = YES;
    [self.view addSubview:self.talkView];
    [self.talkView makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
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
            [weakSelf sendTextMessage:message];
        };
        _talkView.emojiBlock = ^(){
        
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
        _menuView.cellBlock = ^(NSString *cellText){
            DLog(@"%@", cellText);
        };
    }
    return _menuView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
