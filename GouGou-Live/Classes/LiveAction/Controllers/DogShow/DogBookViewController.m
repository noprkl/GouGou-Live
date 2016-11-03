//
//  DogBookViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "DogBookViewController.h"
#import "SellerAndDogCardView.h"


@interface DogBookViewController ()<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property(nonatomic, strong) UITableView *tablevView; /**< 表格 */

@property(nonatomic, strong) NSArray *dataArr; /**< 数据源 */

@property(nonatomic, strong) UILabel *bookMoneyLabel; /**< 应付定金 */

@property(nonatomic, strong) UIButton *payCount; /**< 结算按钮 */


@property(nonatomic, strong) UITableViewCell *cell1; /**< 应付定金cell */

@property(nonatomic, strong) UITableViewCell *cell2; /**< 剩余金额cell */

@property(nonatomic, strong) UITableViewCell *cell3; /**< 收货地址cell */

@property(nonatomic, strong) UITextView *noteTextView; /**< 备注 */

@property(nonatomic, strong) UILabel *placeLabel; /**< 站位字符 */

@end

@implementation DogBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
}
- (void)initUI {
    [self setNavBarItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tablevView];
    [self.view addSubview:self.bookMoneyLabel];
    [self.view addSubview:self.payCount];
    

    [self makeConstraint];
    
    
    //注册键盘出现的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}
- (void)makeConstraint {
    [self.payCount makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH / 3, 50));
    }];
    [self.bookMoneyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.payCount);
        make.left.equalTo(self.view.left).offset(10);
    }];
    [self.tablevView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.bottom.equalTo(self.payCount.top);
        make.left.right.equalTo(self.view);
    }];
}
#pragma mark
#pragma mark - TableView
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[
                     @"收货地址",@"狗狗信息", @"运费", @"订单总金额:", @"应付定金", @"剩余金额", @"备注"
                     ];
    }
    return _dataArr;
}
- (UITableView *)tablevView {
    if (!_tablevView) {
        _tablevView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tablevView.delegate = self;
        _tablevView.dataSource = self;
        _tablevView.bounces = NO;
        _tablevView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    }
    return _tablevView;
}
#pragma mark
#pragma mark - 代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellid];
    switch (indexPath.row) {
        case 0:
        {
//            if (cell ) { //如果默认值 添加view
//                
//            }
            cell.textLabel.text = self.dataArr[indexPath.row];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.cell3 = cell;
        }
            break;

        case 1:
        {
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            SellerAndDogCardView *sellerAnddog = [[SellerAndDogCardView alloc] init];
            sellerAnddog.backgroundColor = [UIColor whiteColor];
            [cell addSubview:sellerAnddog];

            [sellerAnddog makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(UIEdgeInsetsMake(10, 0, 10, 0));
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
            break;
        case 2:
        {
            cell.textLabel.text = self.dataArr[indexPath.row];
            cell.detailTextLabel.text = @"默认¥ 50";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];

            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case 3:
        {
            cell.textLabel.attributedText = [self getChoseAttributeString1:self.dataArr[indexPath.row] string2:@"¥ 7700（含运费50元）"];
            cell.detailTextLabel.text = @"直接下单";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            [btn setImage:[UIImage imageNamed:@"椭圆-1"] forState:(UIControlStateNormal)];
            [btn sizeToFit];
            [btn setImage:[UIImage imageNamed:@"圆角-对勾"] forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(choseBuyDogType:) forControlEvents:(UIControlEventTouchDown)];
            cell.accessoryView = btn;
            NSLog(@"%@", cell.accessoryView);
            
        }
            break;
        case 4:
        {
            cell.textLabel.attributedText = [self getAttributeWithString1:self.dataArr[indexPath.row] string2:@"¥ 500"];

        }
            break;
        case 5:
        {
            cell.textLabel.attributedText = [self getAttributeWithString1:self.dataArr[indexPath.row] string2:@"¥ 7200"];

        }
            break;
        case 6:
        {
            cell.backgroundView = [[UIView alloc] init];
            cell.backgroundView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
            
            [cell addSubview:self.noteTextView];
            [self.noteTextView makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
            }];
            
            
        }
            break;

        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 170;
    }else if (indexPath.row == 6){
        return 164;
    }
    
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)choseBuyDogType:(UIButton *)btn {
    btn.selected = !btn.selected;
    
    
}
#pragma mark
#pragma mark - 懒加载&Action

- (UILabel *)bookMoneyLabel {
    if (!_bookMoneyLabel) {
        _bookMoneyLabel = [[UILabel alloc] init];
        _bookMoneyLabel.attributedText = [self getAttributeWithString1:@"应付定金：" string2:@"¥ 500"];
    }
    return _bookMoneyLabel;
}
- (UIButton *)payCount {
    if (!_payCount) {
        _payCount = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [_payCount setTitle:@"结算" forState:(UIControlStateNormal)];
        [_payCount setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:(UIControlStateNormal)];
        [_payCount setBackgroundColor:[UIColor colorWithHexString:@"#99cc33"]];
        [_payCount addTarget:self action:@selector(clickPayBtnAction:) forControlEvents:(UIControlEventTouchDown)];
    }
    return _payCount;
}
- (void)clickPayBtnAction:(UIButton *)btn {
    
}
- (NSAttributedString *)getAttributeWithString1:(NSString *)text1 string2:(NSString *)text2 {
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text1 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:text2 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#ffa11a"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    [attribute appendAttributedString:attribute2];
    return attribute;
}
- (NSAttributedString *)getChoseAttributeString1:(NSString *)text1 string2:(NSString *)text2 {
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc] initWithString:text1 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    NSMutableAttributedString *attribute2 = [[NSMutableAttributedString alloc] initWithString:text2 attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#333333"], NSFontAttributeName:[UIFont systemFontOfSize:14]}];

    [attribute appendAttributedString:attribute2];
    return attribute;
}

#pragma mark
#pragma mark - 监听键盘方法
- (void)keyboardWasShown:(NSNotification*)aNotification {
    //键盘高度
    CGRect keyBoardFrame = [[[aNotification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = keyBoardFrame.size.height - 50;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.tablevView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top).offset(-h);
            make.bottom.equalTo(self.payCount.top).offset(h);
            make.left.right.equalTo(self.view);

        }];
    }];
}

-(void)keyboardWillBeHidden:(NSNotification*)aNotification {
    [UIView animateWithDuration:0.3 animations:^{
        [self.tablevView remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.top);
            make.bottom.equalTo(self.payCount.top);
            make.left.right.equalTo(self.view);

        }];
    }];
}


- (UITextView *)noteTextView {
    if (!_noteTextView) {
        _noteTextView  = [[UITextView alloc] init];
        _noteTextView.delegate = self;
        _noteTextView.backgroundColor = [UIColor whiteColor];
        _noteTextView.textColor = [UIColor colorWithHexString:@"#000000"];
        _noteTextView.font = [UIFont systemFontOfSize:14];
        _noteTextView.layer.cornerRadius = 5;
        _noteTextView.layer.masksToBounds = YES;
        _noteTextView.returnKeyType = UIReturnKeyDefault;
        
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = @"备注";
        placeLabel.textColor = [UIColor colorWithHexString:@"#999999"];
        placeLabel.font = [UIFont systemFontOfSize:14];
        placeLabel.frame = CGRectMake(5, 5, 30, 15);
        [_noteTextView addSubview:placeLabel];
        self.placeLabel = placeLabel;
    }
    return _noteTextView;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.text.length == 0) {
        self.placeLabel.text = @"备注";
    }else{
        self.placeLabel.text = @"";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
