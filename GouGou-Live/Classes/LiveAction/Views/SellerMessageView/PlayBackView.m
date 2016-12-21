//
//  PlayBackView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PlayBackView.h"
#import "PlayBackCard.h"
#import "PlayBackCell.h"

@interface PlayBackView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property (nonatomic, strong) UITableView *tableView; /**< tableView */

@end
static NSString *cellid = @"Cellid";
@implementation PlayBackView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.bounces = NO;
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (_AVArray.count == 0) {
            self.tableFooterView = [[UIView alloc] init];
        }
        [self registerClass:[PlayBackCell class] forCellReuseIdentifier:cellid];
    }
    return self;
}
- (void)setAVArray:(NSArray *)AVArray {
    _AVArray = AVArray;
    self.dataArr = AVArray;
    [self.tableView reloadData];
}
#pragma mark
#pragma mark - 懒加载

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayBackCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dogCardModel = self.dataArr[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PlayBackModel *model = self.dataArr[indexPath.row];
    if (_playBackBlock) {
        _playBackBlock(model);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 135;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH - 10, 44)];
    label.text = @"回放";
    label.font = [UIFont systemFontOfSize:16];
    label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    label.textColor = [UIColor colorWithHexString:@"#000000"];
    return label;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.dataArr.count == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        label.text = @"暂时没有回放";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:16];
        label.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        label.textColor = [UIColor colorWithHexString:@"#666666"];

        return label;
    }else{
        return nil;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.dataArr.count == 0) {
        return 44;
    }
    return 0;
}
@end

