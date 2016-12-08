//
//  MessagePushViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//
#import "MessagePushViewController.h"
#import "TimePickerView.h"


static NSString * messageCell = @"messageCellID";

@interface MessagePushViewController ()<UITableViewDelegate,UITableViewDataSource>
/** tableView*/
@property (strong,nonatomic) UITableView *tableview;
/** 数据源 */
@property (strong,nonatomic) NSArray *dataArray;

@property (copy, nonatomic) NSString *timeStr; /**< 接收时间信息 */

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
    
    UISwitch * swic = [[UISwitch alloc] init];
    
    CGFloat switchW = swic.frame.size.width;
    
    CGFloat switchH = swic.frame.size.height;

    if (indexPath.section == 0) {
        
        swic.frame = CGRectMake(SCREEN_WIDTH - switchW - 10, 5, switchW, switchH);
        swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
        [cell.contentView addSubview:swic];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ( indexPath.row == 0) {
            [swic setOn:YES];
        }
        
    } else if (indexPath.section == 1) {
        
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        if (indexPath.row == 0) {
            
            swic.frame = CGRectMake(SCREEN_WIDTH - 10 - switchW, 6, switchW, switchH);
            
            swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
            
            [swic setOn:YES];
            
            [cell.contentView addSubview:swic];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        } else if (indexPath.row == 1) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"8:00";
//            cell.detailTextLabel.text = self.timeStr;
            DLog(@"%@",cell.detailTextLabel.text);

        } else if (indexPath.row == 2) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailTextLabel.text = @"12:00";
//            DLog(@"%@",cell.detailTextLabel.text);

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
                self.timeStr = timeStr;
                DLog(@"%@",timeStr);

            };
            [timePick show];
            
        } else if (indexPath.row == 2) {
            
            TimePickerView * timePick = [[TimePickerView alloc] init];

            timePick.timeLabel = @"结束时间";
            __weak typeof(timePick) weakPicker = timePick;
            
            timePick.timeBlock = ^(NSString *timeStr) {
                
                [weakPicker dismiss];
                self.timeStr = timeStr;
                DLog(@"%@",timeStr);
                
            };
            [timePick show];
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
