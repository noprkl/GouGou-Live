//
//  AddPayingSuccessViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddPayingSuccessViewController.h"
#import "PresentApplicationViewController.h"
#import "SingleChatViewController.h"

@interface AddPayingSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *relationServiceBtn;

@end

@implementation AddPayingSuccessViewController

- (IBAction)clickCancelBtn:(UIButton *)sender {
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];

    [self clickButtonAction];
    PresentApplicationViewController * preApplicatVC = [[PresentApplicationViewController alloc] init];
    
    [self.navigationController pushViewController:preApplicatVC animated:YES];
    
}
- (IBAction)clickRelationServiceBtn:(UIButton *)sender {
    
    [sender setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
    [sender setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    
    [self clickButtonAction];
    
    SingleChatViewController *viewController = [[SingleChatViewController alloc] initWithConversationChatter:EaseTest_Chat1 conversationType:(EMConversationTypeChat)];
    viewController.title = EaseTest_Chat1;
    viewController.chatID = EaseTest_Chat1;
    [self.navigationController pushViewController:viewController animated:YES];
    
    
}

- (void)clickButtonAction {
    if (self.cancelBtn.selected) {
        [self.cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
        
        [self.relationServiceBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        
    }
    if (self.relationServiceBtn.selected) {
        
        [self.cancelBtn setBackgroundColor:[UIColor colorWithHexString:@"#ffffff"]];
        [self.cancelBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
        
        [self.relationServiceBtn setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [self.relationServiceBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    }
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
