//
//  FavoriteViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/25.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "FavoriteViewController.h"
#import "TowButtonView.h"
#import "MyFavoriteTableView.h"

@interface FavoriteViewController ()
/** 两个button View */
@property (strong,nonatomic) TowButtonView *towBtnView;
/** 喜欢的直播 */
@property (strong,nonatomic) MyFavoriteTableView *favotiteLiveTable;
/** 喜欢的狗狗 */
@property (strong,nonatomic) MyFavoriteTableView *favoriteDogTable;
/** 底部scrollView */
//@property (strong,nonatomic) UIScrollView *scrollView;

@end

@implementation FavoriteViewController
#pragma mark
#pragma mark - 网络请求


#pragma mark
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的喜欢";
    
    self.edgesForExtendedLayout = 64;
    
    [self addControllers];
    
    [self setNavBarItem];
}
#pragma mark
#pragma mark - 约束
- (void)addControllers {
    
    [self.view addSubview:self.towBtnView];
    [self.view addSubview:self.favotiteLiveTable];
    [self.view addSubview:self.favoriteDogTable];
    __weak typeof(self) weakself = self;
    
    [_towBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.equalTo(weakself.view);
        make.height.equalTo(44);
    }];
    
}

#pragma mark
#pragma mark - 懒加载
- (TowButtonView *)towBtnView {

    if (!_towBtnView) {
        _towBtnView = [[TowButtonView alloc] init];
        [_towBtnView.liveBtn addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
        
        [_towBtnView.dogBtn addTarget:self action:@selector(changeTableFrame:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _towBtnView;
}

- (MyFavoriteTableView *)favotiteLiveTable {

    if (!_favotiteLiveTable) {
        _favotiteLiveTable = [[MyFavoriteTableView alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
        _favotiteLiveTable.isLive = YES;
        
    }
    return _favotiteLiveTable;
}

- (MyFavoriteTableView *)favoriteDogTable {

    if (!_favoriteDogTable) {
        _favoriteDogTable = [[MyFavoriteTableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 44, SCREEN_WIDTH, SCREEN_HEIGHT - 44 - 64) style:UITableViewStylePlain];
        _favoriteDogTable.isLive = NO;
        
    }
    return _favoriteDogTable;
}

- (void)changeTableFrame:(UIButton *)button {

    if (button == _towBtnView.liveBtn) {
        
        button.selected = YES;
        _towBtnView.dogBtn.selected = NO;
        button.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _towBtnView.dogBtn.backgroundColor = [UIColor whiteColor];
        [_towBtnView.dogBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = _favotiteLiveTable.frame;
            tableRect1.origin.x = 0;
            _favotiteLiveTable.frame = tableRect1;
            
            CGRect tableRect2 = _favoriteDogTable.frame;
            tableRect2.origin.x = SCREEN_WIDTH;
            _favoriteDogTable.frame = tableRect2;
            
        }];
        
    }else {
        
        button.selected = YES;
        _towBtnView.liveBtn.selected = NO;
        button.backgroundColor = [UIColor colorWithHexString:@"#99cc33"];
        [button setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        _towBtnView.liveBtn.backgroundColor = [UIColor whiteColor];
        [_towBtnView.liveBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            CGRect tableRect1 = _favotiteLiveTable.frame;
            tableRect1.origin.x = -SCREEN_WIDTH;
            _favotiteLiveTable.frame = tableRect1;
            
            CGRect tableRect2 = _favoriteDogTable.frame;
            tableRect2.origin.x = 0;
            _favoriteDogTable.frame = tableRect2;
        }];
    
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
