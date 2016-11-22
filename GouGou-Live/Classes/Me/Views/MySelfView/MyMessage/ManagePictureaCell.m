//
//  ManagePictureaCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ManagePictureaCell.h"

@interface ManagePictureaCell ()
@property (weak, nonatomic) IBOutlet UIImageView *picturesImage;
@property (weak, nonatomic) IBOutlet UILabel *picturesName;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;

@end
@implementation ManagePictureaCell
- (IBAction)SelectedBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (_selectBlock) {
        _selectBlock();
    }
}
- (void)setIsHid:(BOOL)isHid {
    _isHid = isHid;
    
    self.selectedBtn.hidden = isHid;
}
- (void)setIsAllSelect:(BOOL)isAllSelect {
    _isAllSelect = isAllSelect;
    self.selectedBtn.selected = isAllSelect;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
