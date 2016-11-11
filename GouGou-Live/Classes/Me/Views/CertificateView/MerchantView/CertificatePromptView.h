//
//  CertificatePromptView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCertificateBtnBlock)();

typedef void(^CountdownBlock)(UIButton * btn);

@interface CertificatePromptView : UIView
/** 点击实名认证回调 */
@property (strong,nonatomic) ClickCertificateBtnBlock certificateBlack;

/** 倒计时回调 */
@property (strong,nonatomic) CountdownBlock countdownBlock;

@end
