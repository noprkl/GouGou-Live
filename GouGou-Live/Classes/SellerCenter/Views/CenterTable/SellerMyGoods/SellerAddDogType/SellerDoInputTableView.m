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
     
        [self registerNib:[UINib nibWithNibName:@"SellerDoInputCell" bundle:nil] forCellReuseIdentifier:cellid];;

    }
    return self;
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
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerDoInputCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.sureAddBlock = ^(){
        if (_sureAddBlock) {
            _sureAddBlock();
        }
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

@end
