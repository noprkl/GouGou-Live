//
//  MyFocusTableCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyFocusTableCell.h"
#import "FocusAndFansModel.h"

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
- (void)setModel:(FocusAndFansModel *)model {
    _model = model;
//    if (model.userImgUrl) {
//        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.userImgUrl];
//        [self.userIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
//
//    }else{
//        self.userIconView.image = [UIImage imageNamed:@"头像"];
//    }
    if (model.userImgUrl != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.userImgUrl];
        [self.userIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }else{
        self.userIconView.image =[UIImage imageNamed:@"头像"];
    }
    
    self.userNameLabel.text = model.userNickName;
    self.userSignLabel.text = model.userMotto;
    // 判断model的id是否在列表中，如果是就选中，没有就选不中
    
}
- (IBAction)clickSelectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (_selectBlock) {
        _selectBlock(sender.selected);
    }
}
- (void)setIsHid:(BOOL)isHid {
  
    // 在查看其它人的列表时需要用到这个
    self.selectBtn.hidden = isHid;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
