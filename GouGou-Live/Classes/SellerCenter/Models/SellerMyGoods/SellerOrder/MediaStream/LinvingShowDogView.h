//
//  LinvingShowDogView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListDogInfoModel.h"

@protocol LiveListDogInfoModelDelegate <NSObject>
@required;
- (void)clickShowingDog:(LiveListDogInfoModel *)model;

@end

@interface LinvingShowDogView : UITableView

@property(nonatomic, strong) NSArray *dataArr; /**< 狗狗数据 */

@property (nonatomic, assign) id<LiveListDogInfoModelDelegate> showDelegate; /**< 点击代理 */

@end
