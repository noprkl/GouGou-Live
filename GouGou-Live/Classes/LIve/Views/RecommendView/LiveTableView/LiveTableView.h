//
//  LiveTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveViewCellModel.h"

typedef void(^ClickLiveCellBlock)(LiveViewCellModel *model);
typedef void(^ClickDogCardBlock)(LiveViewCellModel *model);
@interface LiveTableView : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickLiveCellBlock cellBlock;
/** 点击cell回调 */
@property (strong, nonatomic) ClickDogCardBlock dogCardBlock;

/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataPlist;

@end
