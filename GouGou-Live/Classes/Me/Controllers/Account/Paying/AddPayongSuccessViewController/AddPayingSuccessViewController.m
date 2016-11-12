//
//  AddPayingSuccessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddPayingSuccessViewController.h"
#import "PresentApplicationViewController.h"


@interface AddPayingSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *relationServiceBtn;

@end

@implementation AddPayingSuccessViewController

- (IBAction)clickCancelBtn:(UIButton *)sender {
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

    PresentApplicationViewController * preApplicatVC = [[PresentApplicationViewController alloc] init];
    
    [self.navigationController pushViewController:preApplicatVC animated:YES];
    
}
- (IBAction)clickRelationServiceBtn:(UIButton *)sender {
    
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI {
    
    [self setNavBarItem];
    [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
    [self.relationServiceBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
    [self.relationServiceBtn setBackgroundColor:[UIColor whiteColor]];
    
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateHighlighted];
    [self.cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [self.cancelBtn addTarget:self action:@selector(btnHighlightColor:) forControlEvents:(UIControlEventTouchDown)];
}

- (void)btnHighlightColor:(UIButton *)btn {
    [btn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
