//
//  PicturesCell.m
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PicturesCell.h"
#import "MyPictureListModel.h"

@interface PicturesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImage;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation PicturesCell
- (IBAction)clickSelectBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (_selectBlock) {
        _selectBlock();
    }
}
- (void)setModel:(MyPictureListModel *)model {
    _model = model;
    NSString *urlString = [IMAGE_HOST stringByAppendingString:model.pathBig];
    [self.pictureImage sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
}

- (void)setIsHid:(BOOL)isHid {
    _isHid = isHid;
    
    self.selectBtn.hidden = isHid;
}
- (void)setIsAllSelect:(BOOL)isAllSelect {
    _isAllSelect = isAllSelect;
    self.selectBtn.selected = isAllSelect;
}
- (void)awakeFromNib {
    // Initialization code
}

@end
