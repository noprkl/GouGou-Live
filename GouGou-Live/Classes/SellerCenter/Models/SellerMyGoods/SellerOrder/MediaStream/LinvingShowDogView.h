//
//  LinvingShowDogView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListDogInfoModel.h"

typedef void(^ClickCellBlock)(LiveListDogInfoModel *model);
@interface LinvingShowDogView : UITableView

@property(nonatomic, strong) NSArray *dataArr; /**< 狗狗数据 */

@property (nonatomic, strong) ClickCellBlock cellBlock; /**< 点击cell */

@end
