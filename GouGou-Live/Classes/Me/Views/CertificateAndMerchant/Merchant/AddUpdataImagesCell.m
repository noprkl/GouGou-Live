//
//  AddUpdataImagesCell.m
//  Test1
//
//  Created by ma c on 16/11/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "AddUpdataImagesCell.h"

@interface AddUpdataImagesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
@implementation AddUpdataImagesCell
- (IBAction)clickDeleteBtnAction:(UIButton *)sender {
    if (_deleteBlock) {
        _deleteBlock();
    }
}
- (void)setImage:(UIImage *)image {
    _image = image;
    self.iconView.image = image;
}
- (void)awakeFromNib {
    // Initialization code
   
}

@end
