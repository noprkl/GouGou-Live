//
//  ShareAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^MainTopBlock)(NSInteger btnTag);

typedef void(^CancelBtnBlock)();

@interface ShareAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame alertModels:(NSArray *)btnModelPlist tapView:(MainTopBlock)tapBlock colCount:(int)colCount;


/** 数据 */
@property (strong, nonatomic) NSArray *dataPlist;
@property (nonatomic, assign) BOOL isDismiss;
- (void)show;
- (void)dismiss;
@end
