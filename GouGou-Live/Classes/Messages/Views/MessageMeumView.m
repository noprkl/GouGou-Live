//
//  MessageMeumView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MessageMeumView.h"

@interface MessageMeumView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@property(nonatomic, strong) NSMutableArray *cells; /**< cells */

@property(nonatomic, strong) UITableViewCell *lastcell; /**< 上一个 */

@end

static NSString *cellid = @"MessageMeumView";

@implementation MessageMeumView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc] init];
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return self;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (void)setDataPlist:(NSArray *)dataPlist {
    _dataPlist = dataPlist;
    self.dataArr = dataPlist;
//    self.dataArr = @[@"关注", @"举报",  @"屏蔽消息", @"个人主页"];
    [self reloadData];
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells = [NSMutableArray array];
    }
    return _cells;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataPlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        cell.textLabel.text = self.dataPlist[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        self.lastcell = cell;
    }
    [self.cells addObject:cell];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.lastcell.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    self.lastcell.textLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    
    UITableViewCell *cell = self.cells[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.lastcell = cell;
    
    if (_cellBlock) {
        _cellBlock(self.dataPlist[indexPath.row]);
    }
}
@end
