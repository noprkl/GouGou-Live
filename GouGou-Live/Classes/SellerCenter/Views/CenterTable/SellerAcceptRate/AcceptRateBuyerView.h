//
//  AcceptRateBuyerView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AcceptRateBuyerModel.h"

@interface AcceptRateBuyerView : UIView

@property(nonatomic, strong) AcceptRateBuyerModel *model; /**< 评价人模型 */

@property(nonatomic, strong) UIImageView *buyerIcon; /**< 买家头像 */

@property(nonatomic, strong) UILabel *buyerName; /**< 买家名字 */

@property(nonatomic, strong) UILabel *commentTime; /**< 评论时间 */

@property(nonatomic, strong) UILabel *commentContent; /**< 评论内容 */
@property(nonatomic, strong) UIView *line; /**< 线 */

@end
