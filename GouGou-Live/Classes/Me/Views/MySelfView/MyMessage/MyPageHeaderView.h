//
//  MyPageHeaderView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageHeaderView : UIView
@property(nonatomic, assign) NSInteger fansCount; /**< 粉丝数 */
@property(nonatomic, assign) NSInteger commentCount; /**< 评论数 */
@property(nonatomic, assign) NSInteger pleasureCount; /**< 满意数 */

@property (nonatomic, strong) NSString *userImg; /**< 用户头像 */
@property (nonatomic, strong) NSString *userName; /**< 用户昵称 */
@property (nonatomic, assign) BOOL isReal; /**< 是否实名认证 */
@property (nonatomic, assign) BOOL isMentch; /**< 是否商家认证 */
@end
