//
//  BaseViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"
#import "HTTPTool.h"
#import "HttpImageTool.h"
#import "UIView+Toast.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
#pragma mark
#pragma mark - 网络请求
/** get信息请求 */
- (void)getRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpRequestSuccessBlock)Success
                     error:(HttpRequestErrorBlock)Error {
    [HTTPTool getRequestWithPath:path
                          params:params
                         success:^(id successJson) {
                             Success(successJson);
                         } error:^(NSError *error) {
                             Error(error);
    }];
}

/** post信息请求 */
- (void)postRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpRequestSuccessBlock)Success
                      error:(HttpRequestErrorBlock)Error {
    [HTTPTool postRequestWithPath:path
                           params:params
                          success:^(id successJson) {
                              Success(successJson);
                          }
                            error:^(NSError *error) {
                                Error(error);
    }];
}
- (void)postJsonRequestWithPath:(NSString *)path
                         params:(NSString *)params
                        success:(HttpRequestSuccessBlock)returnSuccess
                          error:(HttpRequestErrorBlock)returnError{
    [HTTPTool postJsonRequestWithPath:path params:params success:^(id   successJson) {
        returnSuccess(successJson);
    } error:^(NSError *error) {
        returnError(error);
    }];
}

/** get图片请求 */
- (void)getImageRequestWithPath:(NSString *)path
                         params:(NSDictionary *)params
                        success:(HttpRequestSuccessBlock)Success
                          error:(HttpRequestErrorBlock)Error {
    [HttpImageTool getRequestWithPath:path
                          params:params
                         success:^(id successJson) {
                             Success(successJson);
                         } error:^(NSError *error) {
                             Error(error);
                         }];
}

#pragma mark - 图片
/** post图片请求 */
- (void)postImageRequestWithPath:(NSString *)path
                          params:(NSDictionary *)params
                         success:(HttpRequestSuccessBlock)Success
                           error:(HttpRequestErrorBlock)Error {
    [HttpImageTool postRequestWithPath:path
                           params:params
                          success:^(id successJson) {
                              Success(successJson);
                          }
                            error:^(NSError *error) {
                                Error(error);
                            }];

}

- (void)showAlert:(NSString *)string{
    [self.view makeToast:string duration:2 position:@"center"];
}

#pragma mark
#pragma mark - 第三方登录
- (void)QQLogin {}
- (void)WXLogin {}
- (void)SinaLogin {}

- (void)viewDidLoad {
    [super viewDidLoad];
    

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
