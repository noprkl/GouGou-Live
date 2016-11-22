//
//  MessageViewController.m
//  狗狗直播框架
//
//  Created by ma c on 16/10/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "NotificationMessageCell.h"
#import "TalkingToOneViewController.h" 
#import <HyphenateLite_CN/EMSDK.h>
#import "EaseMessageViewController.h"

@interface MessageViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) MessageCell *headerView; /**< header */

@end

static NSString *cellid = @"MessageCell";
static NSString *cellid2 = @"NotificationMessageCell";

@implementation MessageViewController
#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (MessageCell *)headerView {
    if (!_headerView) {
        _headerView = [[MessageCell alloc] init];
        _headerView.focusHide = YES;

    }
    return _headerView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerNib:[UINib nibWithNibName:@"MessageCell" bundle:nil] forCellReuseIdentifier:cellid];
        [_tableView registerNib:[UINib nibWithNibName:@"NotificationMessageCell" bundle:nil] forCellReuseIdentifier:cellid2];

    }
    return _tableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 1;
    }
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NotificationMessageCell *notifiCell = [tableView dequeueReusableCellWithIdentifier:cellid2];
        
        return notifiCell;
    }
    if (indexPath.section == 1) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];

        cell.countHide = (indexPath.row % 3 == 0) ? YES:NO;
        cell.isFocus = (indexPath.row % 2 == 0) ? YES:NO;
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 75;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 1) {
        return 44;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH, 43)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"最近联系";
        label.font = [UIFont systemFontOfSize:16];
        [view addSubview:label];
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        label.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        [view addSubview:label2];
        
        return view;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
    TalkingToOneViewController *talkVc = [[TalkingToOneViewController alloc] init];
    talkVc.title = [NSString stringWithFormat:@"聊天%ld", indexPath.row];
    if (indexPath.section == 0) {
        talkVc.title = @"系统通知";
    }
    talkVc.hidesBottomBarWhenPushed = YES;
   
    [[EMClient sharedClient] loginWithUsername:talkVc.title
                                      password:@"8001"
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登陆成功");
                                        } else {
                                            NSLog(@"登陆失败");
                                        }
                                    }];
    
    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"8001" conversationType:EMConversationTypeChat];
    
    
    [self.navigationController pushViewController:chatController animated:YES];
}

@end
