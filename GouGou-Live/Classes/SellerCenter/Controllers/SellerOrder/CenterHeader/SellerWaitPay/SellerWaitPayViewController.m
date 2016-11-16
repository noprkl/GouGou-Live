//
//  SellerWaitPayViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/15.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerWaitPayViewController.h"
#import "SellerWaitPayCell.h"

@interface SellerWaitPayViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UITableView *tableView; /**< TableView */

@end

static NSString *cellid = @"SellerWaitPayCell";

@implementation SellerWaitPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    [self.view addSubview:self.tableView];
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 62) style:(UITableViewStylePlain)];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        
        [_tableView registerClass:[SellerWaitPayCell class] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SellerWaitPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
   
    if (indexPath.row == 0) {
        cell.orderState = @"待付尾款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
    }else if (indexPath.row == 1){
        cell.orderState = @"待付全款";
        cell.btnTitles = @[@"联系买家", @"修改运费", @"修改价格"];
    }else if (indexPath.row == 2){
        cell.orderState = @"待付定金";
        cell.btnTitles = @[@"联系买家"];
    }
    cell.clickBtnBlock = ^(NSString *btnText){
        DLog(@"%@", btnText);
    };
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 245;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"%ld", indexPath.row);
}
@end
