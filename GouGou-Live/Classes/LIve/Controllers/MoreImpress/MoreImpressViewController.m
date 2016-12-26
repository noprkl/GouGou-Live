//
//  MoreImpressViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MoreImpressViewController.h"
#import "MoreImpressViewCell.h"
#import "DogTypesViewController.h"

@interface MoreImpressViewController ()<UITableViewDataSource, UITableViewDelegate>;

@property(nonatomic, strong) UITableView *tableView; /**< 表格 */

@property(nonatomic, strong) NSArray  *dataArr; /**< 数据源 */


@property(nonatomic, strong) NSMutableArray *cells; /**< cells */


@property(nonatomic, strong) MoreImpressViewCell *cell; /**< <#注释#> */
@end

static NSString *cellid = @"cellid";

@implementation MoreImpressViewController
// 印象
- (void)getRequestImpresion{
    NSDictionary *dict = @{
                           @"page":@(1),
                           @"pageSize":@(10)
                           };
    [self getRequestWithPath:API_Impression params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        self.dataArr = [MoreImpressionModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        [self.tableView reloadData];
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view addSubview:self.tableView];

    [self getRequestImpresion];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];
    self.title = @"更多印象";
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarItem];
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)cells {
    if (!_cells) {
        _cells =[NSMutableArray array];
    }
    return _cells;
}
- (UITableView *)tableView {
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreImpressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[MoreImpressViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    MoreImpressionModel *model = self.dataArr[indexPath.row];
    
    cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];

    cell.textLabel.text = model.name;

    cell.detailTextLabel.text = @"#1";

    [self.cells addObject:cell];
    self.cell = cell; // 默认选中某一个
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.cell.backgroundView.backgroundColor = [UIColor whiteColor];
    self.cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    self.cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    self.cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    self.cell.detailTextLabel.font = [UIFont systemFontOfSize:16];
    
    MoreImpressViewCell *cell = (MoreImpressViewCell *)self.cells[indexPath.row];
    
    cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:16];

    self.cell = cell;
    
    // 跳转 
    MoreImpressionModel *model = self.dataArr[indexPath.row];
    DogTypesViewController *dogType = [[DogTypesViewController alloc] init];
    dogType.dogType = model;
    dogType.title = model.name;
    [self.navigationController pushViewController:dogType animated:YES];

}
- (void)setNavBarItem {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
}

- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
