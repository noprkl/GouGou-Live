//
//  SellerAndDogCardView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerAndDogCardView : UIView
@property(nonatomic, strong) UIImageView *sellerIconView; /**< 主播头像 */

@property(nonatomic, strong) UILabel *sellerName; /**< 主播名字 */

@property(nonatomic, strong) UILabel *dateLabel; /**< 时间戳 */

@property (strong, nonatomic)  UIImageView *dogImageView;/**< 狗狗图片*/

@property (strong, nonatomic)  UILabel *dogNameLabel;/**< 狗狗名字 */


@property (strong, nonatomic)  UILabel *dogKindLabel;/**< 狗狗种类 */
@property (strong, nonatomic)  UILabel *dogAgeLabel;/**< 狗狗年龄*/

@property (strong, nonatomic)  UILabel *dogSizeLabel;/**< 狗狗体型*/

@property (strong, nonatomic)  UILabel *dogColorLabel;/**< 狗狗颜色*/

@property (strong, nonatomic)  UILabel *nowPriceLabel;/**< 狗狗价格*/
@property (strong, nonatomic)  UILabel *oldPriceLabel;/**< 狗狗老价格*/
@end
