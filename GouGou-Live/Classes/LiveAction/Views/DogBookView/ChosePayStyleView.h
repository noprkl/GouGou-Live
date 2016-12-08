//
//  ChosePayStyleView.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSizeCellBlock)(NSString *style);
typedef void(^ClickBottomBtnBlovk)(NSString *style);
@interface ChosePayStyleView : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickSizeCellBlock sizeCellBlock;

@property(nonatomic, strong) ClickBottomBtnBlovk bottomBlock; /**< 点击底部按钮回调 */

@property(nonatomic, strong) NSArray *dataArr; /**< 选择数组 */

@property(nonatomic, strong) NSString *title; /**< 提示 */

- (void)show;
- (void)dismiss;
@end
