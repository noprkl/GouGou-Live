//
//  WatchHistoryCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayBackModel.h"

typedef void(^ClickDeleBtnBlock)();

@interface WatchHistoryCell : UITableViewCell

@property (nonatomic, strong) ClickDeleBtnBlock deleBlock; /**< 删除回调 */

@property (nonatomic, strong) PlayBackModel *model; /**< 模型 */

@end
