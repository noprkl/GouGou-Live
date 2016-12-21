//
//  ManagePictureaCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "ManagePictureaCell.h"
#import "MyAlbumsModel.h"

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
- (void)setModel:(MyAlbumsModel *)model {
    _model = model;
    if (model.pathSmall != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathSmall];
        [self.picturesImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    self.picturesName.text = [NSString stringWithFormat:@"%@(%@)", model.albumName, model.pNum];
}
- (void)awakeFromNib {
    // Initialization code
}

@end
