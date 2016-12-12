//
//  SettingViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SettingViewController.h"
#import "MyViewController.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>

/** tableView*/
@property (strong, nonatomic) UITableView *tableView;

/** 数据源 */
@property (strong, nonatomic) NSArray *dataArr;

/** 控制器 */
@property (strong, nonatomic) NSArray *controllerNames;

@end

static NSString *cellid = @"SetcellId";

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self setNavBarItem];
}

- (void)initUI {
    [self.view addSubview:self.tableView];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 50 - 64) style:(UITableViewStylePlain)];
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
        
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.bounces = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"账号安全", @"通知消息提醒"], @[@"关于我们"], @[@"意见反馈", @"清除缓存"]];
    }
    return _dataArr;
}
- (NSArray *)controllerNames {
    if (!_controllerNames) {
        _controllerNames = @[@[@"SecurityAccountViewController", @"MessagePushViewController"], @[@"AboutUsViewController"], @[@"SuggestViewController", @""]];
    }
    return _controllerNames;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.dataArr[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.detailTextLabel.text = @"About Us";
        }
    }else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%.02lf M", [self filePath]] ;
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *cellText = self.controllerNames[indexPath.section][indexPath.row];
    NSString *title = self.dataArr[indexPath.section][indexPath.row];
    if ([title isEqualToString:@"清除缓存"]) {
        [self clearFile];
    }else{
        UIViewController *VC = [[NSClassFromString(cellText) alloc] init];
        VC.title = title;
        [self.navigationController pushViewController:VC animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
- (IBAction)clickLoginoutAction:(UIButton *)sender {
    
    [UserInfos removeUser];
    [UserInfos sharedUser].usertel = @"";
    [UserInfos sharedUser].ID = @"";
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // 退出环信
    [[EMClient sharedClient] logout:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
// 获得缓存大小
- (float)filePath
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    return [ self folderSizeAtPath :cachPath];
}
//1:首先我们计算一下 单个文件的大小

- (long long)fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}
//2:遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）
- (float)folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize/( 1024.0 * 1024.0 );
}
// 清理缓存
- (void)clearFile
{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    NSLog ( @"cachpath = %@" , cachPath);
    for ( NSString * p in files) {
        NSError * error = nil ;
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&error];
        }
    }
    [ self performSelectorOnMainThread : @selector (clearCachSuccess) withObject : nil waitUntilDone : YES ];
}
-(void)clearCachSuccess
{
    [self showAlert:@"清理成功"];
    NSIndexPath *index=[NSIndexPath indexPathForRow:1 inSection:2];//刷新
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index,nil] withRowAnimation:UITableViewRowAnimationNone];
}
@end
