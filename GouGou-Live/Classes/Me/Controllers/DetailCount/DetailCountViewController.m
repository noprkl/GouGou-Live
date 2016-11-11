//
//  DetailCountViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DetailCountViewController.h"
#import "DetailCountTopView.h"
#import "DetailCountViewCell.h"

@interface DetailCountViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) DetailCountTopView *centerView; /**< headerView */

@property(nonatomic, strong) UITableView *tableView; /**< tableView */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) NSString *allCount; /**< 总收入 */
@end

static NSString *cellid = @"cellid";

@implementation DetailCountViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    [self setNavBarItem];
}
- (void)initUI {
    [self.view addSubview:self.centerView];
    [self.view addSubview:self.tableView];
    
    self.edgesForExtendedLayout = 0;
    
    [self.centerView makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(44);
    }];
    [self.tableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.bottom);
        make.left.right.equalTo(self.view);
        make.height.equalTo((SCREEN_HEIGHT - 44 - 64));
    }];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        [_tableView registerNib:[UINib nibWithNibName:@"DetailCountViewCell" bundle:nil] forCellReuseIdentifier:cellid];
    }
    return _tableView;
}
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
// 一共有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArr.count;
    return 10;

}
// 加载cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailCountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    
    return cell;
}
// 头部添加内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH, 44)];
        label.textColor = [UIColor colorWithHexString:@"#000000"];
        label.font = [UIFont systemFontOfSize:16];
//        label.text = self.allCount;
        label.text = @"总收入：10000";
        [view addSubview:label];
        
        return view;
    }
    return nil;
}
// 头部高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
//每一行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 65;
}

- (DetailCountTopView *)centerView {
    
    if (!_centerView) {
        _centerView = [[DetailCountTopView alloc] init];
        
        __weak typeof(self) weakSelf = self;
        _centerView.talkBlock = ^(UIButton *btn){
            
            DLog(@"全部");
            
            return YES;
        };
        _centerView.dogBlock = ^(UIButton *btn){
            
                        DLog(@"收入");
            
            return YES;
        };
        _centerView.serviceBlock = ^(UIButton *btn){
            DLog(@"支出");
        
            return YES;
        };
        _centerView.sellerBlock = ^(UIButton *btn){

            DLog(@"交易中");
            
            return YES;
        };
    }
    return _centerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
