//
//  SellerDoInputTableView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerDoInputTableView.h"
#import "SellerDoInputCell.h"

@interface SellerDoInputTableView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@end

static NSString *cellid = @"SellerDoInputCell";

@implementation SellerDoInputTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc] init];
        self.showsVerticalScrollIndicator = NO;
     
//        [self registerNib:[UINib nibWithNibName:@"SellerDoInputCell" bundle:nil] forCellReuseIdentifier:cellid];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
    }
    return self;
}
- (void)setDataPlist:(NSArray *)dataPlist {
    _dataPlist = dataPlist;
    self.dataArr = dataPlist;
    [self reloadData];
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}

#pragma mark
#pragma mark - TableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    DogCategoryModel *model = self.dataArr[indexPath.row];

    cell.textLabel.text = model.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DogCategoryModel *model = self.dataArr[indexPath.row];
    if (_sureAddBlock) {
        _sureAddBlock(model);
    }
}
@end
