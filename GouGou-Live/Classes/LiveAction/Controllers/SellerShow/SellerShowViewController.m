//
//  SellerShowViewController.m
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "SellerShowViewController.h"
#import "SellerMessageView.h"
#import "PlayBackView.h" // 回放
#import "DogTypeCellModel.h"
#import "PicturesView.h" // 相册

@interface SellerShowViewController ()

@property(nonatomic, strong) UIScrollView *baseScrollView; /**< 滚动view */
@property(nonatomic, strong) SellerMessageView *messageView; /**< 认证信息 */
@property(nonatomic, strong) PlayBackView *playbackView; /**< 回放 */

@property(nonatomic, strong) PicturesView *picturesView; /**< 相册 */

@property(nonatomic, strong) NSArray *dogCardArr; /**< 回放信息卡数组 */

@property(nonatomic, strong) NSArray *picturesArr; /**< 相册数组 */

@end

@implementation SellerShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationBarHidden = YES;
}
#pragma mark
#pragma mark - 约束布局
- (void)initUI {
    [self.view addSubview:self.baseScrollView];
    [self.baseScrollView addSubview:self.messageView];
    [self.baseScrollView addSubview:self.playbackView];
    
    
    [self.messageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseScrollView.top).offset(1);
        make.left.equalTo(self.view.left);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 220));
    }];
  
    CGFloat playbackViewHeight = 0;
    if (self.dogCardArr.count == 0) {
       playbackViewHeight = 33 + 30;;
    }else{
        playbackViewHeight = self.dogCardArr.count * 125 + 43;
    }
    
    [self.playbackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.messageView.bottom).offset(10);
        make.left.right.equalTo(self.view);
        make.height.equalTo(playbackViewHeight);
    }];
    CGFloat picturesHeight = 0;
   
    if (self.picturesArr.count != 0) {
        [self.view addSubview:self.picturesView];
        [self.picturesView makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.playbackView.bottom).offset(10);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 200));
            make.left.equalTo(self.view.left);
        }];
        picturesHeight = 10 + 200;
    }
    _baseScrollView.contentSize = CGSizeMake(0, 220 + kDogImageWidth + playbackViewHeight + 10 + picturesHeight);
    
    
    NSArray *arr = self.picturesView.subviews;
    for (NSInteger i = 0; i < arr.count; i ++) {
        if ([arr[i] isKindOfClass:[UIButton class]]) {
            UIButton *btn = arr[i];
            btn.hidden = NO;
        }
    }
    
}
#pragma mark
#pragma mark - 懒加载
- (NSArray *)dogCardArr {
    if (!_dogCardArr) {
        _dogCardArr = [NSArray array];
        
        DogTypeCellModel *cardModel1 = [[DogTypeCellModel alloc] initWithDogIcon:@"banner" focusCount:@"1000" dogDesc:@"纯种拉布拉多犬" anchorName:@"逗逼" showCount:@"5" onSailCount:@"8"];
        DogTypeCellModel *cardModel2 = [[DogTypeCellModel alloc] initWithDogIcon:@"banner" focusCount:@"1000" dogDesc:@"纯种拉布拉多犬" anchorName:@"逗逼" showCount:@"5" onSailCount:@"8"];
       
        _dogCardArr = @[cardModel1, cardModel2];
    }
    return _dogCardArr;
}
- (NSArray *)picturesArr {
    if (!_picturesArr) {
        _picturesArr = [NSArray array];
        _picturesArr = @[@"品种", @"品种"];
    }
    return _picturesArr;
}
- (PlayBackView *)playbackView {
    if (!_playbackView) {
        _playbackView = [[PlayBackView alloc] initWithFrame:CGRectZero withPlayBackMessage:self.dogCardArr clickPlaybackBtn:^(NSInteger btnTag){
            
            if (self.dogCardArr.count == 0) {
                
            }else{
                switch (btnTag) {
                    case 0:
                        DLog(@"第一个回放");
                        break;
                    case 1:
                        DLog(@"第二个回放");
                        break;

                    default:
                        break;
                }
            }
            
        }];

        _playbackView.backgroundColor = [UIColor whiteColor];

    }
    return _playbackView;
}
- (PicturesView *)picturesView {
    if (!_picturesView) {
        _picturesView = [[PicturesView alloc] initWithFrame:CGRectZero withpictures:self.picturesArr];
        _picturesView.backgroundColor = [UIColor whiteColor];
    }
    return _picturesView;
}
- (SellerMessageView *)messageView {
    if (!_messageView) {
        _messageView = [[SellerMessageView alloc] init];
        _messageView.backgroundColor = [UIColor whiteColor];
        _messageView.focusBlock = ^(){
            DLog(@"关注");
        };
    }
    return _messageView;
}

- (UIScrollView *)baseScrollView {
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 290)];
        _baseScrollView.backgroundColor = [UIColor colorWithHexString:@"#e0e0e0"];
       
        _baseScrollView.showsHorizontalScrollIndicator = NO;
        _baseScrollView.showsVerticalScrollIndicator = NO;
    }
    return _baseScrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
