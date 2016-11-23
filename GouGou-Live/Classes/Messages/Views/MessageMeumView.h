//
//  MessageMeumView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//  消息侧边弹窗

#import <UIKit/UIKit.h>

typedef void(^ClickMessageMeumBlock)(NSString *string);
@interface MessageMeumView : UITableView

@property(nonatomic, strong) ClickMessageMeumBlock cellBlock; /**< 点击回调 */

@property(nonatomic, strong) NSArray *dataPlist; /**< 数据 */

@end
