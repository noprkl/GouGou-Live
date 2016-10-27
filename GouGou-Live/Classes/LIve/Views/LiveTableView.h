//
//  LiveTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCellBlock)();

@interface LiveTableView : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickCellBlock cellBlock;

/** 数据源 */
@property (strong, nonatomic) NSMutableArray *dataPlist;

@end
