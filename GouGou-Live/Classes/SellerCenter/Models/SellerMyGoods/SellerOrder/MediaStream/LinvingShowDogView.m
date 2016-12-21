//
//  LinvingShowDogView.m
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LinvingShowDogView.h"
#import "LivingShowDogCell.h"

@interface LinvingShowDogView ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataPlist; /**< 数据源 */

@end

static NSString *cellid = @"LivingShowDogCell";

@implementation LinvingShowDogView
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    _dataPlist = dataArr;
    [self reloadData];
}
- (NSArray *)dataPlist {
    if (!_dataPlist) {
        
        _dataPlist = [NSArray array];
    }
    return _dataPlist;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.tableFooterView = [[UIView alloc] init];
        
        [self registerClass:[LivingShowDogCell class] forCellReuseIdentifier:cellid];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataPlist.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LivingShowDogCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.model = self.dataPlist[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
#pragma mark 高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 77;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

#pragma mark 头尾
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 43)];
        
        label.text = @"狗狗";
        label.userInteractionEnabled = YES;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        
        UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *image = [UIImage imageNamed:@"返回fan"];
        [backBtn setImage:image forState:(UIControlStateNormal)];
        backBtn.frame = CGRectMake(10, (44 - image.size.height) / 2, image.size.width, image.size.height);
        [backBtn addTarget:self action:@selector(clickBackBtnAction) forControlEvents:(UIControlEventTouchDown)];
        [view addSubview:backBtn];
        // 线
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 43, SCREEN_WIDTH, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        [view addSubview:line];
        
        return view;
    }
    
    return nil;
    
}
- (void)clickBackBtnAction {

    self.hidden = YES;
}

#pragma mark 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveListDogInfoModel *model = self.dataPlist[indexPath.row];
    if (_cellBlock) {
        _cellBlock(model);
    }
}

@end
