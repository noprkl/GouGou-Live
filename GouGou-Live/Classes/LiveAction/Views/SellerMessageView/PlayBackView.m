//
//  PlayBackView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "PlayBackView.h"
#import "PlayBackCard.h"

@interface PlayBackView ()

@property(nonatomic, strong) UILabel *playBcakLabel; /**< 回放 */


@property(nonatomic, strong) ClickPlayBackBtnBlcok playBackBlock; /**< 点击卡片回调 */


@property(nonatomic, strong) UILabel *alertLabel; /**< 如果没有回放提示 */

@end

@implementation PlayBackView
- (instancetype)initWithFrame:(CGRect)frame withPlayBackMessage:(NSArray *)playbackMessages clickPlaybackBtn:(ClickPlayBackBtnBlcok)playbackBlock {
    if (self = [super init]) {
        
        self.playBackBlock = playbackBlock;
        
        [self addSubview:self.playBcakLabel];
       
        if (playbackMessages.count == 0) {
            [self addSubview:self.alertLabel];
            [self.alertLabel makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.centerX);
                make.top.equalTo(self.playBcakLabel.bottom).offset(10);
            }];
            
        }else{
            CGFloat x = 0;
            CGFloat h = 125;
            CGFloat y = 43;
            CGFloat margin = kDogImageWidth;
            
            for (NSInteger i = 0; i < playbackMessages.count; i ++) {
                
                y += i * (h + margin);
                
                PlayBackCard *card = [[PlayBackCard alloc] initWithFrame:CGRectMake(x, y, SCREEN_WIDTH, h)];
                card.dogCardModel = playbackMessages[i];
                
                card.tag = i + 40;
                [card addTarget:self action:@selector(clickPlayBackCardAction:) forControlEvents:(UIControlEventTouchUpInside)];
                
                [self addSubview:card];
            }
        }
    }
    return self;
}
- (void)clickPlayBackCardAction:(UIButton *)btn {

    if (_playBackBlock) {
        _playBackBlock(btn.tag - 40);
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.playBcakLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(self.top).offset(10);
    }];
    
}
#pragma mark
#pragma mark - 懒加载
- (UILabel *)playBcakLabel {
    if (!_playBcakLabel) {
        _playBcakLabel = [[UILabel alloc] init];
        _playBcakLabel.text = @"回放";
        _playBcakLabel.font = [UIFont systemFontOfSize:16];
        _playBcakLabel.textColor = [UIColor colorWithHexString:@"#000000"];
    }
    return _playBcakLabel;
}
- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] init];
        _alertLabel.text = @"暂时没有回放";
        _alertLabel.font = [UIFont systemFontOfSize:16];
        _alertLabel.textColor = [UIColor colorWithHexString:@"#666666"];

    }
    return _alertLabel;
}
@end
