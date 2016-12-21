//
//  SellerMessageView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickFocusBtnBlock)(UIButton *focusBtn);
@interface SellerMessageView : UIView

@property(nonatomic, strong) ClickFocusBtnBlock focusBlock; /**< 关注回调 */

@property(nonatomic, assign) NSInteger fansCount; /**< 粉丝数 */
@property(nonatomic, assign) NSInteger commentCount; /**< 评论数 */
@property(nonatomic, assign) NSInteger pleasureCount; /**< 满意数 */

@property (nonatomic, strong) NSString *userImg; /**< 用户头像 */
@property (nonatomic, strong) NSString *userName; /**< 用户昵称 */


- (CGFloat)getMessageHeight;

@end
