//
//  ServiceViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/10/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "EaseMessageViewController.h"

@interface ServiceViewController : EaseMessageViewController

@property(nonatomic, strong) UITextField *textField; /**< 输入框 */

@property(nonatomic, strong) NSString *liverID; /**< 主播id */
@property(nonatomic, strong) NSString *liverImgUrl; /**< 主播头像 */
@property(nonatomic, strong) NSString *liverName; /**< 主播昵称 */
@end
