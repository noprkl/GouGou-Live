//
//  ChoseShopAdressCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ChoseShopAdressCell.h"
#import "SellerAdressModel.h"
#import "MyShopAdressModel.h"
@interface ChoseShopAdressCell ()
@property (weak, nonatomic) IBOutlet UIButton *chosedBtn;
@property (weak, nonatomic) IBOutlet UILabel *shopOwner;
@property (weak, nonatomic) IBOutlet UILabel *shopPhone;
@property (weak, nonatomic) IBOutlet UILabel *AdressLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopAdress;

@end

@implementation ChoseShopAdressCell
- (IBAction)clickChosedBtnAction:(UIButton *)sender {
   
}

- (void)awakeFromNib {
    // Initialization code
}
- (void)setAcceptAdress:(MyShopAdressModel *)acceptAdress {
    _acceptAdress = acceptAdress;
    self.shopOwner.text = acceptAdress.userName;
    self.shopPhone.text = acceptAdress.userTel;
    NSString *adress = [NSString stringWithFormat:@"%@,%@,%@,%@", acceptAdress.userProvince, acceptAdress.userCity, acceptAdress.userDistrict, acceptAdress.userAddress];
    self.shopAdress.text = adress;
    if (acceptAdress.isDefault == 1) {
        self.chosedBtn.selected = YES;
    }else{
        self.chosedBtn.selected = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.chosedBtn.selected = selected;
}

@end
