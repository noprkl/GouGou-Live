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
    NSString *adress = [NSString stringWithFormat:@"%@,%@,%@,%@,%@", acceptAdress.userProvince, acceptAdress.userCity, acceptAdress.userDistrict,acceptAdress.street, acceptAdress.userAddress];
    self.shopAdress.text = adress;
    if (acceptAdress.isDefault == 1) {
        self.AdressLabel.text = @"默认地址";
        self.AdressLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }else{
        self.AdressLabel.text = @"地址";
    }
}
- (void)setSendAdress:(SellerAdressModel *)sendAdress {
    _sendAdress = sendAdress;
    self.shopOwner.text = sendAdress.merchantName;
    self.shopPhone.text = sendAdress.merchantTel;
    NSString *adress = [NSString stringWithFormat:@"%@,%@,%@,%@", sendAdress.merchantProvince, sendAdress.merchantCity, sendAdress.merchantDistrict, sendAdress.merchantAddress];
    self.shopAdress.text = adress;
    if (sendAdress.isDefault == 1) {
        self.AdressLabel.text = @"默认地址";
        self.AdressLabel.textColor = [UIColor colorWithHexString:@"#ffa11a"];
    }else{
        self.AdressLabel.text = @"地址";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.chosedBtn.selected = selected;
}

@end
