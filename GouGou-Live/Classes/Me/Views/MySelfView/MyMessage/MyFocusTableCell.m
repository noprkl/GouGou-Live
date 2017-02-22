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
    if (model.userImgUrl != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.userImgUrl];
        [self.userIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }else{
        self.userIconView.image =[UIImage imageNamed:@"头像"];
    }
    
    self.userNameLabel.text = model.userNickName;
    
    if (model.userMotto.length != 0) {
        self.userSignLabel.text = model.userMotto;
    }else{
        self.userSignLabel.text = @"暂无简介..";
    }
}
- (void)setFanModel:(FanModel *)fanModel {
    _fanModel = fanModel;
    if (fanModel.userImgUrl != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:fanModel.userImgUrl];
        [self.userIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }else{
        self.userIconView.image =[UIImage imageNamed:@"头像"];
    }
    
    self.userNameLabel.text = fanModel.userNickName;
    
    if (fanModel.userMotto.length != 0) {
        self.userSignLabel.text = fanModel.userMotto;
    }else{
        self.userSignLabel.text = @"暂无简介..";
    }
    // 判断model的id是否在列表中，如果是就选中，没有就选不中
    if ([fanModel.state integerValue] == 1) {
        self.selectBtn.selected = YES;
    }else if ([fanModel.state integerValue] == 0){
        self.selectBtn.selected = NO;
    }
}
- (void)setSearchModel:(SearchFanModel *)searchModel {

    _searchModel = searchModel;
    if (searchModel.userImgUrl != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:searchModel.userImgUrl];
        [self.userIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"头像"]];
    }else{
        self.userIconView.image =[UIImage imageNamed:@"头像"];
    }
    
    self.userNameLabel.text = searchModel.userNickName;
    self.userSignLabel.text = searchModel.userMotto;
    // 判断model的id是否在列表中，如果是就选中，没有就选不中
    if ([searchModel.state integerValue] == 1) {
        self.selectBtn.selected = YES;
    }else if ([searchModel.state integerValue] == 0){
        self.selectBtn.selected = NO;
    }
}
- (IBAction)clickSelectBtn:(UIButton *)sender {
    
    if (_selectBlock) {
        sender.selected = !sender.selected;
        _selectBlock(sender.selected);
    }
}
- (void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    self.selectBtn.selected = isSelect;
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
