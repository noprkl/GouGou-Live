//
//  LiveTableView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveTableView.h"
#import "LiveViewCell.h"

@interface LiveTableView () <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@end

/** cellid */
static NSString *cellid = @"RecommentCellid";

@implementation LiveTableView
- (void)setDataPlist:(NSMutableArray *)dataPlist {
 
    _dataPlist = dataPlist;
    self.dataArr = dataPlist;
    [self reloadData];
}
- (void)setDogInfos:(NSMutableArray *)dogInfos {
    _dogInfos = dogInfos;
    [self reloadData];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"LiveViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return self;
}

// tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.dataPlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   __block LiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    LiveViewCellModel *model = self.dataArr[indexPath.row];
    cell.liveCellModel = model;
//    cell.dogInfos = self.dogInfos[indexPath.row];
//    if (self.dogInfos.count != 0) {
        NSArray *arr = self.dogInfos[indexPath.row];
        cell.dogInfos = arr;
        cell.cardBlcok = ^(UIControl *control){
            DLog(@"第%ld个卡片", indexPath.row);
            if (_dogCardBlock) {
                _dogCardBlock(model, arr);
            }
        };
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dogInfos.count != 0) {
        NSArray *arr = self.dogInfos[indexPath.row];
        LiveViewCellModel *model = self.dataArr[indexPath.row];
        if (_cellBlock) {
            _cellBlock(model, arr);
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dogInfos.count != 0) {
        NSArray *arr = self.dogInfos[indexPath.row];
        if (arr.count == 0){
            return 250;
        }else{
            return 365;
        }
        
    }
    return 0;
}
@end
