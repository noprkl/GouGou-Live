//
//  UnCertificateVIew.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCertificateBtnBlock)();

@interface UnCertificateVIew : UIView
/** 点击实名认证回调 */
@property (strong,nonatomic) ClickCertificateBtnBlock certificateBlack;

@end
