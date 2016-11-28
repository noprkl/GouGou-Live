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
    
    if (indexPath.section == 0) {
        
        UISwitch * swic = [[UISwitch alloc] init];
        swic.frame = CGRectMake(308, 5, swic.frame.size.width, swic.frame.size.height);
        swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
        [cell.contentView addSubview:swic];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if ( indexPath.row == 0) {
            [swic setOn:YES];
        }
        
    } else if (indexPath.section == 1) {
        
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        
        if (indexPath.row == 0) {
            
            UISwitch * swic = [[UISwitch alloc] init];
            swic.frame = CGRectMake(308, 6, swic.frame.size.width, swic.frame.size.height);
            
            swic.onTintColor = [UIColor colorWithHexString:@"#99cc33"];
            
            [swic setOn:YES];
            
            [cell.contentView addSubview:swic];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
        } else if (indexPath.row == 1) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = @"8:00";
            
        } else if (indexPath.row == 2) {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            cell.detailTextLabel.text = @"12:00";
            
        }
        
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 1) {
            
            TimePickerView * timePick = [[TimePickerView alloc] init];
            timePick.timeLabel = @"开始时间";
            timePick.hourTime = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
            [timePick show];
            
        } else if (indexPath.row == 2) {
            
            TimePickerView * timePick = [[TimePickerView alloc] init];
            timePick.hourTime = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
            //            timePick.secondTime = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
            timePick.timeLabel = @"结束时间";
            [timePick show];
            
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
