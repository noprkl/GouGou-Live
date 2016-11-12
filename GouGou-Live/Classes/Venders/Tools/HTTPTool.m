//
//  HTTPTool.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "HTTPTool.h"

static NSString *baseURL = SERVER_HOST;

@implementation HTTPTool

//单例模式manager初始化
+ (instancetype)shareAFNManager
{
    static HTTPTool *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HTTPTool alloc] initWithBaseURL:[NSURL URLWithString:baseURL]];

        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/jsons", @"text/javascript",@"text/plain",@"image/gif", nil];
        //  安全系数
        manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    });
    return manager;
}
+ (void)getRequestWithPath:(NSString *)path
                    params:(NSDictionary *)params
                   success:(HttpRequestSuccessBlock)returnSuccess
                     error:(HttpRequestErrorBlock)returnError;
{
    HTTPTool *manager = [HTTPTool shareAFNManager];
    
    [manager GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (returnSuccess) {
            returnSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (returnError) {
            returnError(error);
        }
    }];
    
}
+ (void)postRequestWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpRequestSuccessBlock)returnSuccess
                      error:(HttpRequestErrorBlock)returnError;
{
    
    HTTPTool *manager = [HTTPTool shareAFNManager];
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (returnSuccess) {
            returnSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (returnError) {
            returnError(error);
        }
    }];
}
// post json字符串请求数据
+ (void)postJsonRequestWithPath:(NSString *)path
                         params:(NSString *)params
                        success:(HttpRequestSuccessBlock)returnSuccess
                          error:(HttpRequestErrorBlock)returnError{
    HTTPTool *manager = [HTTPTool shareAFNManager];
    [manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (returnSuccess) {
            returnSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (returnError) {
            returnError(error);
        }
    }];
}

@end
