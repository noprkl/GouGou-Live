
//
//  LivingChatroomVcViewController.m
//  GouGou-Live
//
//  Created by ma c on 17/1/2.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import "LivingChatroomVcViewController.h"
#import "LivingChatroomCell.h"
#import "TalkingView.h" // 消息输入框

@interface LivingChatroomVcViewController ()<UITableViewDelegate, UITableViewDataSource, EMChatroomManagerDelegate, EaseMessageViewControllerDelegate>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property (nonatomic, strong) LivingChatroomCell *cellTool; /**< 高度 */

@property (nonatomic, strong) TalkingView *talkView; /**< 消息输入 */

@property (nonatomic, strong) EMConversation *conversation; /**< 聊天会话 */

@end

static NSString *cellid = @"LivingChatroomCell";

@implementation LivingChatroomVcViewController
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
    [[EMClient sharedClient].roomManager addDelegate:self delegateQueue:nil];
}
#pragma mark
#pragma mark - 消息
- (void)sendMessage:(NSString *)text {

    
}
#pragma mark
#pragma mark - 懒加载
- (TalkingView *)talkView {
    if (!_talkView) {
        _talkView = [[TalkingView alloc] init];
        _talkView.backgroundColor = [UIColor whiteColor];
        
        __weak typeof(self) weakSelf = self;
        
        _talkView.sendBlock = ^(NSString *message){
            [weakSelf sendMessage:message];
        };
        _talkView.emojiBlock = ^(){
            
        };
    }
    return _talkView;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[LivingChatroomCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LivingChatroomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.message = self.dataArr[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cellTool.message = self.dataArr[indexPath.row];
    
    return [self.cellTool getCellHeight];
}

@end