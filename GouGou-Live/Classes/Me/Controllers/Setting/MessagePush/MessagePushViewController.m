//
//  MessagePushViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//
#import "MessagePushViewController.h"
#import "TimePickerView.h"
#import <AudioToolbox/AudioToolbox.h>

static NSString * messageCell = @"messageCellID";

@interface MessagePushViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView*/
@property (strong,nonatomic) UITableView *tableview;
/** 数据源 */
@property (strong,nonatomic) NSArray *dataArray;

@property (nonatomic, strong) UILabel *startTime; /**< 开始时间 */
@property (nonatomic, strong) UILabel *endTime; /**< 结束时间 */
@end

@implementation MessagePushViewController

- (NSArray *)dataArray {
    
    if (!_dataArray) {
        _dataArray = @[@[@"新消息提醒",@"消息提示音"],@[@"接受新消息通知",@"开始时间",@"结束时间"]];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    
    self.title = @"通知消息提醒";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    [self.view addSubview:self.tableview];
}

- (UITableView *)tableview {
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 10) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableview.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return _tableview;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArray[section] count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:messageCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:messageCell];
    }
    cell.textLabel.text = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];

    if (indexPath.section == 0) {
        if (indexPath.row == 0) { // 新消息提醒 （全部）
            UISwitch * swic = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
            swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
            [swic addTarget:self action:@selector(changeNewsPushSwitch:) forControlEvents:(UIControlEventValueChanged)];
            swic.on = [self isNewsAccept];
            cell.accessoryView = swic;
        }
        if (indexPath.row == 1) { // 新消息提示音
            UISwitch * swic = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
            swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
            [swic addTarget:self action:@selector(changeNewsSoundSwitch:) forControlEvents:(UIControlEventValueChanged)];
            swic.on = [self isNewsSound];
            cell.accessoryView = swic;
        }
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {  // 新消息通知（环信消息）
            UISwitch * swic = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
            swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
            [swic addTarget:self action:@selector(changeNewsAcceptSwitch:) forControlEvents:(UIControlEventValueChanged)];
            swic.on = [self isNewsPush];
            cell.accessoryView = swic;
        } else if (indexPath.row == 1) { // 环信时间段
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 25)];
            NSString *beginTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"BEGIN_TIME"];
            if (beginTime.length != 0) {
                label.text = beginTime;
            }else{
                label.text = @"8:00";
            }

            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.font = [UIFont systemFontOfSize:15];
            label.textAlignment = NSTextAlignmentCenter;
            cell.accessoryView = label;
            self.startTime = label;
        } else if (indexPath.row == 2) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 25)];
            NSString *beginTime = [[NSUserDefaults standardUserDefaults] valueForKey:@"END_TIME"];
            if (beginTime.length != 0) {
                label.text = beginTime;
            }else{
                label.text = @"20:00";
            }
            label.textColor = [UIColor colorWithHexString:@"#666666"];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:15];
            cell.accessoryView = label;
            self.endTime = label;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (indexPath.row == 1) {
            TimePickerView * timePick = [[TimePickerView alloc] init];
            timePick.timeLabel = @"开始时间";
            __weak typeof(timePick) weakPicker = timePick;
            timePick.timeBlock = ^(NSString *timeStr) {
                [weakPicker dismiss];
                self.startTime.text = timeStr;
                [[NSUserDefaults standardUserDefaults] setObject:timeStr forKey:@"BEGIN_TIME"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            };
            [timePick show];
        } else if (indexPath.row == 2) {
            TimePickerView * timePick = [[TimePickerView alloc] init];
            timePick.timeLabel = @"结束时间";
            __weak typeof(timePick) weakPicker = timePick;
            timePick.timeBlock = ^(NSString *timeStr) {
                [weakPicker dismiss];
                self.endTime.text = timeStr;
                [[NSUserDefaults standardUserDefaults] setObject:timeStr forKey:@"END_TIME"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            };
            [timePick show];
        }
    }
}
- (void)changeNewsPushSwitch:(UISwitch *)swit {
    if (swit.isOn) {
        DLog(@"开启推送");
        [[[UIApplication sharedApplication] currentUserNotificationSettings] setValue:@(1) forKey:@"types"];
    }else{
        DLog(@"关闭推送");
        [[[UIApplication sharedApplication] currentUserNotificationSettings] setValue:@(0) forKey:@"types"];
    }
}
// 是否接受新消息推送
- (BOOL)isNewsAccept {
    if (IOS8) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
            return NO;
        }
        return YES;
    }else{ // ios7 一下
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone) {
            return NO;
        }
        return YES;
    }
}

- (void)changeNewsSoundSwitch:(UISwitch *)swit {
    if (swit.isOn) {
        DLog(@"开启推送");
        [[[UIApplication sharedApplication] currentUserNotificationSettings] setValue:@(UIUserNotificationTypeSound) forKey:@"types"];
    }else{
        DLog(@"关闭推送");
        [[[UIApplication sharedApplication] currentUserNotificationSettings] setValue:@(0) forKey:@"types"];
    }
}
// 是否开启消息提示音
- (BOOL)isNewsSound {
    if (IOS8) { //iOS8以上包含iOS8
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeSound) {
            return YES;
        }
        return NO;
    }else{ // ios7 一下
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeSound) {
            return YES;
        }
        return NO;
    }
}
- (void)changeNewsAcceptSwitch:(UISwitch *)swit {

    if (swit.isOn) {
        DLog(@"开启通知");
        [[[EMClient sharedClient] pushOptions] setNoDisturbingStartH:[self.startTime.text intValue]];
        [[[EMClient sharedClient] pushOptions] setNoDisturbingEndH:[self.endTime.text intValue]];
    }else{
        DLog(@"关闭通知");
        [[[EMClient sharedClient] pushOptions] setNoDisturbStatus:(EMPushNoDisturbStatusCustom)];
    }
}
// 环信 消息免打扰
- (BOOL)isNewsPush {
    EMPushOptions *pushOption = [[EMClient sharedClient] pushOptions] ;
    if (pushOption.noDisturbStatus == EMPushNoDisturbStatusCustom) {
        return YES;
    }else{
        return NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
