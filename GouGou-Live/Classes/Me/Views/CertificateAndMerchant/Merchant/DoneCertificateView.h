//
//  DoneCertificateView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickAdressBlock)();

@interface DoneCertificateView : UIView

/** 接受商品名称 */
@property (strong,nonatomic) UITextField *infoTextfiled;

@property(nonatomic, strong) UITextField *areasTextField; /**< 省市区地区 */

@property(nonatomic, strong) UITextField *adressTextField; /**< 详细地址 */

@property(nonatomic, strong) ClickAdressBlock areasBlock; /**< 区域 */

/** 接受邀请码 */
@property (strong,nonatomic) UITextField *phoneNumTextfiled; /**< 手机号 */

@end
