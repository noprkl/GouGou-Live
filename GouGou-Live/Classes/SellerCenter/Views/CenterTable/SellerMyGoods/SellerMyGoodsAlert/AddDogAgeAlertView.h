//
//  AddDogAgeAlertView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^SelectSureButtonBlock)(NSInteger yearsOld);

@interface AddDogAgeAlertView : UIView

/** 选取颜色回调 */
@property (strong, nonatomic) SelectSureButtonBlock ageBlock;

- (void)show;
- (void)dismiss;

@end
