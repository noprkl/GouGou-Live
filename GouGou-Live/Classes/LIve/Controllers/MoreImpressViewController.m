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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
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
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.dataArr.count;
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoreImpressViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[MoreImpressViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }


        cell.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16];

    cell.textLabel.text = @"更多印象";

    cell.detailTextLabel.text = @"#1000";

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
    
    DogTypesViewController * typeVC = [[DogTypesViewController alloc] init];
    
    typeVC.title = cell.textLabel.text;
    [self.navigationController pushViewController:typeVC animated:YES];
    
    self.cell = cell;
    

}
- (void)setNavBarItem {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftBackBtnAction)];
    
    self.title = @"更多印象";
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage2"] forBarMetrics:(UIBarMetricsDefault)];

}
- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navImage"] forBarMetrics:(UIBarMetricsDefault)];

}
- (void)leftBackBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
