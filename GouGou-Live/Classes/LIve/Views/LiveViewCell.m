//
//  LiveViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveViewCell.h"
#import "LiveViewCellModel.h"


@interface LiveViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *anchorIconView;

@property (weak, nonatomic) IBOutlet UILabel *anchorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *anchorCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *roomImageView;
@property (weak, nonatomic) IBOutlet UILabel *roomMessageLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *dogCardScrollView;

@end

@implementation LiveViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setLiveCellModel:(LiveViewCellModel *)liveCellModel {
    
    _liveCellModel = liveCellModel;
    
    self.anchorIconView.image = [UIImage imageNamed:@"头像"];
    self.anchorNameLabel.text = @"主播名字";
    self.anchorCityLabel.text = @"主播城市";
    self.roomImageView.image = [UIImage imageNamed:@"直播图"];
    self.roomMessageLabel.text = @"房间信息";
    self.watchCountLabel.text = @"观看人数";
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
