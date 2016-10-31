//
//  BaseNavigationController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
+ (void)initialize {
    
    UINavigationBar *navBar = [UINavigationBar appearance];

    navBar.titleTextAttributes = @{
                  NSForegroundColorAttributeName:[UIColor grayColor],
                  NSFontAttributeName:[UIFont systemFontOfSize:20]
                  };
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName:[UIColor grayColor],
                                                          NSFontAttributeName:[UIFont systemFontOfSize:17]
                                                          }
                                                forState:(UIControlStateNormal)];

}
- (void)viewDidLoad {
    [super viewDidLoad];

    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [super pushViewController:viewController animated:YES];
    
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
