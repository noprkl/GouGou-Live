//
//  PromptView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PlayingPasswardBlock)(UITextField *textfiled);

typedef void(^ClickSureButtonBlock)();

//@protocol SureButtonDelegate <NSObject>
//
//- (void)cilckSureButton:(UIButton *)button;
//@end

@interface PromptView : UIView

/** 监听密码输入block */
@property (strong, nonatomic) PlayingPasswardBlock playpsdBlock;
/** 监听确定按钮block */
@property (strong,nonatomic) ClickSureButtonBlock clickSureBtnBlock;
///** surebuttonDelegate */
//@property (strong,nonatomic) id<SureButtonDelegate>  SureDelegate ;

- (void)show;
- (void)dismiss;

@end
