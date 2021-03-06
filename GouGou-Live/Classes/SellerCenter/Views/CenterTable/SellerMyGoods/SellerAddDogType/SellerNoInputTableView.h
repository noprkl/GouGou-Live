//
//  SellerNoInputTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDogTypeClock)(DogCategoryModel *model);
typedef void(^ClickTypeCellBlock)(NSString *type);

@interface SellerNoInputTableView : UITableView

@property(nonatomic, strong) NSArray *hotArr; /**< 热门 */
@property(nonatomic, strong) NSArray *historyArr; /**< 历史数据 */
@property(nonatomic, strong) ClickDogTypeClock typeBlock; /**< 点击回调 */
@property(nonatomic, strong) ClickTypeCellBlock typeCellBlock; /**< 点击cell回调 */
@end
