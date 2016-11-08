//
//  MyFocusTableCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyFocusTableCell.h"

@interface MyFocusTableCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSignLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;


@end

@implementation MyFocusTableCell

- (void)awakeFromNib {
    // Initialization code
}
- (IBAction)clickSelectBtn:(UIButton *)sender {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
