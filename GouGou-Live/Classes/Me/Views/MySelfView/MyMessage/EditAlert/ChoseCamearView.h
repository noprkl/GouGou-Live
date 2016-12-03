//
//  ChoseCamearView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSizeCellBlock)(NSString *size);
typedef void(^ClickBottomBtnBlovk)(NSString *size);
@interface ChoseCamearView : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickSizeCellBlock sizeCellBlock;

@property(nonatomic, strong) ClickBottomBtnBlovk bottomBlock; /**< 点击底部按钮回调 */


@property(nonatomic, strong) NSArray *dataArr; /**< 选择数组 */

- (void)show;
- (void)dismiss;
@end
