//
//  NoinputSearchKindView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/30.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDogKindBlock)(NSString *kind);
typedef void(^ClickHistoryCellBlock)(NSString *kind);
@interface NoinputSearchKindView : UITableView

@property(nonatomic, strong) NSArray *hotArr; /**< 热门 */
@property(nonatomic, strong) NSArray *historyArr; /**< 历史数据 */
@property(nonatomic, strong) ClickDogKindBlock typeBlock; /**< 点击回调 */
@property(nonatomic, strong) ClickHistoryCellBlock cellBlock; /**< 点击cell */

@end
