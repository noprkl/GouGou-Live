//
//  ConsigneeView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConsigneeView : UIView
//@property (copy, nonatomic) NSString *buyUserId;  /** 买家流水号 */
@property (copy, nonatomic) NSString *buyUserName; /**< 买家姓名 */
@property (copy, nonatomic) NSString *buyUserTel; /**< 买家电话 */
@property (copy, nonatomic) NSString *recevieProvince; /**< 买家所在省份 */
@property (copy, nonatomic) NSString *recevieCity; /**< 买家所在市、区 */
@property (copy, nonatomic) NSString *recevieDistrict; /**< 买家所在区、县 */
@property (copy, nonatomic) NSString *recevieAddress; /**< 买家地址 */
@end
