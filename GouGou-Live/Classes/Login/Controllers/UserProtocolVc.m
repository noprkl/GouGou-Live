//
//  UserProtocolVc.m
//  GouGou-Live
//
//  Created by ma c on 16/12/22.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "UserProtocolVc.h"
#import "NormalModel.h"

@interface UserProtocolVc ()

@property (nonatomic, strong) UILabel *label; /**< 文字 */

@end

@implementation UserProtocolVc

- (void)getRequestProtocol {
    NSDictionary *dict = @{@"id":@(1)};
    [self getRequestWithPath:API_Help params:dict success:^(id successJson) {
        DLog(@"%@", successJson);
        NSArray *arr = [NormalModel mj_objectArrayWithKeyValuesArray:successJson[@"data"]];
        NormalModel *model = arr[0];
        self.label.text = model.conent;
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];

    NSDictionary *dict3 = @{@"id":@(3)};
    [self getRequestWithPath:API_Help params:dict3 success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    NSDictionary *dict4 = @{@"id":@(4)};
    [self getRequestWithPath:API_Help params:dict4 success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    NSDictionary *dict5 = @{@"id":@(5)};
    [self getRequestWithPath:API_Help params:dict5 success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
    NSDictionary *dict6 = @{@"id":@(6)};
    [self getRequestWithPath:API_Help params:dict6 success:^(id successJson) {
        DLog(@"%@", successJson);
    } error:^(NSError *error) {
        DLog(@"%@", error);
    }];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getRequestProtocol];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户协议";
    [self setNavBarItem];
    [self.view addSubview:self.label];
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
}
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.text = @"用户协议";
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor colorWithHexString:@"#333333"];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
