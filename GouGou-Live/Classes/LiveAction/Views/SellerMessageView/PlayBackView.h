//
//  PlayBackView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayBackModel.h"

typedef void(^ClickPlayBackCellBlock)(PlayBackModel *model);
@interface PlayBackView : UITableView

@property (nonatomic, strong) ClickPlayBackCellBlock playBackBlock; /**< 点击回调 */
@property (nonatomic, strong) NSArray *AVArray; /**< 播放数组 */

@end
