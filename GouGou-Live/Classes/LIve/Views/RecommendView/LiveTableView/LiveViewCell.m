//
//  LiveViewCell.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveViewCell.h"
#import "LiveViewCellModel.h"
#import "DogCardView.h"

@interface LiveViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *anchorIconView;
@property (weak, nonatomic) IBOutlet UILabel *anchorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *anchorCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *watchCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *roomImageView;
@property (weak, nonatomic) IBOutlet UILabel *roomMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *certificateLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *dogCardScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *liveStateIcon;

@end

@implementation LiveViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dogCardScrollView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    
    self.anchorCityLabel.font = [UIFont systemFontOfSize:12];
    self.anchorNameLabel.font = [UIFont systemFontOfSize:14];
    self.certificateLabel.font = [UIFont systemFontOfSize:12];
    self.anchorNameLabel.font = [UIFont systemFontOfSize:14];
    self.roomMessageLabel.font = [UIFont systemFontOfSize:12];
}
- (void)clickCardViewAction:(UIControl *)control {
    if (_cardBlcok) {
        _cardBlcok(control);
    }
}
- (void)setLiveCellModel:(LiveViewCellModel *)liveCellModel {
    
    _liveCellModel = liveCellModel;
    self.roomMessageLabel.text = liveCellModel.name;
    if (liveCellModel.area.length != 0) {
        self.anchorCityLabel.text = liveCellModel.area;
    }else{
        self.anchorCityLabel.text = @"";
    }
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    self.watchCountLabel.text = liveCellModel.viewNum;
    
    if (liveCellModel.userImgUrl != NULL) {
        NSString *urlString = [IMAGE_HOST stringByAppendingString:liveCellModel.userImgUrl];
        [self.anchorIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
    }
    self.anchorNameLabel.text = liveCellModel.merchantName;
    if (liveCellModel.snapshot.length != 0) {
        [self.roomImageView sd_setImageWithURL:[NSURL URLWithString:liveCellModel.snapshot] placeholderImage:[UIImage imageNamed:@"直播图"]];
    }
    if ([liveCellModel.status isEqualToString:@"1"]) {
        self.liveStateIcon.image = [UIImage imageNamed:@"直播中"];
    }else if ([liveCellModel.status isEqualToString:@"3"]){
        self.liveStateIcon.image = [UIImage imageNamed:@"回放"];
    }
    
}
- (void)setDogInfos:(NSArray *)dogInfos {
    NSArray *subArr = [self.dogCardScrollView subviews];
    for (UIView *subview in subArr) {
        [subview removeFromSuperview];
    }
    self.dogCardScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.01);
    [self.dogCardScrollView setContentOffset:CGPointMake(0, 0)];
    
    _dogInfos = dogInfos;
    if (self.liveCellModel.pNum == 0) {
        self.dogCardScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.01);
    }if (self.liveCellModel.pNum == 1) {
        DogCardView *cardView = [[DogCardView alloc] init];
        cardView.dogInfo = dogInfos[0];
        cardView.message = [NSString stringWithFormat:@"1/1"];
        cardView.imageName = @"一个的长度";
        cardView.backgroundColor = [UIColor whiteColor];
        cardView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 108);
        self.dogCardScrollView.contentSize = CGSizeMake(0, 0);

        cardView.tag = 0 + 50;
        [cardView addTarget:self action:@selector(clickCardViewAction:) forControlEvents:(UIControlEventTouchDown)];
        [self.dogCardScrollView addSubview:cardView];
    } else {
        NSInteger count = dogInfos.count;

        CGFloat w = 300;
        CGFloat h = 108;
        CGFloat x = 0;
        CGFloat y = 0;
        
        self.dogCardScrollView.contentSize = CGSizeMake(count * (300 + 0), 0);
        for (NSInteger i = 0; i < count; i ++) {
            x = i * (w + 0);
            
            DogCardView *cardView = [[DogCardView alloc] init];
            cardView.dogInfo = dogInfos[i];
            cardView.message = [NSString stringWithFormat:@"%ld/%ld", i + 1, count];
            cardView.imageName = @"狗狗卡牌背景";
            cardView.backgroundColor = [UIColor whiteColor];
            
            cardView.frame = CGRectMake(x, y, w, h);
            
            cardView.tag = i + 50;
//            cardView.layer.cornerRadius = 5;
//            cardView.layer.masksToBounds = YES;
//            [cardView addTarget:self action:@selector(clickCardViewAction:) forControlEvents:(UIControlEventTouchDown)];
            [self.dogCardScrollView addSubview:cardView];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
