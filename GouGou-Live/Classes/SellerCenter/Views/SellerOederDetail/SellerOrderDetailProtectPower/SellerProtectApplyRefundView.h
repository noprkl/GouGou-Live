//
//  SellerProtectApplyRefundView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DogImageView.h"

@interface SellerProtectApplyRefundView : UIView


@property(nonatomic, strong) UILabel *applyRefund; /**< 申请退款 */

@property(nonatomic, strong) UILabel *applyRefundCount; /**< 款数 */

@property(nonatomic, strong) DogImageView *pictures; /**< 图片个数 */

@property(nonatomic, strong) UILabel *reasonLabel; /**< 退款理由 */

@property(nonatomic, strong) NSArray *pictureArr; /**< 图片数组 */

@end
