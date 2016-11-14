//
//  ManagePictureaViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ManagePictureaViewController.h"

@interface ManagePictureaViewController ()

@end

@implementation ManagePictureaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI {
    
    [self setNavBarItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"添加"] style:(UIBarButtonItemStylePlain) target:self action:@selector(choseAddPicture)];
}
- (void)choseAddPicture {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
