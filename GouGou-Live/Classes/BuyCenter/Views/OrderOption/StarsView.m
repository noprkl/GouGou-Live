//
//  StarsView.m
//  StarScoreDemo
//
//  Created by StarLord on 15/7/28.
//  Copyright (c) 2015年 xxx. All rights reserved.
//

#import "StarsView.h"
#import "StarView.h"

@interface StarsView()
//@property (nonatomic, strong) NSMutableArray *starViewArr;
/** 交易满意度 */
@property (strong,nonatomic) UILabel *staisfiledLabel;

@property (nonatomic, copy) NSMutableArray *starViewArr;
/** 星星 */
@property (strong,nonatomic) StarView *starView;
@end


@implementation StarsView

- (instancetype)initWithStarSize:(CGSize)size space:(CGFloat)space numberOfStar:(NSInteger)number{
    self = [super init];
    if (self) {
    
        [self addSubview:self.staisfiledLabel];
        
        _selectable = YES;
        _starViewArr = [NSMutableArray array];
        
        for (int i = 0; i < number; i ++) {
            StarView *starView = [[StarView alloc] initWithFrame:CGRectMake((space + size.width) * i + 90, 15, size.width, size.height)];
            starView.percent = 0;
//            starView.percent = 1.0;
            starView.backgroundColor = [UIColor clearColor];
            [self addSubview:starView];
            [_starViewArr addObject:starView];
        }
    }
    return self;
}
#pragma mark
#pragma mark - 约束
- (void)layoutSubviews {
    [super layoutSubviews];
    
    __weak typeof(self) weakself = self;
    
    [_staisfiledLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(weakself.left).offset(10);
        make.top.equalTo(weakself.top).offset(10);
        make.centerY.equalTo(weakself.centerY);
    }];
    
}

#pragma mark
#pragma mark - 懒加载

- (UILabel *)staisfiledLabel {

    if (!_staisfiledLabel) {
        _staisfiledLabel = [[UILabel alloc] init];
        _staisfiledLabel.text = @"交易满意度";
        _staisfiledLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _staisfiledLabel.font = [UIFont systemFontOfSize:14];

    }
    return _staisfiledLabel;
}

- (void)setScore:(CGFloat)score{
    _score = score;
    if (score >= _starViewArr.count) {
        _score = _starViewArr.count;
    }else if(score <= 0){
        _score = 0;
    }
    
    NSInteger index = (NSInteger)_score;
    StarView *starView = index == _starViewArr.count?nil:_starViewArr[index];
    
    for (int i = 0; i < _starViewArr.count; i ++) {
        StarView *star = _starViewArr[i];
        if (i < index) {
            star.percent = 1.0;
        }else if(i > index){
            star.percent = 0.0;
        }else{
            CGFloat percent = _score - index;
            starView.percent = percent;
        }
    }
}

- (void)handleTouches:(NSSet *)touches{
    if (!_selectable) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    StarView *starView;
    for (StarView *star in _starViewArr) {
        if (star.frame.origin.x <= point.x && star.frame.origin.x + star.frame.size.width >= point.x) {
            starView = star;
            break;
        }
    }
    
    if (!starView) {
        return;
    }
    // 当前选中星星的索引位置
    NSInteger index = [_starViewArr indexOfObject:starView];
    // 记录星星个数
    self.startCount = index + 1;
//    DLog(@"%ld",index);
    for (int i = 0; i < _starViewArr.count; i ++) {
        
        StarView *star = _starViewArr[i];
        
        if (i < index) {
            star.percent = 1.0;
        }else if(i > index){
            star.percent = 0.0;
        }else{
            if(_supportDecimal){
                CGFloat percent = (point.x - starView.frame.origin.x)/starView.frame.size.width;
                starView.percent = percent;

            }else{
                starView.percent = 1.0;
            }
      
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTouches:touches];
}


@end
