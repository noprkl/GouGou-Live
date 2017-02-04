//
//  SellerNoInputTableView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#define kHistory @"DOGTYPEHISSTORY"

#import "SellerNoInputTableView.h"
#import "SellerNoInputHotBtnView.h" // 热搜按钮

@interface SellerNoInputTableView ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSMutableArray *historyDataArr; /**< 历史数据源 */

@property(nonatomic, assign) CGFloat hotViewHeight; /**< 热门搜索高度 */

@property(nonatomic, strong) NSArray *hotDataArr; /**< 热门 */

@end

static NSString *cellid = @"SellerNoInputcell";

@implementation SellerNoInputTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.tableFooterView = [[UIView alloc] init];
        self.showsVerticalScrollIndicator = NO;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellid];
        
    }
    return self;
}
- (void)setHotArr:(NSArray *)hotArr {
    _hotArr = hotArr;
    self.hotDataArr = hotArr;
    [self reloadData];
}
- (void)setHistoryArr:(NSArray *)historyArr {
    _historyArr = historyArr;
    self.historyDataArr = [historyArr mutableCopy];
    [self reloadData];
}
#pragma mark
#pragma mark - 懒加载
- (NSMutableArray *)historyDataArr {
    if (!_historyDataArr) {
        _historyDataArr = [NSMutableArray array];
        
    }
    return _historyDataArr;
}
- (NSArray *)hotDataArr {
    if (!_hotDataArr) {
        _hotDataArr = [NSArray array];
    }
    return _hotDataArr;
}
#pragma mark
#pragma mark - TableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        NSArray *historyArr = [[NSUserDefaults standardUserDefaults] arrayForKey:kHistory];
        _historyDataArr = [historyArr mutableCopy];
        return self.historyDataArr.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SellerHotSearch"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView = [[UIView alloc] init];
        cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        SellerNoInputHotBtnView *hotView = [[SellerNoInputHotBtnView alloc] init];
        hotView.datalist = self.hotDataArr;
        hotView.clickBlcok = ^(DogCategoryModel *kind){
            if (_typeBlock) {
                _typeBlock(kind);
            }
        };
        CGFloat height = [hotView getViewHeight:self.hotDataArr];
        hotView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
        self.hotViewHeight = height;
        [cell.contentView addSubview:hotView];
        return cell;
    }
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.image = [UIImage imageNamed:@"搜索icon-拷贝"];
//        DogCategoryModel *type = self.historyDataArr[indexPath.row];
        cell.textLabel.text = self.historyDataArr[indexPath.row];
        
        UIButton *deleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [deleBtn sizeToFit];
        [deleBtn setImage:[UIImage imageNamed:@"-单删除"] forState:(UIControlStateNormal)];
        [deleBtn addTarget:self action:@selector(btnClicked:event:) forControlEvents:(UIControlEventTouchDown)];
        cell.accessoryView = deleBtn;
        return cell;
    }
    return nil;
}
- (void)btnClicked:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        [self tableView:self accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    DLog(@"%ld", indexPath.row);
    NSString *history = self.historyDataArr[indexPath.row];
    
    [self.historyDataArr removeObject:history];
    [[NSUserDefaults standardUserDefaults] setObject:self.historyDataArr forKey:kHistory];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self reloadData];
    //    [self reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (void)deleAllHistorydata {
    // 删除全部
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray * myArray = [userDefaults arrayForKey:kHistory];
    NSMutableArray *searTXT = [myArray mutableCopy];
    [searTXT removeAllObjects];
    [userDefaults setObject:searTXT forKey:kHistory];
    self.historyArr = [userDefaults arrayForKey:kHistory];
    NSIndexSet *session = [[NSIndexSet alloc] initWithIndex:1];
    [self reloadSections:session withRowAnimation:(UITableViewRowAnimationAutomatic)];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
    
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
        label.text = @"热门搜索";
        label.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        label.font = [UIFont boldSystemFontOfSize:16];
        label.backgroundColor = [UIColor whiteColor];
        [view addSubview:label];
        return view;
    }
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        view.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 50)];
        label.text = @"搜索历史";
        label.textColor = [UIColor colorWithHexString:@"#ffa11a"];
        label.font = [UIFont boldSystemFontOfSize:16];
        [view addSubview:label];
        
        UIButton *deleBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        UIImage *image = [UIImage imageNamed:@"删除"];
        [deleBtn setImage:image forState:(UIControlStateNormal)];
        [deleBtn addTarget:self action:@selector(deleAllHistorydata) forControlEvents:(UIControlEventTouchDown)];
        [deleBtn setContentMode:(UIViewContentModeCenter)];
        deleBtn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
        [deleBtn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
        [view addSubview:deleBtn];
        
        return view;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return self.hotViewHeight + 10;
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 50;
    }
    if (section == 1) {
        if (self.historyDataArr.count == 0) {
            return 0;
        }
        return 50;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSString *kind = self.historyDataArr[indexPath.row];
        if (_typeCellBlock) {
            _typeCellBlock(kind);
        }
    }
}
@end
