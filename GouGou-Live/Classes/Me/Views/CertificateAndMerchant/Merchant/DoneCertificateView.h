//
//  DoneCertificateView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneCertificateView : UIView

/** 接受商品名称 */
@property (strong,nonatomic) UITextField *infoTextfiled;
/** 接受邀请码 */
@property (strong,nonatomic) UITextField *phoneNumTextfiled;

@property(nonatomic, strong) UITextField *adressTextField; /**< 详细地址 */

@property(nonatomic, strong) UITextField *aresTextField; /**< 地区 */

@end
