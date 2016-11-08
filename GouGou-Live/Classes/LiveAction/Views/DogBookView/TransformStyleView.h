//
//  TransformStyleView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ClickCellBlock)(NSString *style);

@interface TransformStyleView : UITableView

/** detail数据 */
@property (strong, nonatomic) NSArray *detailPlist;

/** 点击cell回调 */
@property (strong, nonatomic) ClickCellBlock transformCellBlock;

- (void)show;
- (void)dismiss;

@end
