//
//  MessageListViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageListViewController.h"
#import "EaseConversationListViewController.h"
#import "NotificationMessageCell.h"
#import "SystemNotificationViewController.h" // 系统通知

@interface MessageListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *notificatTableView; /**< TableView */

@end
static NSString *cellid = @"NotificationMessageCell";

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarItem];
    
    [self initUI];
}
- (void)initUI {

#pragma mark - 通知消息
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.notificatTableView];

#pragma mark - 会话列表
    EaseConversationListViewController *conversationVC = [[EaseConversationListViewController alloc] init];
    [self.view addSubview:conversationVC.view];
    [conversationVC.view makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.notificatTableView.bottom);
        make.height.equalTo(SCREEN_HEIGHT - 98 - 64 - 44);
    }];
}


- (UITableView *)notificatTableView {
    if (!_notificatTableView) {
        _notificatTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 98) style:(UITableViewStylePlain)];
        
        _notificatTableView.delegate = self;
        _notificatTableView.dataSource = self;
        _notificatTableView.tableFooterView = [[UIView alloc] init];
        _notificatTableView.showsVerticalScrollIndicator = NO;
        _notificatTableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        _notificatTableView.bounces = NO;
        
        [_notificatTableView registerNib:[UINib nibWithNibName:@"NotificationMessageCell" bundle:nil] forCellReuseIdentifier:cellid];
        
    }
    return _notificatTableView;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        NotificationMessageCell *notifiCell = [tableView dequeueReusableCellWithIdentifier:cellid];
        notifiCell.selectionStyle = UITableViewCellSelectionStyleNone;
        // 设置通知消息
        
        return notifiCell;
    }
    if (indexPath.section == 1) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 44)];
        label.backgroundColor = [UIColor whiteColor];
        label.text = @"最近联系";
        label.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:label];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 65;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 10;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        SystemNotificationViewController *systemVC = [[SystemNotificationViewController alloc] init];
        systemVC.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:systemVC animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
