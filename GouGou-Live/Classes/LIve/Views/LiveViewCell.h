//
//  LiveViewCell.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LiveViewCellModel;

@interface LiveViewCell : UITableViewCell

/** cell数据 */
@property (strong, nonatomic) LiveViewCellModel *liveCellModel;

@end
