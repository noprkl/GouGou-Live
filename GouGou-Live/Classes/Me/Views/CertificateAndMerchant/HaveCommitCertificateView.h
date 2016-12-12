//
//  HaveCommitCertificateView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/12.
//  Copyright © 2016年 LXq. All rights reserved.
//  已经提交信息 审核中

#import <UIKit/UIKit.h>

typedef void(^ClickBackButtonBlock)();

@interface HaveCommitCertificateView : UIView

@property (nonatomic, strong) ClickBackButtonBlock backBlock; /**< 返回回调 */

@end
