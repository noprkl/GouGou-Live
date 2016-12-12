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

@property (weak, nonatomic) IBOutlet UIScrollView *dogCardScrollView;

@end

@implementation LiveViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
//        CGFloat w = 600;
//        CGFloat h = 93;
//        CGFloat x = 0;
//        CGFloat y = 10;
//
//        for (NSInteger i = 0; i < 5; i ++) {
//            x = i * (w + 10);
//            
//            DogCardView *cardView = [[DogCardView alloc] init];
//            cardView.frame = CGRectMake(x, y, w, h);
//            [self.dogCardScrollView addSubview:cardView];
//        }
        self.dogCardScrollView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
    self.dogCardScrollView.contentSize = CGSizeMake(5 * (300 + 10), 0);
    
    CGFloat w = 300;
    
    CGFloat h = 93;
    
    CGFloat x = 10;
    
    CGFloat y = 10;
    
    
    for (NSInteger i = 0; i < 5; i ++) {
        
        x = i * (w + 10);
        
        DogCardView *cardView = [[DogCardView alloc] init];
        cardView.message = [NSString stringWithFormat:@"%ld/5", i + 1];
        cardView.backgroundColor = [UIColor whiteColor];
        cardView.frame = CGRectMake(x, y, w, h);
        
        cardView.tag = i + 50;
        [cardView addTarget:self action:@selector(clickCardViewAction:) forControlEvents:(UIControlEventTouchDown)];
        [self.dogCardScrollView addSubview:cardView];
    }
    
}
- (void)clickCardViewAction:(UIControl *)control {
    if (_cardBlcok) {
        _cardBlcok(control);
    }
}
- (void)setLiveCellModel:(LiveViewCellModel *)liveCellModel {
    
    _liveCellModel = liveCellModel;
    self.roomMessageLabel.text = liveCellModel.name;
//    if (liveCellModel.area.length == 0) {
//        self.anchorCityLabel.text = liveCellModel.area;
//    }else{
//        self.anchorCityLabel.text = @"";
//    }
//    self.watchCountLabel.text = liveCellModel.viewNum;
    
//    if (liveCellModel.userImgUrl != NULL) {
//        NSString *urlString = [IMAGE_HOST stringByAppendingString:liveCellModel.userImgUrl];
//        [self.anchorIconView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"组-7"]];
//    }
//    self.anchorNameLabel.text = liveCellModel.userName;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
