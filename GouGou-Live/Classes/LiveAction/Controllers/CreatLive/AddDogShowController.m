//
//  AddDogShowController.m
//  GouGou-Live
//
//  Created by ma c on 16/12/8.
//  Copyright © 2016年 LXq. All rights reserved.
//  添加展播狗狗

#import "AddDogShowController.h"
#import "AddDogShowCell.h"   // 添加展播狗狗cell
#import "SellerCreateDogMessageViewController.h" // 卖家创建狗狗
#import "CreateLiveViewController.h"  // 创建狗狗展播
#import "DeletePrommtView.h"  // 删除时提示框

static NSString * dogShowCell = @"dogShowCellID";
@interface AddDogShowController ()<UITableViewDelegate,UITableViewDataSource>
/** tableview */
@property (strong,nonatomic) UITableView *tableView;
@property(nonatomic, strong) UIButton *allSelectBtn; /**< 编辑 */

@property(nonatomic, strong) UIButton *deleteBtn; /**< 添加 */
@end

@implementation AddDogShowController
#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    [self setNavBarItem];
    
    [self addControllers];
    self.title = @"添加展播狗狗";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
}

- (void)initUI {

    [self.view addSubview:self.tableView];
    [self.view addSubview:self.allSelectBtn];
    [self.view addSubview:self.deleteBtn];

     self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStyleDone) target:self action:@selector(ClickAddBtnBlock)];
}


- (void)addControllers {

    [self.deleteBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.equalTo(self.view);
        make.size.equalTo(CGSizeMake(100, 44));
    }];
    
    [self.allSelectBtn makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left);
        make.centerY.equalTo(self.deleteBtn.centerY);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - self.deleteBtn.frame.size.width, 44));
        
    }];
    DLog(@"%@",NSStringFromCGSize(self.allSelectBtn.frame.size));

}

#pragma mark
#pragma mark - 懒加载
- (UITableView *)tableView {

    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        // 注册
        [_tableView registerClass:[AddDogShowCell class] forCellReuseIdentifier:dogShowCell];
    }
    return _tableView;
}

- (UIButton *)allSelectBtn {
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        [_allSelectBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:(UIControlStateNormal)];
        _allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_allSelectBtn setTitle:@"全选" forState:(UIControlStateNormal)];
        
        [_allSelectBtn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
        [_allSelectBtn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
        
        [_allSelectBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        
//        DLog(@"%@",NSStringFromCGRect(self.allSelectBtn.frame));
        
        _allSelectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, -(SCREEN_WIDTH - 44) + 40, 10, 20);
        //button标题的偏移量，这个偏移量是相对于图片的
        _allSelectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(SCREEN_WIDTH - 44) + 35, 0, 0);
//        _allSelectBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
//        // 偏移量
//        [_allSelectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -20)];
        
        [_allSelectBtn addTarget:self action:@selector(clickAllSelectBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _allSelectBtn;
}
- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_deleteBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        _deleteBtn.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        
        [_deleteBtn addTarget:self action:@selector(clickDeleteBtnAction) forControlEvents:(UIControlEventTouchDown)];
    }
    return _deleteBtn;
}
#pragma mark - tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    AddDogShowCell * cell = [tableView dequeueReusableCellWithIdentifier:dogShowCell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // 对号勾选block
    cell.selectBtnBlock = ^(UIButton * button) {
    
//        button.selected =! button.selected;
    };
    // 编辑按钮block
    cell.editButtonBlock = ^() {
    
        SellerCreateDogMessageViewController * sellerCreatDogVC = [[SellerCreateDogMessageViewController alloc] init];
        
        [self.navigationController pushViewController:sellerCreatDogVC animated:YES];
    
    };
    // 删除按钮block
    cell.deleteButtonBlock = ^() {
        __block DeletePrommtView * deletePrommpt = [[DeletePrommtView alloc] init];
        
        deletePrommpt.message = @"将会同时删除我的狗狗中的宝贝\n且不可恢复";
        deletePrommpt.sureBlock = ^(UIButton *btn){
            
            // 网络请求，然后删除订单
        };
        [deletePrommpt show];
    
    };
    
    
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 170, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];

    [cell.contentView addSubview:view];
    
    return cell;
}

#pragma mark - 按钮点击
// 点击nav右侧按钮
- (void)ClickAddBtnBlock {

    SellerCreateDogMessageViewController * sellerCreatDogVC = [[SellerCreateDogMessageViewController alloc] init];
    
    [self.navigationController pushViewController:sellerCreatDogVC animated:YES];
}
// 点击下方完成按钮
- (void)clickDeleteBtnAction {
  
    CreateLiveViewController * creatVC = [[CreateLiveViewController alloc] init];
    
    [self.navigationController pushViewController:creatVC animated:YES];
    
}
// 点击全选
- (void)clickAllSelectBtnAction:(UIButton *)btn {
    
    
    
}

@end
